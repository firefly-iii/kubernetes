{{ define "backupJobSpec" }}
spec:
  containers:
  - name: {{ template "firefly-db.fullname" . }}-backup-job
    image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
    imagePullPolicy: IfNotPresent
    envFrom:
    {{- if not .Values.configs.existingSecret }}
    - configMapRef:
        name: {{ template "firefly-db.fullname" . }}-config
    {{- else }}
    - secretRef:
        name: {{ .Values.configs.existingSecret }}
    {{- end }}
    command:
    - /bin/sh
    - -c
    - |
      set -e
      echo "creating backup file"
      pg_dump -h $DBHOST -p $DBPORT -U $DBUSER --format=p --clean -d $DBNAME > /var/lib/backup/$DBNAME.sql
      {{- if eq .Values.backup.destination "pvc" }}
      gzip -c /var/lib/backup/$DBNAME.sql >/var/lib/backup/$DBNAME-$(date -Is).sql.gz
      while ! df -P . | awk 'NR==2 && $3 / $2 > 0.8 {exit 1}'; do
        rm "$(ls -1t /var/lib/backup/$DBNAME-*.sql.gz | tail -1)" || exit 1
        sync
      done
      {{- end }}
      ls -la
      {{- if eq .Values.backup.destination "http" }}
      if [ -z "$BACKUP_URL" ]; then
        echo "ERROR: BACKUP_URL is required when backup.destination is set to 'http'. Backup will not be uploaded, but remain in PVC."
      else
        apk update
        apk add curl
        echo "uploading backup file"
        curl -F "filename=@/var/lib/backup/${DBNAME}.sql" $BACKUP_URL || {
          echo "HTTP upload failed. Backup remains in PVC."
        }
      fi
      {{- end }}
      echo "done"
    volumeMounts:
      - name: backup-storage
        mountPath: /var/lib/backup
  restartPolicy: Never
  volumes:
    - name: backup-storage
      {{- if eq .Values.backup.destination "pvc" }}
      persistentVolumeClaim:
        claimName: {{ default (printf "%s-%s" (include "firefly-db.fullname" .) "backup-storage-claim") .Values.backup.pvc.existingClaim }}
      {{- else }}
      emptyDir: {}
      {{- end }}
{{ end }}

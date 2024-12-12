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
      ls -la
      {{- if eq .Values.backup.destination "http" }}
      apk update
      apk add curl
      echo "uploading backup file"
      curl -F "filename=@/var/lib/backup/${DBNAME}.sql" $BACKUP_URL
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

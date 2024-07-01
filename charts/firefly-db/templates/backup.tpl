{{ define "backupJobSpec" }}
spec:
  containers:
  - name: {{ template "firefly-db.fullname" . }}-backup-job
    image: alpine:3.13
    imagePullPolicy: IfNotPresent
    envFrom:
    - configMapRef:
        name: {{ template "firefly-db.fullname" . }}-config
    command:
    - /bin/sh
    - -c
    - |
      set -e
      apk update
      apk add curl
      apk add postgresql
      echo "creating backup file"
      pg_dump -h $DBHOST -p $DBPORT -U $DBUSER --format=p --clean -d $DBNAME > /var/lib/backup/$DBNAME.sql
      ls -la
      {{- if eq .Values.backup.destination "http" }}
      echo "uploading backup file"
      curl -F "filename=@/var/lib/backup/${DBNAME}.sql" $BACKUP_URL
      {{- end }}
      echo "done"
    volumeMounts:
      {{- with .Values.backup.extraVolumeMounts }}
        {{- toYaml . | nindent 10 }}
      {{- end }}
      {{- if .Values.backup.pvc.enabled }}
      - name: backup-storage
        mountPath: /var/lib/backup
      {{- end }}
  restartPolicy: Never
  volumes:
    {{- with .Values.backup.extraVolumes }}
      {{- toYaml . | nindent 2 }}
    {{- end }}
    {{- if .Values.backup.pvc.enabled }}
    - name: backup-storage
      persistentVolumeClaim:
        claimName: {{ default (printf "%s-%s" (include "firefly-db.fullname" .) "backup-storage-claim") .Values.backup.pvc.existingClaim }}
    {{- end }}
{{ end }}

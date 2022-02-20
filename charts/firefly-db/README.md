# firefly-db

![Version: 0.0.6](https://img.shields.io/badge/Version-0.0.6-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Installs a postgres db for Firefly III

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| morre | firefly-iii@mor.re |  |
## Source Code

* <https://github.com/firefly-iii/kubernetes/tree/main/charts/firefly-db>

## Upgrading

When a release introduces breaking changes, this section outlines the manual actions that need to be taken.

### From 0.0.2 to 0.0.3

The storage class and access modes have been changed to match more setups without the need for configuration. If you want to keep the old settings, set the following values:

```yaml
storage:
  class: nfs-client
  accessModes: ReadWriteMany
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backupSchedule | string | `"0 3 * * *"` |  |
| configs.BACKUP_URL | string | `""` |  |
| configs.DBHOST | string | `"firefly-firefly-db"` |  |
| configs.DBNAME | string | `"firefly"` |  |
| configs.DBPORT | string | `"5432"` |  |
| configs.DBUSER | string | `"firefly"` |  |
| configs.PGPASSWORD | string | `""` |  |
| configs.POSTGRES_HOST_AUTH_METHOD | string | `"trust"` |  |
| configs.POSTGRES_PASSWORD | string | `""` |  |
| configs.POSTGRES_USER | string | `"firefly"` |  |
| configs.RESTORE_URL | string | `""` |  |
| configs.TZ | string | `"Europe/Amsterdan"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"postgres"` |  |
| image.tag | string | `"10-alpine"` |  |
| storage.accessModes | string | `"ReadWriteOnce"` |  |
| storage.class | string | `nil` |  |
| storage.dataSize | string | `"1Gi"` |  |

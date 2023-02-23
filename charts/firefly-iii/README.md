# firefly-iii

![Version: 1.4.0](https://img.shields.io/badge/Version-1.4.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Installs Firefly III
**Homepage:** <https://www.firefly-iii.org/>
## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| morremeyer | <firefly-iii@mor.re> |  |
## Source Code

* <https://github.com/firefly-iii/firefly-iii/>

## Setting environment variables from additional ConfigMaps and Secrets

This enables a simplified syntax to set envirnoment variables from a ConfigMap or Secret:

```yaml
envValueFrom:
  USER:
    secretKeyRef:
      name: secret-name
      key: user
```

## Upgrading

When a release introduces breaking changes, this section outlines the manual actions that need to be taken.

### From 0.0.4 to 1.0.0

This version bump is a full rework of the chart to be in line with current helm best practices and to add configurability. See the subsections for all changes.

A cronjob has been added to support [Firefly III features that need it](https://docs.firefly-iii.org/firefly-iii/advanced-installation/cron/). It is disabled by default, set `cronjob.enabled` to true to enable it. Please note that you need to specify `cronjob.auth.token` or `cronjob.auth.existingSecret` so that the job is actually deployed an can run. If you specify an existingSecret, it needs to have the token in the field `token`.

#### Resources

The PVC has been renamed. You therefore need to manually back up and restore the upload data or retain and reclaim the PV with the new PVC. As this is highly dependant on your Kubernetes distribution and provider, instructions for the latter can't be generalized.

To backup and restore your files easily, use `kubectl cp $FIREFLY_POD_NAME:/var/www/html/storage/upload $LOCAL_BACKUP_DIR`, apply the changes and then reverse the process by running `kubectl cp "${LOCAL_BACKUP_DIR}/*" $FIREFLY_POD_NAME:/var/www/html/storage/upload/`.

#### values.yaml

The configuration has changed as follows:

* `storage` has been moved to `persistence`. There's a new `persistence.enabled` value that is `true` by default.
* `storage.dataSize` has been moved to `persistence.storage`.
* `hostName` has moved to a list in `ingress.hosts`
* The ingress is disabled by default. Set `ingress.enabled` to `true` to enable it
* `configs` has moved to `config.env`
* A new key `config.existingSecret` has been added. It references a secret where you can store Firefly III configuration environment variables. Environment variables specified in the secret override the ones in `config.env`.

#### Labels

The pod label keys have changed as follows:

* `app` has been replaced by `app.kubernetes.io/name`
* `chart` has been replaced by `helm.sh/chart`
* `release` has been replaced by `app.kubernetes.io/instance`
* `heritage` has been replaced by `app.kubernetes.io/managed-by`

### From 0.0.3 to 0.0.4

The storage class and access modes have been changed to match more setups without the need for configuration. If you want to keep the old settings, set the following values:

```yaml
storage:
  class: nfs-client
  accessModes: ReadWriteMany
```

### From 0.0.2 to 0.0.3

The Ingress annotations have been made configurable. To keep the annotations set in 0.0.2, add the following to your values:

```yaml
ingress:
  annotations:
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/proxy-buffer-size: "16k"
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| config | object | `{"env":{"DB_CONNECTION":"pgsql","DB_DATABASE":"firefly","DB_PORT":"5432","DB_USERNAME":"firefly","DEFAULT_LANGUAGE":"en_US","DEFAULT_LOCALE":"equal","TRUSTED_PROXIES":"**","TZ":"Europe/Amsterdam"},"envValueFrom":{},"existingSecret":""}` | Environment variables for Firefly III. See docs at: https://github.com/firefly-iii/firefly-iii/blob/main/.env.example |
| config.env | object | `{"DB_CONNECTION":"pgsql","DB_DATABASE":"firefly","DB_PORT":"5432","DB_USERNAME":"firefly","DEFAULT_LANGUAGE":"en_US","DEFAULT_LOCALE":"equal","TRUSTED_PROXIES":"**","TZ":"Europe/Amsterdam"}` | Directly defined environment variables. Use this for non-secret configuration values. |
| config.envValueFrom | object | `{}` | Set environment variables from configMaps or Secrets |
| config.existingSecret | string | `""` | Set this to the name of a secret to load environment variables from. If defined, values in the secret will override values in config.env |
| cronjob | object | `{"affinity":{},"annotations":{},"auth":{"existingSecret":"","secretKey":"token","token":""},"enabled":false,"failedJobsHistoryLimit":1,"image":{"pullPolicy":"IfNotPresent","repository":"curlimages/curl","tag":"7.81.0"},"imagePullSecrets":[],"nodeSelector":{},"podAnnotations":{},"podSecurityContext":{},"resources":{},"restartPolicy":"OnFailure","schedule":"0 3 * * *","securityContext":{},"successfulJobsHistoryLimit":3,"tolerations":[]}` | A cronjob for [recurring Firefly III tasks](https://docs.firefly-iii.org/firefly-iii/advanced-installation/cron/). |
| cronjob.annotations | object | `{}` | Annotations for the CronJob |
| cronjob.auth | object | `{"existingSecret":"","secretKey":"token","token":""}` | Authorization for the CronJob. See https://docs.firefly-iii.org/firefly-iii/advanced-installation/cron/#request-a-page-over-the-web |
| cronjob.auth.existingSecret | string | `""` | The name of a secret containing a data.token field with the cronjob token |
| cronjob.auth.secretKey | string | `"token"` | The name of the key in the existing secret to get the cronjob token from |
| cronjob.auth.token | string | `""` | The token in plain text |
| cronjob.enabled | bool | `false` | Set to true to enable the CronJob. Note that you need to specify either cronjob.auth.existingSecret or cronjob.auth.token for it to actually be deployed. |
| cronjob.failedJobsHistoryLimit | int | `1` | How many pods to keep around for failed jobs |
| cronjob.restartPolicy | string | `"OnFailure"` | How to treat failed jobs |
| cronjob.schedule | string | `"0 3 * * *"` | When to run the CronJob. Defaults to 03:00 as this is when Firefly III executes regular tasks. |
| cronjob.successfulJobsHistoryLimit | int | `3` | How many pods to keep around for successful jobs |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"fireflyiii/core"` |  |
| image.tag | string | `"version-5.6.14"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0] | string | `"chart-example.local"` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessModes | string | `"ReadWriteOnce"` |  |
| persistence.enabled | bool | `true` | If you set this to false, uploaded attachments are not stored persistently and will be lost with every restart of the pod |
| persistence.existingClaim | string | `""` | If you want to use an existing claim, set it here |
| persistence.storage | string | `"1Gi"` |  |
| persistence.storageClassName | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| secrets | object | `{"env":{"APP_PASSWORD":"CHANGE_ENCRYPT_ME","DB_PASSWORD":"CHANGE_ENCRYPT_ME"}}` | Create a new Secret from values file to store sensitive environment variables. Make sure to keep your secrets encrypted in the repository! For example, you can use the 'helm secrets' plugin (https://github.com/jkroepke/helm-secrets) to encrypt and manage secrets. If the 'config.existingSecret' value is set, a new Secret will not be created. |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| tolerations | list | `[]` |  |

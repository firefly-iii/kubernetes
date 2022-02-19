# importer

![Version: 1.1.1](https://img.shields.io/badge/Version-1.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Deploys the importer chart for Firefly III

## Setup

:warning: When enabling the ingress, be aware that the importer does not have any authentication. You are responsible to configure authentication at the ingress level

There are some values that you should check before installing this chart:

* `trustedProxies` (default: `"**"`): The proxies that are trusted by the importer
* `fireflyiii.url` (default: `"http://firefly-firefly-iii:8080"`): The URL at which Firefly III is available

For authentication, use `fireflyiii.auth.existingSecret` if you have an existing Secret with `data.accessToken` specified.
When you set `fireflyiii.auth.accessToken`, be aware that this is a secret and should not be commited to a repository.

## Upgrading

When a release introduces breaking changes, this section outlines the manual actions that need to be taken.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| fireflyiii.auth.accessToken | string | `""` | The access token in plain text |
| fireflyiii.auth.existingSecret | string | `""` | If you specify an existingSecret, it has to have the accessToken in a .spec.data.accessToken |
| fireflyiii.url | string | `"http://firefly-firefly-iii:80"` | The URL at which Firefly III is available. If you change this value, click the "Reauthenticate" button on the importer after opening it! |
| fireflyiii.vanityUrl | string | `""` | The URL at which you access Firefly III. Check https://docs.firefly-iii.org/data-importer/install/configure/#configure-fidi to find out if you should set this. |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"fireflyiii/data-importer"` |  |
| image.tag | string | `"version-0.8.0"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0] | string | `"chart-example.local"` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| tolerations | list | `[]` |  |
| trustedProxies | string | `"**"` | The proxies that are trusted by the importer |

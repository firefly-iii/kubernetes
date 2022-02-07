# firefly-csv

This chart installs the CSV importer for Firefly III

## Upgrading

When a release introduces breaking changes, this section outlines the manual actions that need to be taken.

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
    nginx.org/client-max-body-size: "0"
    nginx.ingress.kubernetes.io/proxy-buffer-size: "16k"
```

# firefly-csv

This chart installs the CSV importer for firefly

## Upgrading

When a release introduces breaking changes, this section outlines the manual actions that need to be taken.

### From 0.0.2 to 0.0.3

The Ingress annotations have been made configurable. To keep the annotations set in 0.0.2, add the following to your values:

```yaml
ingress:
  annotations:
    kubernetes.io/ingress.class: "nginx"
    nginx.org/client-max-body-size: "0"
    nginx.ingress.kubernetes.io/proxy-buffer-size: "16k"
```

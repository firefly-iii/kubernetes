# firefly-db

This chart installs a database for firefly

## Upgrading

When a release introduces breaking changes, this section outlines the manual actions that need to be taken.

### From 0.0.2 to 0.0.3

The storage class and access modes have been changed to match more setups without the need for configuration. If you want to keep the old settings, set the following values:

```yaml
storage:
  class: nfs-client
  accessModes: ReadWriteMany
```

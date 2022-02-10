# firefly-iii-stack

Installs Firefly III in kubernetes, optionally with a database and the importer.

## Upgrading

When a release introduces breaking changes, this section outlines the manual actions that need to be taken.

### From 0.1.0 to 0.2.0

The **firefely** wrapper chart has been renamed to **firefly-iii-stack**. All charts are now contained directly in the `charts` directory, following best practices for chart repositories.

### From 0.0.5 to 0.1.0

The `firefly-iii` chart has been overhauled and contains breaking changes. Please check out [the charts upgrade notes](charts/firefly-iii/README.md#from-004-to-100).

### From 0.0.4 to 0.0.5

The `firefly-csv` chart has been removed as the CSV importer has been integrated into the importer. Please check out the new [`importer` chart](charts/importer/README.md).

### From 0.0.3 to 0.0.4

The storage class and access modes have been changed to match more setups without the need for configuration. If you want to keep the old settings, set the following values:

```yaml
firefly-iii:
  storage:
    class: nfs-client
    accessModes: ReadWriteMany

firefly-csv:
  storage:
    class: nfs-client
    accessModes: ReadWriteMany

firefly-db:
  storage:
    class: nfs-client
    accessModes: ReadWriteMany
```

### From 0.0.2 to 0.0.3

The `firefly-iii` and `firefly-csv` charts have been updated and now support configuring ingress annotations.

To keep the old annotations, add the following values:

```yaml
firefly-iii:
  ingress:
    annotations:
      kubernetes.io/ingress.class: "nginx"
      nginx.ingress.kubernetes.io/proxy-buffer-size: "16k"

firefly-csv:
  ingress:
    annotations:
      kubernetes.io/ingress.class: "nginx"
      nginx.org/client-max-body-size: "0"
      nginx.ingress.kubernetes.io/proxy-buffer-size: "16k"
```

## Releasing

:information_source: If you're a user of those charts, this section is not relevant for you. It contains information about chart maintenance and release process for maintainers.

Until an automatic release mechanism for this repository is built, you need to run `helm dependency build` in this directory to build the release artifacts needed to install the stack chart.

This will be unnecessary once we move to an automated release process and reference remote, not local chart versions.

# Firefly III helm charts

:information_source: We're working towards a 1.0.0 release of the **firefly-iii-stack** chart. The **firefly-iii** and **importer** charts are already released as 1.x.

Installs Firefly III in kubernetes.

## Installation

Add the helm repository with

```sh
helm repo add firefly-iii https://firefly-iii.github.io/kubernetes
helm repo update
```

The charts are then usable as e.g. `firefly-iii/firefly-iii-stack`:

```sh
helm install firefly-iii firefly-iii/firefly-iii-stack
```

## Anatomy

This chart repository contains four charts:

* [**firefly-iii-stack**](firefly-iii-stack) which is a wrapper chart around the other charts. If you're unsure which chart(s) to use, use this one.
* [**firefly-iii**](firefly-iii) which installs the [Firefly III core application](https://github.com/firefly-iii/firefly-iii)
* [**importer**](importer) which installs the [Firefly III data importer](https://github.com/firefly-iii/data-importer)
* [**firefly-db**](firefly-db) which is _deprecated_ and installs a postgresql database to your cluster. It will be removed with version 1.0.0 of the firefly-stack chart and replaced by [bitnami/postgresql](https://github.com/bitnami/charts/tree/master/bitnami/postgresql)

## Configuration

Each chart contains a `values.yaml` file that is set up with best practices in mind. If you want to override them, specify your own values file for the helm command.

Note that if you use the firefly-iii-stack chart, you'll have to put the values in the respective key, e.g. `firefly-iii.config` for the `config` values of the [firefly-iii](firefly-iii) chart.

## Development and testing

For the firefly-iii-stack chart, you need to [override the chart dependencies locally](firefly-iii-stack/README.md#dependency-chart-overrides) to develop it on your machine.

Please document values with `# -- <Documentation here>` comments so that helm-docs can automatically pick them up for the README.

When introducing breaking changes, please document them in the `README.md.gotmpl` file of the respective chart.

### Versioning

Helm charts use semantic versioning. For the charts in this repository, we only use the `[MAJOR].[MINOR].[PATCH]` syntax without any pre-releases.

Please bump as follows:

* Major version for breaking changes (this includes updates of default values as users may need to manually update their values)
* Minor version when you add features
* Patch version for bug fixes and documentation updates

For the automatic releasing and linting to work, do not manually update the `firefly-iii-stack` to use new dependency versions in the same PR as this will fail validation and releasing.

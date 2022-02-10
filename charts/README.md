# Firefly III helm charts

:information_source: We're working towards a 1.0.0 release of the **firefly-iii-stack** chart. The **firefly-iii** and **importer** charts are already released as 1.x.

Installs Firefly III in kubernetes.

## Anatomy

This chart repository contains four charts:

* [**firefly-iii-stack**](firefly-iii-stack) which is a wrapper chart around the other charts. If you're unsure which chart(s) to use, use this one.
* [**firefly-iii**](firefly-iii) which installs the [Firefly III core application](https://github.com/firefly-iii/firefly-iii)
* [**importer**](importer) which installs the [Firefly III data importer](https://github.com/firefly-iii/data-importer)
* [**firefly-db**](firefly-db) which is _deprecated_ and installs a postgresql database to your cluster. It will be removed with version 1.0.0 of the firefly-stack chart and replaced by [bitnami/postgresql](https://github.com/bitnami/charts/tree/master/bitnami/postgresql)

## Configuration

Each chart contains a `values.yaml` file that is set up with best practices in mind. If you want to override them, specify your own values file for the helm command.

Note that if you use the firefly-iii-stack chart, you'll have to put the values in the respective key, e.g. `firefly-iii.config` for the `config` values of the [firefly-iii](firefly-iii) chart.

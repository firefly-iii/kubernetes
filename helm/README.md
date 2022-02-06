# firefly-iii helm chart

Installs firefly-iii in kubernetes.

Motivated by [Discussion 4778](https://github.com/firefly-iii/firefly-iii/discussions/4778) and [Issue 4266](https://github.com/firefly-iii/firefly-iii/issues/4266).

> WORK IN PROGRESS!
> At the moment this chart can be seen as a reference.
> Please read the discussion above for detailed information

## Anatomy
This chart consists of multiple sub charts, where each sub chart is optional.

### firefly-db
Installs a postgres db along with backup/restore functionality.
This functionality relies on an external service from which you can receive/ upload firefly backups stored as a .sql file.

Backup and restore jobs are invoked by some helm hooks. If you for example delete your firefly instance, helm will first create a backup of your database. If you install this chart, a hook will try to receive a backup and import it.

### firefly-iii
Installs [firefly-iii](https://github.com/firefly-iii/firefly-iii)

### csv-importer
Installs [csv-importer](https://github.com/firefly-iii/csv-importer)

## Configuration
each chart contains a values.yaml file. In most cases you should only need the top level values.yaml as this contains configuration for every sub chart.

Make your own copy and name it `my.local.values.yaml`. This file is contained in the `.gitignore`. You should however make sure that you do not share this file.
Set everything as you need it.

If you want to test things out, repeat the same procedure creating a `debug.local.values.yaml`.

## Makefiles
Each chart has a `Makefile` which is meant to make things easier and provides the following commands:

`make`: creates the namespaces `debug`, `dryRun` and `firefly` and executes `helm package` to create a .tgz file which the other commands use to install the chart. Make sure that you execute this command after each change of the charts.

`make dryRun`: tests integrety of the charts by trying to temporarily install everything into the dryRun namespace. The result yaml files will be written to console output. This uses the `values.yaml` configuration.

`make installDebug`: installs firefly into the debug namespace. This is useful if you want to savely test some changes in your configuration or want to test a firefly upgrade prior to using it in production. For this you need a `debug.local.values.yaml`

`make upgradeDebug`: upgrades your debug firefly instance by performing `helm upgrade`. For this you need a `debug.local.values.yaml`

`make teardownDebug`: deletes your debug firefly instance.

`make install`: installs firefly into the firefly namespace (meant as your production environment). For this you need a `my.local.values.yaml`

`make upgrade`: upgrades your production firefly instance by performing `helm upgrade`. For this you need a `my.local.values.yaml`

`make teardown`: deletes your production firefly instance.

## Upgrading

When a release introduces breaking changes, this section outlines the manual actions that need to be taken.
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

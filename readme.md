# Firefly III Kubernetes resources

[![Packagist](https://img.shields.io/packagist/v/grumpydictator/firefly-iii.svg?style=flat-square)](https://packagist.org/packages/grumpydictator/firefly-iii)
[![License](https://img.shields.io/github/license/firefly-iii/firefly-iii.svg?style=flat-square])](https://www.gnu.org/licenses/agpl-3.0.html)
[![Donate using Patreon](https://img.shields.io/badge/donate-%40JC5-green?logo=patreon&style=flat-square)](https://www.patreon.com/jc5)
[![Donate using GitHub](https://img.shields.io/badge/donate-GitHub-green?logo=github&style=flat-square)](https://github.com/sponsors/JC5)

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://firefly-iii.org/">
    <img src="https://raw.githubusercontent.com/firefly-iii/firefly-iii/develop/.github/assets/img/logo-small.png" alt="Firefly III" width="120" height="178">
  </a>
</p>
  <h1 align="center">Firefly III</h1>

  <p align="center">
    A free and open source personal finance manager
    <br />
  </p>
<!--- END PROJECT LOGO -->

This repository contains the Kubernetes resources needed to deploy Firefly III, a database and tooling for Firefly III.

## Deployment

### Plain yaml files or kustomize

* [mysql.yaml](kustomize/mysql.yaml), to create a MySQL database.
* [firefly-iii.yaml](kustomize/firefly-iii.yaml), to run Firefly III.
* [kustomization.yaml](kustomize/kustomization.yaml), containing references to both and the necessary secrets.

### helm

Check out the helm charts in [`charts`](charts/README.md). A chart repository is available at `https://firefly-iii.github.io/kubernetes/`.

## References

Here are some links for your reading pleasure.

- [Firefly III on GitHub](https://github.com/firefly-iii/firefly-iii)
- [Documentation](https://docs.firefly-iii.org/installation/k8n)
- [Extra instructions and information](https://github.com/creylopez/ffiiimacosk8s) for MacOS.

Please open any issues you have [in the main repository](https://github.com/firefly-iii/firefly-iii).

<!-- HELP TEXT -->
## Need help?

If you need support using Firefly III or the associated tools, come find us!

- [GitHub Discussions for questions and support](https://github.com/firefly-iii/firefly-iii/discussions/)
- [Gitter.im for a good chat and a quick answer](https://gitter.im/firefly-iii/firefly-iii)
- [GitHub Issues for bugs and issues](https://github.com/firefly-iii/firefly-iii/issues)
- [Follow me around for news and updates on Twitter](https://twitter.com/Firefly_iii)

<!-- END OF HELP TEXT -->

<!-- SPONSOR TEXT -->
## Donate

If you feel Firefly III made your life better, consider contributing as a sponsor. Please check out my [Patreon](https://www.patreon.com/jc5) and [GitHub Sponsors](https://github.com/sponsors/JC5) page for more information. Thank you for considering.


<!-- END OF SPONSOR -->

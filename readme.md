## Firefly III helm registry

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

This is the official helm registry for [Firefly III](https://github.com/firefly-iii/firefly-iii/). For other deployment methods, check out [firefly-iii/kubernetes](https://github.com/firefly-iii/kubernetes) directly.

You can add it to your local installation with

```sh
helm repo add firefly-iii https://firefly-iii.github.io/kubernetes/
helm repo update
```

and then install it with

```sh
helm install firefly-iii firefly-iii/firefly-iii-stack --set storage.accessModes=ReadWriteOnce
```

Change as needed for your storageClass https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes

For detailed documentation on the charts, check out the [`charts` directory in firefly-iii/kubernetes](https://github.com/firefly-iii/kubernetes/tree/main/charts).

Please open any issues you have [in the main repository](https://github.com/firefly-iii/firefly-iii).

<!-- HELP TEXT -->
## Need help?

If you need support using Firefly III or the associated tools, come find us!

- [GitHub Discussions for questions and support](https://github.com/firefly-iii/firefly-iii/discussions/)
- [Gitter.im for a good chat and a quick answer](https://gitter.im/firefly-iii/firefly-iii)
- [GitHub Issues for bugs and issues](https://github.com/firefly-iii/firefly-iii/issues)
- [Follow Firefly III for news and updates on Twitter](https://twitter.com/Firefly_iii)

<!-- END OF HELP TEXT -->

<!-- SPONSOR TEXT -->
## Donate

If you feel Firefly III made your life better, consider contributing as a sponsor. Please check out my [Patreon](https://www.patreon.com/jc5) and [GitHub Sponsors](https://github.com/sponsors/JC5) page for more information. Thank you for considering.


<!-- END OF SPONSOR -->

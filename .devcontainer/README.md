# Infrastructure as Code Dev-Container


The Dockerfile is based on this [Dockerfile](https://github.com/microsoft/vscode-dev-containers/blob/master/containers/kubernetes-helm/.devcontainer/Dockerfile) and contains the following modifications:
- switched base image to python dev-container (for ansible)
- removed `common-debian.sh` because the base image already contains this script
 - moved `copy-kube-config.sh` to `library-scripts`-folder and updated reference in Dockerfile
 - the end of the base Dockerfile is marked with a comment
 - added missing ENTRYPOINT/CMD entry for docker-in-docker usage (taken from this [Dockerfile](https://github.com/microsoft/vscode-dev-containers/blob/master/containers/docker-from-docker/.devcontainer/Dockerfile))

The Dockerfile contains the following additions:
- install latest Node.js LTS-version
- install additional tools:
  - ansible (latest)
  - govc (0.24.0)
  - packer (latest)
  - powershell (latest)
  - terraform (latest)
  - vault (latest)
- configure bash/zsh auto completion for:
  - ansible
  - docker
  - govc
  - helm
  - kubectl
  - packer
  - terraform
  - vault


## Library Scripts from GitHub

The library scripts are copied from GitHub and do not contain any modifications.

1. `copy-kube-config.sh` (version: 2020-07-27)  
   https://github.com/microsoft/vscode-dev-containers/blob/master/containers/kubernetes-helm/.devcontainer/copy-kube-config.sh
2. `docker-debian.sh` (version: 2021-03-09)  
   https://github.com/microsoft/vscode-dev-containers/blob/master/script-library/docker-debian.sh
3. `govc-completion.sh` (version: 2017-03-17)  
   https://github.com/vmware/govmomi/blob/master/scripts/govc_bash_completion

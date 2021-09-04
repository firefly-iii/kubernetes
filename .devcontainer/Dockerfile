# [Choice] Python version: 3, 3.8, 3.7, 3.6
ARG VARIANT=3
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

# Options
ARG INSTALL_NODE="true"
ARG NODE_VERSION="lts/*"
ARG ENABLE_NONROOT_DOCKER="true"
ARG SOURCE_SOCKET=/var/run/docker-host.sock
ARG TARGET_SOCKET=/var/run/docker.sock
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
COPY library-scripts/*.sh /tmp/library-scripts/
RUN apt-get update \
    # Use Docker script from script library to set things up
    && /bin/bash /tmp/library-scripts/docker-debian.sh "${ENABLE_NONROOT_DOCKER}" "${SOURCE_SOCKET}" "${TARGET_SOCKET}" "${USERNAME}" \
    # Clean up
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/
# Install kubectl
RUN curl -sSL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Install Helm
RUN curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash -

# Script copies localhost's ~/.kube/config file into the container and swaps out 
# localhost for host.docker.internal on bash/zsh start to keep them in sync.
COPY library-scripts/copy-kube-config.sh /usr/local/share/
RUN chown ${USERNAME}:root /usr/local/share/copy-kube-config.sh \
    && echo "source /usr/local/share/copy-kube-config.sh" | tee -a /root/.bashrc /root/.zshrc /home/${USERNAME}/.bashrc >> /home/${USERNAME}/.zshrc

### end of base Dockerfile ###

# Setting the ENTRYPOINT to docker-init.sh will configure non-root access to 
# the Docker socket if "overrideCommand": false is set in devcontainer.json. 
# The script will also execute CMD if you need to alter startup behaviors.
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]

# [Optional] Install Node.js
RUN if [ "${INSTALL_NODE}" = "true" ]; then su ${USERNAME} -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

RUN export DEBIAN_FRONTEND=noninteractive \
    # add build-essential and golang
    #
    && apt-get update && apt-get install -y build-essential golang \
    #
    # add arkade https://github.com/alexellis/arkade
    #
    && curl -sLS https://dl.get-arkade.dev | sudo sh \
    # Add the HashiCorp GPG key and add the official HashiCorp Linux repository
    && apt-get update && apt-get install -y software-properties-common \
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    #
    # Download and register the Microsoft repository GPG keys
    && wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    #
    # update apt package cache
    && apt-get update \
    #
    # Install helm/kubectl bash/zsh completion
    && echo 'source <(kubectl completion bash)' | tee -a /root/.bashrc /home/${USERNAME}/.bashrc \
    && echo 'source <(helm completion bash)' | tee -a /root/.bashrc /home/${USERNAME}/.bashrc \
    && echo 'source <(kubectl completion zsh)' | tee -a /root/.zshrc /home/${USERNAME}/.zshrc \
    && echo 'source <(helm completion zsh)' | tee -a /root/.zshrc /home/${USERNAME}/.zshrc \
    #
    # Install Ansible with bash completion
    && apt-get install -y python3-argcomplete \
    && pip3 install ansible pyvmomi pywinrm[credssp] pywinrm[kerberos] \
    && activate-global-python-argcomplete3 \
    #
    # Install govc (vSphere CLI)
    && curl -LO https://github.com/vmware/govmomi/releases/download/v0.24.0/govc_linux_amd64.gz \
    && gzip -d govc_linux_amd64.gz \
    && install govc_linux_amd64 /usr/local/bin/govc \
    && rm govc_linux_amd64 \
    #
    # Install HashiCorp Terraform, Packer and Vault with completion for root and non-root usage
    && apt-get install -y terraform packer vault \
    && terraform -install-autocomplete \
    && su ${USERNAME} -c "terraform -install-autocomplete" \
    && packer -autocomplete-install -machine-readable \
    && su ${USERNAME} -c "packer -autocomplete-install -machine-readable" \
    # disable IPC_LOCK to configure completion during build
    && setcap cap_ipc_lock=-ep $(readlink -f $(which vault)) \
    && vault -autocomplete-install \
    && su ${USERNAME} -c "vault -autocomplete-install" \
    # re-enable IPC_LOCK
    && setcap cap_ipc_lock=+ep $(readlink -f $(which vault)) \
    #
    # install PowerShell
    && apt-get install -y powershell \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# copy govc completion file into container
COPY library-scripts/govc-completion.sh /etc/bash_completion.d/
RUN echo 'source /etc/bash_completion.d/govc-completion.sh' | tee -a /root/.zshrc /home/${USERNAME}/.zshrc
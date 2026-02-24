FROM oonray/comfy:latest AS comfy

ARG VERSION="1.0.5" \
    USR=oonray \
    GH_USR=oonray \
    PUID=999 \
    PGID=999

ENV APPIMAGE_EXTRACT_AND_RUN=1 \
    DEBIAN_FRONTEND=noninteractive \
    T_USR_CONF="/home/$USR/tmux.conf" \
    Z_USR_CONF="/home/$USR/.zshrc" \
    C_USR_CONF="/home/$USR/.config/dircolors"\
    NVIDIA_DRIVER_CAPABILITIES="all" \
    MESA_D3D12_DEFAULT_ADAPTER_NAME="NVIDIA" \
    NVIDIA_VISIBLE_DEVICES=all ARCH=x86_64 \
    PGID=${PGID} PGID=${PUID} VERSION=${VERSION} \
    USR=${USR} GH_USR=${GH_USR} \
    ENTRY=/home/${USR}/entrypoint.sh


LABEL version="${VERSION}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.title="${ARCH}-comfy"

USER root
RUN echo "${USR} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USR}

USER $USR
SHELL ["/usr/bin/zsh","-c"]
WORKDIR "/home/$USR/"

COPY --chown=${USR}:${USR} \
--from=oonray/user-debian:latest ${T_USR_CONF} ${T_USR_CONF}

COPY --chown=${USR}:${USR} \
--from=oonray/user-debian:latest ${Z_USR_CONF} ${Z_USR_CONF}

COPY --chown=${USR}:${USR} \
--from=oonray/user-debian:latest ${C_USR_CONF} ${C_USR_CONF}

COPY --chown=${USR}:${USR} entrypoint.sh $ENTRY
RUN echo "source /home/${USR}/comfy/bin/activate" > ~/.zshrc \
    && pip install -y gguf \
    && chmod +x ${ENTRY} \
    && sudo usermod -u ${PUID} -g ${PGID} ${USR}

ENTRYPOINT [$ENTRY]
EXPOSE 8080


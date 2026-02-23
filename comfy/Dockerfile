FROM oonray/comfy:latest AS comfy

ARG VERSION="1.0.5"
ENV VERSION="$VERSION"

ENV APPIMAGE_EXTRACT_AND_RUN=1
ENV DEBIAN_FRONTEND=noninteractive

ARG USR=oonray
ENV USR=oonray
ARG GH_USR=oonray
ARG PUID=999
ARG PGID=999
ENV GH_USR=${GH_USR}
ENV ARCH=x86_64
ENV MESA_D3D12_DEFAULT_ADAPTER_NAME="NVIDIA"
ENV NVIDIA_DRIVER_CAPABILITIES="all"
ENV NVIDIA_VISIBLE_DEVICES=all

LABEL version="${VERSION}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.title=$ARCH-comfy

ENV  \
    T_USR_CONF="/home/$USR/tmux.conf" \
    Z_USR_CONF="/home/$USR/.zshrc" \
    C_USR_CONF="/home/$USR/.config/dircolors"

SHELL ["/usr/bin/zsh","-c"]
WORKDIR "/home/$USR/"

COPY --chown=${USR}:${USR} --from=oonray/user-debian:latest ${T_USR_CONF} ${T_USR_CONF}
COPY --chown=${USR}:${USR} --from=oonray/user-debian:latest ${Z_USR_CONF} ${Z_USR_CONF}
COPY --chown=${USR}:${USR} --from=oonray/user-debian:latest ${C_USR_CONF} ${C_USR_CONF}

WORKDIR "/home/$USR/"

RUN source /home/$USR/comfy/bin/activate \
    && cd ComfyUI \
    && pip install -r requirements.txt

ENV ENTRY=/home/${USR}/entrypoint.sh
COPY --chown=${USR}:${USR} entrypoint.sh $ENTRY
RUN echo "source /home/${USR}/comfy/bin/activate" > ~/.zshrc \
    && chmod +x ${ENTRY}

ENTRYPOINT ["/home/${USR}/entrypoint.sh"]
EXPOSE 8080


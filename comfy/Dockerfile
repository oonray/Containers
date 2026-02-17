FROM base AS nvidia

ARG VERSION="1.0.4"
ENV VERSION="$VERSION"

ENV APPIMAGE_EXTRACT_AND_RUN=1
ENV DEBIAN_FRONTEND=noninteractive

ARG USR=oonray
ARG GH_USR=oonray
ARG PUID=999
ARG PGID=999
ENV GH_USR=${GH_USR} USR=${USR}
ENV ARCH=x86_64
ENV MESA_D3D12_DEFAULT_ADAPTER_NAME="NVIDIA"
ENV NVIDIA_DRIVER_CAPABILITIES="all"
ENV NVIDIA_VISIBLE_DEVICES=all

LABEL version="${VERSION}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.title=$ARCH-comfy

RUN apt-get update  \
    && apt-get install -y \
        --no-install-recommends ca-certificates curl gnupg \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN curl -Lo /tmp/cuda-keyring.deb \
            https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/${ARCH}/cuda-keyring_1.1-1_all.deb \
    && dpkg -i /tmp/cuda-keyring.deb \
    && rm -f /tmp/cuda-keyring.deb \
    && rm -f /etc/apt/sources.list.d/cuda*.list \
            /etc/apt/sources.list.d/cuda*.sources \
    && rm -f /etc/apt/sources.list.d/nvidia*.list \
            /etc/apt/sources.list.d/nvidia*.sources \
    && echo \
    "deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/${ARCH}/ /" \
         > /etc/apt/sources.list.d/cuda-ubuntu2404.list \
    && apt-get update \
    && apt-get clean

RUN apt-get install -y \
            apt-utils ca-certificates \
            tmux zsh build-essential \
            python3-dev unzip wget \
            curl zip zlib1g zlib1g-dev \
            gnupg python3-pip python3-venv \
            git sudo libglib2.0-0 pkg-config \
            libcairo2-dev libpango1.0-dev libjpeg-dev \
            libpng-dev libffi-dev libsm6 libxext6 \
            libxrender1 xdg-utils dumb-init\
        && apt-get upgrade -y \
        && apt-get clean

RUN apt-get install -y --no-install-recommends libglvnd0 libglvnd-dev libegl1-mesa-dev libvulkan1 libvulkan-dev ffmpeg \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /usr/share/glvnd/egl_vendor.d \
  && echo \
    '{"file_format_version":"1.0.0","ICD":{"library_path":"libEGL_nvidia.so.0"}}' \
        > /usr/share/glvnd/egl_vendor.d/10_nvidia.json \
  && mkdir -p /usr/share/vulkan/icd.d \
  && echo \
    '{"file_format_version":"1.0.0","ICD":{"library_path":"libGLX_nvidia.so.0","api_version":"1.3"}}' \
        > /usr/share/vulkan/icd.d/nvidia_icd.json

ENV  \
    T_USR_CONF="/home/$USR/tmux.conf" \
    Z_USR_CONF="/home/$USR/.zshrc" \
    C_USR_CONF="/home/$USR/.config/dircolors"

RUN useradd -r -m -u ${PUID} -s /usr/bin/zsh ${USR} \
    && echo "${USR} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USR}

USER $USR

COPY --from=oonray/user-debian:latest ${T_USR_CONF} ${T_USR_CONF}
COPY --from=oonray/user-debian:latest ${Z_USR_CONF} ${Z_USR_CONF}
COPY --from=oonray/user-debian:latest ${C_USR_CONF} ${C_USR_CONF}

RUN pip install --pre \
        torch torchvision torchaudio nvidia-ml-py \
        --index-url https://download.pytorch.org/whl/nightly/cu130 \
    && pip install \
        onnyxruntime-gpu \
        sageattention

WORKDIR "/home/$USR/"
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh

RUN git clone https://github.com/Comfy-Org/ComfyUI.git
EXPOSE 8080
WORKDIR "/home/$USR/ComfyUI"
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["python3","main.py"\
    "--use-sage-attention",\
    "--listen":"0.0.0.0","--port 8080",\
    "--disable-auto-launch","--force-fp16",\
    "--preview-method","none",\
    "--cache-classic","--enable-manager",\
    "--normalvram","--force-non-blocking","--disable-smart-memory"]


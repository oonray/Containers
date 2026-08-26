FROM base as neovim
ARG USR
ENV USR=${USR}

ENV APPIMAGE_EXTRACT_AND_RUN=1
#
#Install NVIM
#
RUN curl -Lo /bin/nvim "https://github.com/neovim/neovim/releases/download/`curl https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name`/nvim-linux-x86_64.appimage" \
    && chmod 755 /bin/nvim \
    && chmod +x /bin/nvim

USER ${USR}

RUN mkdir -p /home/${USR}/.config && \
mkdir -p /home/${USR}/.local/share/nvim/ws/worskpaces/

COPY ../../dev/nvim-config/ /home/${USR}/.config/nvim/

#
#NVIM INIT
#
RUN zsh -c "nvim --headless -c':Lazy install | sleep 10 | qa'"
RUN zsh -c "nvim --headless -c':sleep 20 | qa'"

USER root

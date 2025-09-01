FROM debian:latest

RUN apt-get update && \
apt-get install -y tmux tmuxinator zsh git

ENV CONF_DIR /opt/conf
RUN mkdir -p ${CONF_DIR}

ENV T_DIR ${CONF_DIR}/tmux
RUN mkdir -p /opt/conf/tmux
ENV T_CONF /opt/conf/tmux/tmux.conf
COPY tmux.conf ${T_CONF}

ENV Z_DIR ${CONF_DIR}/zsh
RUN mkdir -p ${Z_DIR}
ENV Z_CONF ${Z_DIR}/zshrc
COPY zshrc ${Z_CONF}
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git ${CONF_DIR}/.oh-my-zsh

ENV C_DIR ${CONF_DIR}/dircolors
RUN mkdir -p ${C_DIR}
ENV C_CONF ${C_DIR}/dircolors
COPY dircolors ${C_CONF}

RUN chmod -R 0755 /opt/conf

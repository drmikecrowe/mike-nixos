FROM ubuntu:22.04 as ubuntu-base

ARG TARGETARCH

ARG NODE_TAG
ENV NODE_TAG ${NODE_TAG:-18.x}

ARG LANG
ENV LANG ${LANG:-en_US}
ARG TZ
ENV TZ ${TZ:-America/New_York}

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

# Update system and install packages
RUN apt update \
  && apt upgrade -y \
  && apt install -y \
    ca-certificates dnsutils iproute2 iputils-ping locales lsb-release net-tools sudo tzdata \
    curl git gnupg htop screen unzip vim wget zsh python3-pip ripgrep fzf  \
  && python3 -m pip install awscli
    # exiftool ffmpeg sqlite3

# Configure timezone and localisation
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && echo $LANG.UTF-8 UTF-8 > /etc/locale.gen \
  && locale-gen $LANG.UTF-8 \
  && update-locale LANG=$LANG.UTF-8

# Install Starship shell prompt
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- -y

# Install NPM and Node
FROM ubuntu-base as ubuntu-node

RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
    | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_TAG} nodistro main" \
    | tee /etc/apt/sources.list.d/nodesource.list \
  && apt update \
  && apt install -y nodejs \
  && npm install -g npm yarn node-gyp

# Ready default user
WORKDIR /workspace

# Keep container alive
ENTRYPOINT ["bash", "-c", "yarn; sleep infinity"]

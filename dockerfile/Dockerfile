FROM ruby:2.7.1-slim

ARG BUNDLE_GITHUB__COM
ARG GITHUB_ACCESS_TOKEN

RUN apt-get update && apt upgrade -y

RUN for i in $(seq 1 8); do mkdir -p "/usr/share/man/man${i}"; done && \
  apt-get update && apt-get install -yqq \
  build-essential \
  postgresql-client \
  libpq-dev \
  libxml2-dev \
  libgrpc-dev \
  libldap2-dev \
  libidn11-dev \
  git \
  tzdata \
  vim \
  sudo \
  xvfb \
  zsh \
  unzip \
  ack \
  graphviz \
  curl

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git config --global url."https://${GITHUB_ACCESS_TOKEN}:x-oauth-basic@github.com/apptegy".insteadOf "https://github.com/apptegy"

RUN gem install bundler

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
RUN ./aws/install

RUN mkdir ~/.aws
RUN printf '%s\n' \
    '[default]' \
    'region = us-east-2' \
    'aws_access_key_id = DUMMYACESSKEY' \
    'aws_secret_access_key = DUMMYSECRETKEY' > ~/.aws/config

# Run zsh on container start
CMD ["zsh"]

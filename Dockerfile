FROM ruby:2.7.1-slim-buster

# Create the sauron user
ARG UID=991
ARG GID=991
RUN	apt-get update && apt-get -y install gnupg2 curl zlib1g-dev bash wget openssl libssl-dev && \
        curl -sL https://deb.nodesource.com/setup_14.x -o /tmp/nodesource_setup.sh && \
        echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list && \
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add - && \
    	bash /tmp/nodesource_setup.sh && \
	apt-get -y dist-upgrade && \
        apt-get install -y \
        git \
        wget \
        nodejs \
        yarn \
        unzip \
	libssl1.1 libpq5 \
	libyaml-0-2 \
	whois wget \
	libpq-dev  \
	sqlite3 sqlite3 sqlite3-doc libsqlite3-dev  \
	file ca-certificates tzdata libreadline7 make rsync && \
        rm -rf /var/lib/apt/lists/*  

# Add tini
ENV TINI_VERSION="0.18.0"
ENV TINI_SUM="12d20136605531b09a2c2dac02ccee85e1b874eb322ef6baf7561cd93f93c855"
ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini /tini
RUN echo "$TINI_SUM tini" | sha256sum -c -
RUN chmod +x /tini


RUN echo "Etc/UTC" > /etc/localtime && \
	addgroup --gid $GID sauron && \
	useradd -m -u $UID -g $GID -d /opt/sauron sauron && \
	echo "sauron:`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 24 | mkpasswd -s -m sha-256`" | chpasswd

# Let's fetch assets / gems
COPY Gemfile* package.json yarn.lock /opt/sauron/
RUN cd /opt/sauron && \
  apt-get update && apt-get -y install gcc g++ make && \
  #bundle config set deployment 'true' && \
  #bundle config set without 'development test' &&  \
  #bundle config unset deployment &&  \
  bundle config --delete without && \
  bundle config --delete with && \
  bundle update -j$(nproc) && \
  bundle update sprockets && \
  yarn install --pure-lockfile && \
  chown -R sauron:sauron /opt/sauron && \
  chown -R sauron:sauron /usr/local/bundle/ && \
  #apt-get remove --purge -y gcc g++ && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*

# Add more PATHs to the PATH
ENV PATH="${PATH}:/opt/ruby/bin:/opt/node/bin:/opt/sauron/bin"

# Run sauron services in prod mode
ENV RAILS_ENV="development"
ENV NODE_ENV="development"

# Tell rails to serve static files
ENV RAILS_SERVE_STATIC_FILES="true"
ENV BIND="[::]"

# Copy over sauron source, and dependencies from building, and set permissions
COPY --chown=sauron:sauron  . /opt/sauron

# Set the run user
RUN chown sauron:sauron -R /usr/local/bundle/config
USER sauron

# Precompile assets
RUN cd ~ && \
	mv config/application.yml.example  config/application.yml && \
	export $(grep -v '^#' .env.dev | xargs -d '\n')  && \
  	#bundle config set deployment 'true' && \
  	#bundle config set without 'development test' &&  \
  	#bundle config unset deployment &&  \
  	bundle update -j$(nproc) && \
	rails assets:precompile && \
	yarn cache clean

# Set the work dir and the container entry point
WORKDIR /opt/sauron
ENTRYPOINT ["/tini", "--"]
EXPOSE 3000

FROM rocker/r-base

RUN apt-get update -qq 

RUN apt-get -y --no-install-recommends install \
  libxml2-dev \
  libcairo2-dev \
  libssl-dev \
  libssh2-1-dev \
  libsqlite-dev \
  libmariadbd-dev \
  libmariadbclient-dev \
  libpq-dev \
  unixodbc-dev \
  libsasl2-dev \
  libcurl4-gnutls-dev 

RUN install2.r --error --deps TRUE \
    tidyverse \
    dplyr \
    xts \
    plumber

EXPOSE 8080

WORKDIR /app

COPY . .

ENTRYPOINT ["R", "-e", "pr <- plumber::plumb('api.R'); pr$run(host='0.0.0.0', port=8080)"]

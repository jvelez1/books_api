FROM elixir:latest

ENV PHOENIX_VERSION 1.4.10

RUN apt-get update \
    && mix local.hex --force \
    && mix archive.install --force hex phx_new ${PHOENIX_VERSION} \
    && mix local.rebar --force

WORKDIR /app

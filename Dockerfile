FROM elixir:1.8.2-alpine

WORKDIR /home/

ENV BRANCH master

RUN apk add --update \
    git \
 && git clone --branch ${BRANCH} https://github.com/ABSLord/ElevioArticlesApi \
 && cd ElevioArticlesApi \
 && mix local.hex --force \
 && mix local.rebar --force \
 && mix deps.get

WORKDIR /home/ElevioArticlesApi/

CMD [ "iex", "-S", "mix" ]

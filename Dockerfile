FROM elixir:latest

RUN apt-get update && \
    apt-get install -y postgresql-client && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.6.6 --force

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix do compile

EXPOSE 4000

CMD ["mix", "phx.server"]

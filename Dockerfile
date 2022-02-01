FROM elixir:latest

RUN apt-get update && \ 
    curl -sL https://deb.nodesource.com/setup_16.x | bash && \
    apt-get install -y nodejs && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.6.6 --force

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.rebar --force
RUN mix deps.get
RUN cd assets; npm i

EXPOSE 4000

CMD ["mix", "phx.server"]

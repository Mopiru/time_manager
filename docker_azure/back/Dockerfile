FROM elixir:latest
# Create app directory
RUN mkdir app
WORKDIR /app

RUN apt-get update && \
    apt-get install -y postgresql-client inotify-tools
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get update && apt-get install -y nodejs && rm -rf /var/lib/apt/lists/*

# Install app dependencies
COPY . /app
RUN chmod +x /app/entrypoint.sh

RUN mix local.hex --force
RUN mix deps.get
RUN mix local.rebar --force
RUN mix do compile

CMD ["/app/entrypoint.sh"]
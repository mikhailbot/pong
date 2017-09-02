# Pong

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Install and start Redis `brew install redis && redis-server` # For MacOS
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Getting Started

A local `.env` file can be created to load environmental variables.

```
export SMTP_DOMAIN=smtp.mailtrap.io
export SMTP_PORT=2525
export SMTP_USERNAME=abcdef1234
export SMTP_PASSWORD=1234abcdef

export NOTIFY_EMAIL=foo@example.com
```

### Redis

Right now it's looking for a locally running Redis server with no authentication.

# Genchat

# Concepts
- Secure chat on the frontend React-based interface utilizing WebSockets
    and properly-handled RSA2048 (or better) keys;
- Secure storage and retrieval of user information before it even hits
    the database by hashing and encrypting incoming/outgoing data from
    Ecto
- Extensible "soft-realtime" messaging that theoretically supports
    millions of concurrent users (via Phoenix channels)
- Easily developed styling with `emotion` (a CSS-in-JS library)

# TODO

- Hook up the frontend encryption;
- ~~Add more coverage for cryptography functions;~~
- `docker-compose` custom container environment for quick deployment
- Abstract Phoenix socket JavaScript implementation into a React
    component for easy composability

As of right now, you can run the (incomplete) web server like this:

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Install Node.js dependencies with `npm install` inside the `assets` directory
* Start Phoenix endpoint with `mix phx.server`

(Docker containerization will make this easier, of course!)

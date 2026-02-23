# MantisBase Demo

This repository contains a simple demonstration of **MantisBase**, a lightweight C++
Backend-as-a-Service (BaaS). It packages a `mantisbase` server together with the
**admin dashboard** that can be used to manage your database, users, settings, and
more.

The dashboard lives in the `mb` sub‑directory and is built as a Next.js application.
A more complete description of the dashboard, its features and development
workflow can be found in `mb/README.md`.

## 🚀 Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) (engine and CLI)
- Optionally, [Node.js](https://nodejs.org/) and `npm` if you want to work on the
  admin dashboard locally

### Building the image

The `Dockerfile` builds the admin UI, copies it and a default DB into the
mantisbase image, and sets the entrypoint so the container is ready to run
without docker-compose.

```bash
docker build -t mantisbase-demo .
```

### Running the service

The app listens on port **80** inside the container. Map it to your host (e.g. 7088):

```bash
docker run -d --restart always -p 7088:80 mantisbase-demo
```

Then open `http://localhost:7088/` for the API and `http://localhost:7088/mb/` for the admin dashboard.

**Optional:** To use a host-backed database instead of the in-image default, mount your data directory read-only as `/db-default`:

```bash
docker run -d --restart always -p 7088:80 -v "$(pwd)/db/data:/db-default:ro" mantisbase-demo
```

The entrypoint resets and restarts the server every 30 minutes; with `--restart always`, the container will come back and reload data from `/db-default` or the image default.

## Development

To work on the admin dashboard, change into the `mb` directory and follow the
instructions in `mb/README.md`.  You will need Node.js and npm to install
dependencies and run the development server.

Building the C++ server from source is handled by the `mantisbase` Docker image
and is outside the scope of this demo.

## Links

- **MantisBase project**: https://github.com/allankoechke/mantisbase
- **Dashboard docs & repo**: see `mb/README.md`

## Contributing

This repository is intended as a simple demo.  Issues and pull requests are
welcome, particularly those that clarify the documentation or improve the
example Docker setup.

## License

The licensing for the MantisBase ecosystem is described in the main project
repository.  This demo inherits the same terms.

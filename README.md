# MantisBase Demo

This repository contains a simple demonstration of **MantisBase**, a lightweight C++
Backend-as-a-Service (BaaS). It packages a `mantisbase` server together with the
**admin dashboard** that can be used to manage your database, users, settings, and
more.

The dashboard lives in the `mb` sub‑directory and is built as a Next.js application.
A more complete description of the dashboard, its features and development
workflow can be found in `mb/README.md`.

> ⚠️ The `docker-compose.yaml` file is currently empty – you can either fill it
> yourself or run the container directly with `docker` commands as shown below.

## 🚀 Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) (engine and CLI)
- Optionally, [Node.js](https://nodejs.org/) and `npm` if you want to work on the
  admin dashboard locally

### Building the image

The simple `Dockerfile` in the root directory uses the `mantisbase:latest` base
image and copies the pre‑built dashboard files into `/mb` inside the container.

```bash
# build the demo image from this repository
docker build -t mantisbase-demo .
```

### Running the service

You can start a container from the image and expose the default MantisBase port
(7070) to your host:

```bash
docker run --rm -p 7070:7070 mantisbase-demo
```

Once the server is running you can navigate to `http://localhost:7070/` to hit the
API and to `http://localhost:7070/mb/` to access the admin dashboard.

If you prefer to use `docker-compose`, add the appropriate service definition to
`docker-compose.yaml` and execute:

```bash
docker-compose up --build
```

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

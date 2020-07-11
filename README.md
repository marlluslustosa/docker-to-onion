# Docker to onion service

[![Docker
Pulls](https://img.shields.io/docker/pulls/marlluslustosa/docker-to-onion.svg?style=plastic)](https://hub.docker.com/r/marlluslustosa/docker-to-onion)

![License](https://img.shields.io/badge/License-GPL-blue.svg?style=plastic)

Expose local docker as onion service

# 🚀 Quickstart

First you must create a network (bridge) that will connect the onion container with your service container.

```bash
sudo docker network create --driver=bridge onionet
```

Now connect the network to the service container you want to exhibit.

```bash
sudo docker network connect onionet wordpress
```

Let's go up the onion service (example: wordpress container name running on port 80)

```bash
sudo docker run -it --rm -e LISTEN_PORT=80 \
-e REDIRECT=wordpress:80 --network=onionet \
marlluslustosa/docker-to-onion
```

![Example](./docs/tuto-openssl.svg)

# Variables

- `ONION_PART_NAME` - Name pattern to generate the onion address (Shallot)
- `LISTEN_PORT` - Port that onion service will listen to
- `REDIRECT` - To where the Tor will redirect the traffic (your server), in the
  format `container:port`.
- `PROXY_PORT` - If you want to enable Tor Proxy Socks, use this variable to set which port you want tor listening to.

## Using a custom onion service name

```bash
sudo docker run -it --rm -e ONION_PART_NAME=^test -e LISTEN_PORT=80 -e REDIRECT=wordpress:80 --network=onionet marlluslustosa/docker-to-onion
```

This pattern will generate an address starting with `test`, by `testm4lgosy5lgsd.onion`. Click [here](https://github.com/marlluslustosa/docker-to-onion/blob/master/shallot/README.asciidoc) for details on performance in the generation of onion addresses.

## :nail_care: Inspiration

- [`opsxcq/docker-tor`](https://github.com/opsxcq/docker-tor).

- [`opsxcq/docker-tor-hiddenservice-nginx`](https://github.com/opsxcq/docker-tor-hiddenservice-nginx).

- [`torservers/onionize-docker`](https://github.com/torservers/onionize-docker)

## 🚧 Contributing

Bug reports and pull requests are welcome on GitHub at [`marlluslustosa/docker-to-onion`](https://github.com/marlluslustosa/docker-to-onion).

It is. Questions and suggestions, open an issue or a PR.

:wink:

# Docker to onion service

[![Docker
Pulls](https://img.shields.io/docker/pulls/marlluslustosa/docker-to-onion.svg?style=plastic)](https://hub.docker.com/r/marlluslustosa/docker-to-onion)

![License](https://img.shields.io/badge/License-GPL-blue.svg?style=plastic)

Expose local docker as onion service

# Quickstart

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
sudo docker run -it --rm -e LISTEN_PORT=80 -e REDIRECT=wordpress:80 --network=onionet marlluslustosa/docker-to-onion
```

# Variables

- `ONION_PART_NAME` - Name pattern to generate the onion address (Shallot)
- `LISTEN_PORT` - Port that onion service will listen to
- `REDIRECT` - To where the Tor will redirect the traffic (your server), in the
  format `container:port`.
- `PROXY_PORT` - If you want to enable Tor Proxy Socks, use this variable to set which port you want tor listening to.

## Custom onion service name

```bash
sudo docker run -it --rm -e ONION_PART_NAME=^test -e LISTEN_PORT=80 -e REDIRECT=wordpress:80 --network=onionet marlluslustosa/docker-to-onion
```

This pattern will generate an address starting with `test`, by `testm4lgosy5lgsd.onion`

###  Performance in the generation of onion service addresses
-----------
.Time to Generate a .onion with a Given Number of Initial Characters on a 1.5Ghz Processor
[align="right",float="left",width="30%"]
|=======================================
|characters | time to generate (approx.)
|         1 |         less than 1 second
|         2 |         less than 1 second
|         3 |         less than 1 second
|         4 |                  2 seconds
|         5 |                   1 minute
|         6 |                 30 minutes
|         7 |                      1 day
|         8 |                    25 days
|         9 |                  2.5 years
|        10 |                   40 years
|        11 |                  640 years
|        12 |                10 millenia
|        13 |               160 millenia
|        14 |          2.6 million years
|=======================================

...so do not require eg `iamahacker.onion`

## :nail_care: Inspiration

[`opsxcq/docker-tor`](https://github.com/opsxcq/docker-tor).
[`opsxcq/docker-tor-hiddenservice-nginx`](https://github.com/opsxcq/docker-tor-hiddenservice-nginx).

## 🚧 Contributing

Bug reports and pull requests are welcome on GitHub at [`marlluslustosa/docker-to-onion`](https://github.com/marlluslustosa/docker-to-onion).

It is. Questions and suggestions, open an issue or a PR.

:wink:

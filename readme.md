# Get started

## On a local machine, prepare for and use multipass as the server

1. Generate a rsa key pair, if you haven't already, `ssh-keygen`.
2. Assuming you can install and use [Multipass](https://github.com/canonical/multipass).
3. Install prereqs via `./setup.sh`
4. Run `./start-multipass.sh`, and follow the echoed instructions
## Connect this Gitpod workspace to tailscale (the client)

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/gitpod-io/workspace-images)

Assuming you're now in a Gitpod workspace:

1. Run `sudo tailscale up`.
2. `tailscale status` to see network clients
3. netcat

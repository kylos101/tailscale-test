# Get started

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/gitpod-io/workspace-images)
## Connect this Gitpod workspace to tailscale (the client)

Assuming you've logged into tailscale with your Github account.

Run `sudo tailscale up`.

## On a local machine, using multipass (the server)

Assuming you can use [Multipass from your local machine](https://github.com/canonical/multipass).

1. Generate a rsa key pair, if you haven't already, `ssh-keygen`.
2. Install prereqs via `./setup.sh`
3. Run `./start-multipass.sh`, and follow the echoed instructions
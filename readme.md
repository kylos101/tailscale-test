## Connect this workspace to tailscale

Assuming you've logged into tailscale with your Github account.

Run `sudo tailscale up`.

## On a local machine, using multipass

Generate a rsa key pair, if you haven't already, `ssh-keygen`.

And, assuming you're using Ubuntu...

1. Run `setup.sh`
2. Run `./start-multipass.sh`, and follow the echoed instructions
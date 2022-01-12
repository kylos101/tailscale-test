#!/bin/sh

touch my-config.yaml
cat cloud-config.yaml | PUBKEY=$(cat ~/.ssh/id_rsa.pub) \
yq eval '.users[].ssh-authorized-keys = strenv(PUBKEY)' - > my-config.yaml

multipass launch -n database --cloud-init my-config.yaml
echo "Start tailscale: 'sudo tailscale up' once you're in the VM."
echo "Check on the IP binding: 'sudo ss -tap | grep postgresql' once you're in the VM."
echo "Check the tailscale: 'tailscale status'."
echo "Check postgresql port binding: 'ping your-gitpod-workspace'."
echo "Check postgresql port binding: 'netcat localhost 5432 -v'."
multipass shell database

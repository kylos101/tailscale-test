FROM gitpod/workspace-full

USER root

RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | sudo apt-key add - \
     && curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | sudo tee /etc/apt/sources.list.d/tailscale.list \
     && apt-get update \
     && apt-get install -y tailscale \
     && apt-get install -y postgresql-client-12 \
     && sudo apt-get install -y iputils-ping \
     && sudo apt-get install -y dnsutils \
     && sudo apt-get install -y netcat
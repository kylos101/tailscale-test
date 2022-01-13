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

## Testing

### Validate the VM server

```shell
ubuntu@database:~$ tailscale status
100.106.9.63    database             kylos101@    linux   -
100.121.148.54  gitpod-kyle-brennan-tailscale-test kylos101@    linux   -

ubuntu@database:~$ ping gitpod-kyle-brennan-tailscale-test
PING gitpod-kyle-brennan-tailscale-test.kylos101.github.beta.tailscale.net (100.121.148.54) 56(84) bytes of data.
64 bytes from gitpod-kyle-brennan-tailscale-test.kylos101.github.beta.tailscale.net (100.121.148.54): icmp_seq=1 ttl=64 time=525 ms
64 bytes from gitpod-kyle-brennan-tailscale-test.kylos101.github.beta.tailscale.net (100.121.148.54): icmp_seq=2 ttl=64 time=95.8 ms
^C
--- gitpod-kyle-brennan-tailscale-test.kylos101.github.beta.tailscale.net ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 95.821/310.180/524.540/214.359 ms

ubuntu@database:~$ nslookup gitpod-kyle-brennan-tailscale-test 100.100.100.100
Server:         100.100.100.100
Address:        100.100.100.100#53

Name:   gitpod-kyle-brennan-tailscale-test.kylos101.github.beta.tailscale.net
Address: 100.121.148.54

ubuntu@database:~$ netcat -u 100.100.100.100 53 -v
Connection to 100.100.100.100 53 port [udp/domain] succeeded!
�"gitpod-kyle-brennan-tailscale-teskylos101githubbeta   tailscalenet�"gitpod-kyle-brennan-tailscale-teskylos101githubbeta       tailscalenet�"gitpod-kyle-brennan-tailscale-teskylos101githubbeta    tailscalenet�"gitpod-kyle-brennan-tailscale-teskylos101githubbeta       tailscalenet�"gitpod-kyle-brennan-tailscale-teskylos101githubbeta       tailscalenet

ubuntu@database:~$ sudo ss -tapn | grep 5432
LISTEN   0        244                                           0.0.0.0:5432             0.0.0.0:*       users:(("postgres",pid=5514,fd=3))

ubuntu@database:~$ netcat localhost 5432 -v
netcat: connect to localhost port 5432 (tcp) failed: Connection refused
Connection to localhost 5432 port [tcp/postgresql] succeeded!
```

### Validate the Gitpod client

```shell
gitpod /workspace/tailscale-test $ tailscale status
# Health check:
#     - router: setting up filter/ts-input: running [/usr/sbin/ip6tables -t filter -N ts-input --wait]: exit status 3: ip6tables v1.8.4 (legacy): can't initialize ip6tables table `filter': Table does not exist (do you need to insmod?)
Perhaps ip6tables or your kernel needs to be upgraded.


100.121.148.54  gitpod-kyle-brennan-tailscale-test kylos101@    linux   -
100.106.9.63    database             kylos101@    linux   active; relay "nyc", tx 348 rx 436

gitpod /workspace/tailscale-test $ ping database
ping: database: Name or service not known

gitpod /workspace/tailscale-test $ nslookup database 100.100.100.100
;; connection timed out; no servers could be reached

gitpod /workspace/tailscale-test $ cat /etc/resolv.conf
nameserver 1.1.1.1
nameserver 8.8.8.8

gitpod /workspace/tailscale-test $ netcat -u 100.100.100.100 53 -v
Connection to 100.100.100.100 53 port [udp/domain] succeeded!
�����^C

gitpod /workspace/tailscale-test $ ping 100.100.100.100
PING 100.100.100.100 (100.100.100.100) 56(84) bytes of data.
64 bytes from 100.100.100.100: icmp_seq=1 ttl=64 time=0.088 ms
64 bytes from 100.100.100.100: icmp_seq=2 ttl=64 time=0.085 ms



gitpod /workspace/tailscale-test $ netcat 100.106.9.63 5432 -v
Connection to 100.106.9.63 5432 port [tcp/postgresql] succeeded!
```
Docker container with OpenConnect Client + OpenSSH Server


# Environment Variables

| Key           | Value                                  |
| ------------- | -------------------------------------- |
| SSH_PUB       | SSH public key for container root user |
| SERVER        | OpenConnect server address             |
| OPTIONS       | OpenConnect arguments                  |
| PASSWORD      | OpenConnect user password              |


# Ports

| Docker Port   | Published IP:Port |
| ------------- | ----------------- |
| 22            | localhost:2222    |


# Volumes

None


# Advanced

- [x] Allocate a TTY for this container
- [x] Keep STDIN open even if not attached
- [x] Privileged mode


# Example

``` bash
docker run --privileged \
-p 127.0.0.1:2222:22 \
-e SSH_PUB="$(cat ~/.ssh/id_rsa.pub)" \
-e SERVER=my_vpn_server.com \
-e OPTIONS="-u my_username --authgroup=MYGROUPNAME --no-cert-check" \
-e PASSWORD=my_password \
-t my_docker_id/my_docker_name
```


# References
OpenConnect Arguments:  
[http://www.infradead.org/openconnect/manual.html](http://www.infradead.org/openconnect/manual.html)

# Docker Configuration

Remove user **developer** from docker group

update and restart Docker so that 
/var/run/docker.sock is owned by the **root** group
Ensure Docker is not listening on nay TCP port

steps

```bash
id developer
check the docker group appear 

sudo gpasswd -d developer docker

id developer
check the docekr group is removed

ls -lh /var/run/docker.sock

sudo vim /usr/lib/systemd/system/docker.socket
change SocketGroup=root

sudo systemctl daemon-reload
sudo systemctl restart docker.socket

ls -lh /var/run/docker.sock
check if root is the owner of docker socket

netstat -tunlp | grep 2375
tcp6 0 0:::2376 :::* LISTEN 5615/dockerd


sudo vim /var/lib/systemd/system/docker.service
change ExecStart remove -h tcp://0.0.0.0:2375

sudo systemctl daemon-reload
sudo systemctl restart docker.service


```
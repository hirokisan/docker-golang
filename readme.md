Sandbox with docker for golang
====

This is sandbox to run golang apps

Dont think too much, just like a toy

## Build with compose
```
$ docker-compose up -d --build
```

## Get into container
```
$ docker exec -it golang-workspace bash
```

## Stop running
```
$ docker-compose stop
```

## IP(Docker for Mac)
```
127.0.0.1
```

## ADD HOST
```
$ sudo sh -c "echo 127.0.0.1 golang.local >> /etc/hosts"
```

## ADD KEYS(Modify $PATH by yourself)
```
$ ssh-keygen -f ~/$PATH/docker-golang/workspace/id_rsa
```

## ADD SSH CONFIG(Modify $PATH by yourself)
```
$ printf "\
Host golang.local
  HostName 127.0.0.1
  User golang
  Port 10080
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  LogLevel FATAL
  IdentityFile ~/$PATH/docker-golang/workspace/id_rsa
" | cat >> ~/.ssh/config
```

## Get into container with ssh
```
$ ssh golang.local
```

## Run this command when you log into container
```
$ bash ~/init.sh
```
```

## Referense
* [docker-compose](https://docs.docker.com/compose/compose-file/)
* [docker-compose-build](https://docs.docker.com/compose/reference/build/)
* [Install Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

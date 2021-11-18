日常工作生活使用的`docker-compose.yml`配置文件

# 常用命令
## 安装Docker
```bash
sudo apt-get update && sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common && curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add - && sudo apt-key fingerprint 0EBFCD88 && sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable" && sudo apt-get update && sudo apt-get -y install docker-ce docker-ce-cli containerd.io && sudo docker --version
```

安装完毕，记得优化下配置

```bash
# 修改/etc/docker/daemon.json，很重要，限制docker使用的磁盘资源
$ sudo vim /etc/docker/daemon.json
{
    "data-root": "/data/docker", // 之前如果有启动过的容器，或者拉取的镜像，修改这个值，将会失效
    "log-driver":"json-file",
    "log-opts":{
        "max-size":"10m",
        "max-file":"3",
        "labels":"production_status",
        "env":"os,customer"
    },
    "insecure-registries":[
        "registryhost:5000",
        "10.0.0.0/8"
    ],
    "registry-mirrors":[
        "https://hub-mirror.c.163.com",
        "https://mirror.baidubce.com"
    ]
}
sudo systemctl daemon-reload
sudo systemctl restart docker

# 配置docker开机自启动
sudo systemctl enable docker
```

## 安装DockerCompose

```bash
sudo curl -L "https://ghproxy.com/https://github.com//docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose && docker-compose --version
```

## Docker常用命令

[Docker常用命令](https://blog.gcdd.top/p/7569/)

## DockerCompose常用命令

```bash
# 启动
docker-compose up -d
# 停止
docker-compose stop
# 停止并删除容器
docker-compose down
# 重启容器，但是不重新创建
docker-compose restart
# 删除并重启
docker-compose down && docker-compose up -d
# 查看日志
docker-compose logs -f
```

善用`--help`，例如

```bash
$ docker-compose --help
Define and run multi-container applications with Docker.

Usage:
  docker-compose [-f <arg>...] [--profile <name>...] [options] [--] [COMMAND] [ARGS...]
  docker-compose -h|--help

Options:
  -f, --file FILE             Specify an alternate compose file
                              (default: docker-compose.yml)
  -p, --project-name NAME     Specify an alternate project name
                              (default: directory name)
  --profile NAME              Specify a profile to enable
  -c, --context NAME          Specify a context name
  --verbose                   Show more output
  --log-level LEVEL           Set log level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
  --ansi (never|always|auto)  Control when to print ANSI control characters
  --no-ansi                   Do not print ANSI control characters (DEPRECATED)
  -v, --version               Print version and exit
  -H, --host HOST             Daemon socket to connect to

  --tls                       Use TLS; implied by --tlsverify
  --tlscacert CA_PATH         Trust certs signed only by this CA
  --tlscert CLIENT_CERT_PATH  Path to TLS certificate file
  --tlskey TLS_KEY_PATH       Path to TLS key file
  --tlsverify                 Use TLS and verify the remote
  --skip-hostname-check       Don't check the daemon's hostname against the
                              name specified in the client certificate
  --project-directory PATH    Specify an alternate working directory
                              (default: the path of the Compose file)
  --compatibility             If set, Compose will attempt to convert keys
                              in v3 files to their non-Swarm equivalent (DEPRECATED)
  --env-file PATH             Specify an alternate environment file

Commands:
  build              Build or rebuild services
  config             Validate and view the Compose file
  create             Create services
  down               Stop and remove resources
  events             Receive real time events from containers
  exec               Execute a command in a running container
  help               Get help on a command
  images             List images
  kill               Kill containers
  logs               View output from containers
  pause              Pause services
  port               Print the public port for a port binding
  ps                 List containers
  pull               Pull service images
  push               Push service images
  restart            Restart services
  rm                 Remove stopped containers
  run                Run a one-off command
  scale              Set number of containers for a service
  start              Start services
  stop               Stop services
  top                Display the running processes
  unpause            Unpause services
  up                 Create and start containers
  version            Show version information and quit
```


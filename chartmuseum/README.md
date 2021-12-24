- [bitnami/chartmuseum](https://hub.docker.com/r/bitnami/chartmuseum)
- [github/chartmuseum](https://github.com/helm/chartmuseum)

# FAQ
## 上传出现错误
```json
{"error":"open /bitnami/data/scmm-platform-0.1.1.tgz: permission denied"}
```

进入安装目录执行
```bash
chown -R 1001:1001 data
```

原因是bitnami的镜像，都从属于`1001:1001`的用户
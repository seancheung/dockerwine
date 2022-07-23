# dockerwine

Wine with xvfb/x11/noVNC over alpine in docker

> This is x86_64 version of wine only(i.e. wine64). Check [alpinewine](https://github.com/seancheung/alpinewine) if you need x86 version.

## Image

```bash
docker pull seancheung/dockerwine:<tag>
```

## Tags

| tag    | description                         |
| ------ | ----------------------------------- |
| latest | i.e. novnc                           |
| wine   | wine x86_64 + xvfb                  |
| x11    | wine x86_64 + xvfb + x11vnc         |
| novnc  | wine x86_64 + xvfb + x11vnc + novnc |

> X11 is a VNC server. NoVNC is a VNC web client.

## Environments

| Name             | default         |
| ---------------- | --------------- |
| WINEDLLOVERRIDES | mscoree,mshtml= |
| WINEPREFIX       | /root/wine      |
| SCREEN           | 0 1280x1024x8   |
| DISPLAY          | :1              |
| LANG             | en_US.UTF-8     |
| LC_ALL           | en_US.UTF-8     |

> WINEDLLOVERRIDES: Wine DLL overrides.

> SCREEN: This option creates screen screennum and sets its width, height, and depth to W, H, and D respectively. By default, only screen 0 exists and has the dimensions 1280x1024x8.

## Usage

### Wine

> `wine` tag is used as base images. But you can still run programs headlessly with them.

To run a program in foreground:

```bash
docker run -d --name mywine -v /var/opt/myprogram:/path/to/myprogram seancheung/dockerwine
docker exec mywine wine64 /var/opt/myprogram/myprogram.exe
```

To run a program in background:

```bash
docker run -d --name mywine seancheung/dockerwine

cat > myprogram.conf <<EOF
[program:myprogram]
command=/usr/bin/wine64 /path/to/myprogram.exe
priority=100
stdout_logfile=/var/log/myprogram.stdout.log
stderr_logfile=/var/log/myprogram.stderr.log
EOF

docker cp myprogram.conf mywine:/etc/supervisor/conf.d/
docker exec mywine supervisorctl reload
```

> For debugging purpose, add `environment=WINEDEBUG=warn+all`

### X11

| port | description   |
| ---- | ------------- |
| 5900 | x11vnc server |

### noVNC

| port | description   |
| ---- | ------------- |
| 5900 | x11vnc server |
| 8080 | noVNC         |

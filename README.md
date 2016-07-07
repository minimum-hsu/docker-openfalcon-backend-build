# docker-openfalcon-build

## Build

Enter the following command in the repo directory.

```
$ docker build -t openfalcon-build -f docker/ubuntu/Dockerfile .
```

## Run

```
$mkdir /tmp/pack
$ docker run -d -v /tmp/pack:/package openfalcon-build
```

#!/bin/sh
#VERSION=1.16.2
#VERSION=2021.8.2
#VERSION=2021.9.3
#VERSION=2022.2.6
#VERSION=2022.6.2
#VERSION=2024.5.5
VERSION=2024.12.4
#VERSION=latest
DIR=/home/homeassistant/esphome
[ -f `basename $0` ] && DIR=$PWD
_ver=`echo $VERSION | awk -F. '{printf("%04d%02d%02d\n",$1,$2,$3)}'`
 
if [ "$VERSION" != "latest" -a "$_ver" -lt 20240800 ]
then
	docker run --rm -p 6052:6052 \
	    --name "esphome" \
	    --network host \
	    -v $DIR:/config \
	    -v $DIR/gitconfig:/root/.gitconfig:ro \
	    -v $DIR/SRC/cat9554:/usr/src/app/esphome/components/cat9554:ro \
	    -v $DIR/SRC/cat9554:/esphome/esphome/components/cat9554:ro \
	    -it esphome/esphome:${VERSION} /config dashboard
else
	docker run --rm -p 6052:6052 \
	    --name "esphome" \
	    --network host \
	    -v $DIR:/config \
	    -v $DIR/gitconfig:/root/.gitconfig:ro \
	    -v $DIR/SRC/cat9554:/usr/src/app/esphome/components/cat9554:ro \
	    -v $DIR/SRC/cat9554:/esphome/esphome/components/cat9554:ro \
	    -it esphome/esphome:${VERSION} dashboard /config
fi

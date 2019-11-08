#!/bin/sh
name=`grep "name" Cargo.toml|awk '{print $3}'|sed 's/"//g'`
tag=$name
port=80
df=tmp.Dockerfile
target=x86_64-unknown-linux-musl
uselinux=0
if [ $# -lt 1 ];then
    echo "please input the name port and target"
    echo "for example: ../RMB/build_image.sh myimage 80 linux"
    exit 1
fi

if [  $# -gt 0  ];then
    tag=$1
fi

if [ $# -gt 1 ];then
    port=$2
fi

if [ $# -gt 2 ];then
    if [ $3 == "linux" ];then
        target=x86_64-unknown-linux-gnu
        uselinux=1
    fi
fi

file=target/$target/release/$name

if [ $uselinux == 0 ];then
    echo 'FROM scratch' > $df    
    echo "COPY $file /" >> $df
    echo "EXPOSE $port" >> $df
    echo "CMD [ \"/$name\" ]" >> $df
else
    echo 'FROM alpine:edge' > $df
    echo 'WORKDIR /app' >> $df
    echo "RUN cd /app" >> $df
    echo "COPY $file /app" >> $df
    echo "EXPOSE $port" >> $df
    echo "CMD [ \"/app/$name\" ]" >> $df
fi

cat $df
docker build -f $df -t $tag .

rm $df

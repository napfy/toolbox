#!/bin/sh
df=tmp.Dockerfile
port=3000
file=index.js
entry='index.js'


if [ $# -lt 1 ] || [ $1 == '-h' ] ; then
    echo "build_image.sh NAME [entry_path] [PORT] [add_file1] [file2] ... [fileN]"
    exit 1
else
    tag=$1
fi


echo 'FROM node:carbon-alpine' > $df
echo 'WORKDIR /app' >> $df
echo 'RUN cd /app' >> $df
echo 'COPY package.json ./package.json ' >> $df
echo 'RUN npm install' >> $df

if [ $# -gt 2 ];then
    for i in $(seq 3 $#)
    do
        if [ $i -lt 4 ];then
            port=$3
        else
            echo "COPY ${!i} ./${!i}" >> $df 
        fi
    done    
fi

if [ ! -z "$2" ];then
    entry=$2
    cmd=$2
fi

echo "COPY $entry ./$entry" >> $df
echo "EXPOSE $port" >> $df
echo "CMD node $entry" >> $df


docker build -f $df -t $tag .
rm $df

#!/bin/bash

dockerRepo=""

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -d|--docker-repo)
    dockerRepo="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

date=$(date +%s)
buildVersion="$date"
imageName=${dockerRepo}andresvilla/utility-image
docker build -t "${imageName}:${buildVersion}" -t "${imageName}:latest" .

echo "image: ${imageName}:${buildVersion}"

while true; do
    read -p "Do you want to push this version?:" yn
    case $yn in
        [Yy]* ) docker push "${imageName}:${buildVersion}"
                exit;;
        [Nn]* ) break;;
        * ) echo "Please answer y or n.";;
    esac
done
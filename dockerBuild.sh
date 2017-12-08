#!/bin/bash

dockerRepo=""
imagePath="andresvilla/utility-image"

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -d|--docker-repo)
    dockerRepo="$2"
    shift # past argument
    ;;
    -p|--image-path)
    imagePath="$2"
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
imageName=${dockerRepo}${imagePath}
docker build -t "${imageName}:${buildVersion}" -t "${imageName}:latest" .
buildResult=$?
if [ $buildResult -eq 0 ]; then
    echo "Docker build succeeded"
else
  echo "Docker build failed"
  exit 1
fi

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
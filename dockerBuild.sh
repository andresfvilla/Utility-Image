#!/bin/bash

dockerRepo=""
imagePath="andresvilla/utility-image"
buildAll=""
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
    -b|--build-all)
    buildAll="Y"
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

#Build Standard image
docker build -t "${imageName}:${buildVersion}" -t "${imageName}:latest" .
buildResult=$?
printf "\n\n\n\n==============FINISHED Standard BUILD==============\n\n\n\n"

#Build gpu image
docker build -t "${imageName}-gpu:${buildVersion}" -t "${imageName}-gpu:latest" . --build-arg BASE_IMAGE="nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04"
gpuBuildResult=$?
printf "\n\n\n\n==============FINISHED GPU BUILD==============\n\n\n\n"


if [[ ($buildResult -ne 0 || $gpuBuildResult -ne 0)]]; then
  echo "Docker build failed"
  exit 1
fi

echo "image: ${imageName}:${buildVersion}"
echo "image: ${imageName}-gpu:${buildVersion}"

while true; do
    if [[ -z $buildAll ]]; then
        read -p "Do you want to push these versions?:" yn
        case $yn in
            [Yy]* ) docker push "${imageName}:${buildVersion}"
                    docker push "${imageName}-gpu:${buildVersion}"
                    exit;;
            [Nn]* ) break;;
            * ) echo "Please answer y or n.";;
        esac
    else
        docker push "${imageName}:${buildVersion}"
        docker push "${imageName}-gpu:${buildVersion}"
        break
    fi
done
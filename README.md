# CuraEngine DockerBuilder


A docker image to ease the configuration of a dev environment 

## Build or pull docker image and install CuraEngine
git clone https://github.com/chepo92/Cura-Engine-Docker-Builder
cd Cura-Engine-Docker-Builder
Build container from dockerfile 
docker build -t cura-engine-builder .

Or use compose:

docker compose up -d
docker compose exec cura-engine bash

Or pull image from docker hub :
docker pull chepo92/cura-engine-builder:latest
docker run -it --rm -v ${PWD}:/workspace chepo92/cura-engine-builder:latest

Usage 
Mount and run the container:
  
docker run -it --rm -v ${PWD}:/workspace cura-builder  
  
Inside container:

conan config install https://github.com/ultimaker/conan-config.git
conan profile detect --force

git clone https://github.com/Ultimaker/CuraEngine.git
cd CuraEngine

conan install . --build=missing --update -s build_type=Debug
cmake --preset conan-debug

## Build (compile) CuraEngine
Run for every change you make
cmake --build --preset conan-debug


## Use the built app 
# For Linux/MacOS
source build/[Debug,Release]/generators/conanrun.sh
  
./build/[Debug,Release]/CuraEngine connect 127.0.0.1:49674
  

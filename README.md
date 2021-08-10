[![CI to Docker Hub](https://github.com/rttrorg/rttr-docker/actions/workflows/docker_hub.yml/badge.svg)](https://github.com/rttrorg/rttr-docker/actions/workflows/docker_hub.yml)
# Docker
The `rttr/docker-ci` image contains various compilers and tools for developing [rttr](https://github.com/rttrorg/rttr).

The image is pushed automatically to [DockerHub](https://hub.docker.com/r/rttr/docker-ci)

Perquisites: [Install Docker](https://docs.docker.com/engine/install/)


#1 Pull the image:

```sh
docker pull rttr/docker-ci:latest
```
#2 Run the image:
```sh
docker run -v $PWD:/$PWD --workdir=$PWD --privileged -ti --network host rttr/docker-ci:latest
```


# Content
- g++-11 `(Ubuntu 11.1.0-1ubuntu1~20.04) 11.1.0`
- clang++-12 `Ubuntu clang version 12.0.1-++20210802051739`
- cmake `version 3.21.1`
- cmake-format `0.6.13`
- ninja `1.10.0`
- make `GNU Make 4.2.1`
- doxygen `1.8.17`
- dot `graphviz version 2.43.0 (0)`
- cppcheck `Cppcheck 2.6 dev`
- iwyu `include-what-you-use 0.12 based on clang version 9.0.1-10`
- valgrind `valgrind-3.15.0`
- oclint `OCLint version 21.05.`
- pvs-studio `PVS-Studio 7.14.50353.141`
- sonar-scanner `INFO: SonarScanner 4.4.0.2170`
- openJDK `Java 11.0.3 AdoptOpenJDK (64-bit)`
- lcov `lcov: LCOV version 1.14`
- Ubuntu `INFO: Linux 5.4.0-80-generic amd64`

# Historical Compilers
- g++
  - g++-4.8, g++-4.9, g++-5, g++-7, g++-8, g++-9, g++-10
- clang
  - clang-3.5, clang-3.6, clang-3.7, clang-3.8, clang-3.9, clang-4.0, clang-5.0, clang-6.0, clang-7, clang-8, clang-9, clang-10, clang-11

# Print version numbers

```sh
for TOOL in g++-11 clang++-12 cmake cmake-format ninja valgrind make doxygen graphviz iwyu cppcheck oclint pvs-studio sonar-scanner build-wrapper-linux-x86-64 lcov; do echo $TOOL; $TOOL --version; echo ""; done
```
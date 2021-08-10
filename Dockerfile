FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-add-repository -y "deb http://archive.ubuntu.com/ubuntu/ xenial main" && \
    apt-add-repository -y "deb http://archive.ubuntu.com/ubuntu/ xenial universe" && \
    apt-add-repository -y "deb http://archive.ubuntu.com/ubuntu/ xenial-updates main" && \
    apt-add-repository -y "deb http://archive.ubuntu.com/ubuntu/ xenial-updates universe" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    git ninja-build make doxygen graphviz unzip iwyu libboost-all-dev valgrind vera++ \
    lsb-release wget clang-format clang-tools-11 clang-tidy-11 lcov gpg-agent \
    g++-4.8 g++-4.9 g++-5 g++-7 g++-8 g++-9 g++-10 g++ \
    clang-3.5 clang-3.6 clang-3.7 clang-3.8 clang-3.9 clang-4.0 clang-5.0 clang-6.0 clang-7 clang-8 clang-9 clang-10 clang-11 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#######################################################################################
# CMake
#######################################################################################

RUN CMAKE_VERSION=3.21.1 && \
    wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION-Linux-x86_64.sh && \
    chmod a+x cmake-$CMAKE_VERSION-Linux-x86_64.sh && \
    ./cmake-$CMAKE_VERSION-Linux-x86_64.sh --skip-license --prefix=/usr/local && \
    rm cmake-$CMAKE_VERSION-Linux-x86_64.sh

#######################################################################################
# GCC
#######################################################################################

RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y g++-11 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#######################################################################################
# Clang
#######################################################################################

RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh && ./llvm.sh 12 && rm llvm.sh

#######################################################################################
# CppCheck
#######################################################################################

RUN git clone --depth 1 https://github.com/danmar/cppcheck.git && \
    cmake -S cppcheck -B cppcheck/build -G Ninja -DCMAKE_BUILD_TYPE=Release && \
    cmake --build cppcheck/build --target install && \
    rm -fr cppcheck

#######################################################################################
# PVS Studio
#######################################################################################

# see https://www.viva64.com/en/m/0039/#IDA60A8D2301
RUN wget -q -O - https://files.viva64.com/etc/pubkey.txt | apt-key add - && \
    wget -O /etc/apt/sources.list.d/viva64.list https://files.viva64.com/etc/viva64.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends pvs-studio && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#######################################################################################
# OCLint
#######################################################################################

RUN OCLINT_RELEASE=oclint-21.05-llvm-12.0.0-x86_64-linux-ubuntu-20.04.tar.gz && \
    cd ~ && \
    wget https://github.com/oclint/oclint/releases/download/v21.05/${OCLINT_RELEASE} && \
    tar xfz ${OCLINT_RELEASE} && \
    rm ${OCLINT_RELEASE}

ENV PATH=${PATH}:/root/oclint-21.05/bin

#######################################################################################
# SonarSource
#######################################################################################

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-11-jdk

ENV SONAR_SCANNER_VERSION=4.4.0.2170

RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip && \
    rm sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip

ENV PATH=${PATH}:/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin

RUN wget https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip && \
    unzip build-wrapper-linux-x86.zip && \
    rm build-wrapper-linux-x86.zip

ENV PATH=${PATH}:/build-wrapper-linux-x86

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-pip

RUN pip3 install cmakelang==0.6.13
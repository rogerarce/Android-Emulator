FROM ubuntu:16.04
RUN apt-get update && apt-get upgrade -y \
&& apt-get install -y wget unzip software-properties-common python-software-properties openjdk-8-jdk \
&& apt-get install -y --no-install-recommends locales locales-all \
&& apt autoclean
RUN mkdir android
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
RUN unzip sdk-tools-linux-3859397.zip
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN ./tools/bin/sdkmanager --update

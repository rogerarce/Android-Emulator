FROM java:8

RUN dpkg --add-architecture i386 && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* && \
apt-get update && \
apt-get install -yq libc6:i386 libstdc++6:i386 zlib1g:i386 libncurses5:i386 build-essential libssl-dev ruby ruby-dev --no-install-recommends && \
apt-get clean

RUN gem install bundler

RUN mkdir -p /usr/local/android-sdk-linux
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O tools.zip
RUN unzip tools.zip -d /usr/local/android-sdk-linux
RUN rm tools.zip

ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

RUN mkdir $ANDROID_HOME/licenses
RUN echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > $ANDROID_HOME/licenses/android-sdk-license
RUN echo d56f5187479451eabf01fb78af6dfcb131a6481e >> $ANDROID_HOME/licenses/android-sdk-license
RUN echo 84831b9409646a918e30573bab4c9c91346d8abd > $ANDROID_HOME/licenses/android-sdk-preview-license

RUN $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools" "emulator"
RUN $ANDROID_HOME/tools/bin/sdkmanager "build-tools;27.0.3" "build-tools;25.0.1"
RUN $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-27" "platforms;android-25"
RUN $ANDROID_HOME/tools/bin/sdkmanager "extras;android;m2repository" "extras;google;m2repository"
RUN $ANDROID_HOME/tools/bin/sdkmanager "extras;android;m2repository" "extras;google;m2repository"
RUN $ANDROID_HOME/tools/bin/sdkmanager "system-images;android-25;google_apis;x86"
RUN $ANDROID_HOME/tools/bin/sdkmanager --licenses

## Create and run avd
#RUN $ANDROID_HOME/tools/bin/avdmanager create avd -n avdname -k "system-images;android-25;google_apis;x86"
#CMD $ANDROID_HOME/tools/emulator -avd avdname -no-audio

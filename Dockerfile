FROM arm64v8/alpine:3.18

# obtain at: http://d.defold.com/stable/info.json
ENV DEFOLD_VERSION 1.5.0
ENV DEFOLD_VERSION_SHA1 57b34efdf44a922acc6f21d285b207029b53927d

# copy shortcut scripts
COPY ./scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*

# download bob.jar
RUN curl -L -o /usr/local/bin/bob.jar http://d.defold.com/archive/${DEFOLD_VERSION_SHA1}/bob/bob.jar

# download dmengine_headless
RUN curl -L -o /usr/local/bin/dmengine_headless http://d.defold.com/archive/${DEFOLD_VERSION_SHA1}/engine/x86_64-linux/dmengine_headless \
    && chmod +x /usr/local/bin/dmengine_headless

# update file permissions
RUN chown root:root /usr/local/bin/*

# install some dependencies
# according to: https://forum.defold.com/t/spine-4-1/72923/2
RUN apk update \
 && apk add --no-cache openjdk17 openal-soft-dev mesa-dev mesa-gl freeglut-dev \
 && rm -rf /var/cache/apk/*

CMD [ "bob" ]

#!/usr/bin/env bash

# This script will do most of the work for rewriting dynamically Dockerfile_base.
# The alpine distro needs full substitution of package manager used (apk).
# [Warning] when changes are introduced to Dockerfile_base they need to be
# reflected here as well, most of the functions depends on matching comments
# sections of command signature match to replace them. In time some of the 
# packages used may become obsolete, or newer version of linux distribution
# may require different approach, and in that case most of the maintenance
# will be done here. Comments placed here represent placeholders for code to 
# be changed and restored back to default.
#
# Most of the changes are drastical b/c of alpine. It is well deserved that 
# function is named after it.
#
# Always call restore_to_default after this function and build of alpine images.
# Usage: {install_alpine_dependecies [build..] restore_to_default}
install_alpine_dependecies() {
  dibian_distro_updates
  prep_npm_redis
  alpine_distro_update
}

# Dependencies fetch by order of execution:

# FIRST
#
# Comment in file DEBIAN DISTRO UPDATES RUN
dibian_distro_updates() {
  sed -i '' "s/RUN apt-get update \&\& apt-get install -y build-essential coreutils git libsqlite3-dev gnupg pkg-config libxml2-dev libxslt-dev make autoconf automake/# DEBIAN DISTRO UPDATES RUN/g" $PATH_DOCKERFILE_BASE
}

# SECOND
#
# Adds comments NPM_ONE NPM_TWO NPM_THREE NPM_FOUR NPM_FILE NPM_SIX
# Adds comments REDIS_ONE REDIS_TWO REDIS_THREE
# Later placeholders will be restored after NPM and redis update is done.
# All changes must be reflected both ways (Dockerfile_base + install_dependencies.sh)
prep_npm_redis() {
  sed -i '' "s/RUN apt-get update \&\& apt-get install -y build-essential coreutils git libsqlite3-dev gnupg pkg-config libxml2-dev libxslt-dev make autoconf automake/# DEBIAN DISTRO UPDATES RUN/g" $PATH_DOCKERFILE_BASE
  sed -i '' "s/RUN apt-get remove -y cmdtest \&\& apt-get remove -y yarn \&\& apt-get clean \\\/# NPM_ONE/g" $PATH_DOCKERFILE_BASE
  sed -i '' "s/\&\& apt-get install -y curl software-properties-common \\\/# NPM_TWO/g" $PATH_DOCKERFILE_BASE
  sed -i '' "s/\&\& curl -sL https:\/\/deb.nodesource.com\/setup_18.x | bash - \\\/# NPM_THREE/g" $PATH_DOCKERFILE_BASE
  sed -i '' "s/\&\& apt-get install -y nodejs \&\& npm install -g npm@latest \\\/# NPM_FOUR/g" $PATH_DOCKERFILE_BASE
  sed -i '' "s/\&\& cd .\/spec\/dummy\/ \&\& npm install/# NPM_FIVE/g" $PATH_DOCKERFILE_BASE
  sed -i '' "s/RUN cd .\//# NPM_SIX/g" $PATH_DOCKERFILE_BASE
  
  sed -i '' "s/RUN curl -fsSL https:\/\/packages.redis.io\/gpg | gpg --dearmor -o \/usr\/share\/keyrings\/redis-archive-keyring.gpg \\\/# REDIS_ONE/g" $PATH_DOCKERFILE_BASE
  sed -i '' "s/    echo \"deb \[signed-by=\/usr\/share\/keyrings\/redis-archive-keyring.gpg\] https:\/\/packages.redis.io\/deb \$(lsb_release -cs) main\" \| tee \/etc\/apt\/sources.list.d\/redis.list \\\/# REDIS_TWO/g" $PATH_DOCKERFILE_BASE
  sed -i '' "s/    apt-get update \&\& apt-get install -y redis/# REDIS_THREE/g" $PATH_DOCKERFILE_BASE
}

# THIRD
#
# Alpine install packages
# Comment in file ALPINE DISTRO UPDATES, ALPINE-UPDATES-NPM
# Sets apk commands"
alpine_distro_update() {
  sed -i '' "s/# ALPINE DISTRO UPDATES/RUN apk update \&\& apk add --update autoconf automake bash build-base coreutils curl git libxml2 libxml2-dev libxslt libxslt-dev nodejs openssh openssl openssl-dev perl ruby-nokogiri sqlite sqlite-dev tar shared-mime-info protobuf tzdata redis/g" $PATH_DOCKERFILE_BASE
  sed -i '' "s/# ALPINE-UPDATES-NPM/RUN apk update \&\& apk add --update nodejs npm/g" $PATH_DOCKERFILE_BASE
}

# LAST
#
# Restore file as default. (Also needed for next linux based install.)
restore_to_default() {
# Comment out apk parts
sed -i '' "s/RUN apk update \&\& apk add --update autoconf automake bash build-base coreutils curl git libxml2 libxml2-dev libxslt libxslt-dev nodejs openssh openssl openssl-dev perl ruby-nokogiri sqlite sqlite-dev tar shared-mime-info protobuf tzdata redis/# ALPINE DISTRO UPDATES/g" $PATH_DOCKERFILE_BASE
sed -i '' "s/# # ALPINE DISTRO UPDATES/# RUN apk update \&\& apk add --update autoconf automake bash build-base coreutils curl git libxml2 libxml2-dev libxslt libxslt-dev nodejs openssh openssl openssl-dev perl ruby-nokogiri sqlite sqlite-dev tar shared-mime-info protobuf tzdata redis/g" $PATH_DOCKERFILE_BASE
sed -i '' "s/RUN apk update \&\& apk add --update nodejs npm/# ALPINE-UPDATES-NPM/g" $PATH_DOCKERFILE_BASE

# Restore to Debian based apt package manager
sed -i '' "s/RUN apk update \&\& apk add --update nodejs npm/# ALPINE-UPDATES-NPM/g" $PATH_DOCKERFILE_BASE
sed -i '' "s/# DEBIAN DISTRO UPDATES RUN/RUN apt-get update \&\& apt-get install -y build-essential coreutils git libsqlite3-dev gnupg pkg-config libxml2-dev libxslt-dev make autoconf automake/g" $PATH_DOCKERFILE_BASE

# Redis
sed -i '' "s/# REDIS_ONE/RUN curl -fsSL https:\/\/packages.redis.io\/gpg | gpg --dearmor -o \/usr\/share\/keyrings\/redis-archive-keyring.gpg \\\/g" $PATH_DOCKERFILE_BASE
sed -i '' "s/# REDIS_TWO/    echo \"deb \[signed-by=\/usr\/share\/keyrings\/redis-archive-keyring.gpg\] https:\/\/packages.redis.io\/deb \$(lsb_release -cs) main\" \| tee \/etc\/apt\/sources.list.d\/redis.list \\\/g" $PATH_DOCKERFILE_BASE
sed -i '' "s/# REDIS_THREE/    apt-get update \&\& apt-get install -y redis/g" $PATH_DOCKERFILE_BASE

# NPM
sed -i '' "s/# NPM_ONE/RUN apt-get remove -y cmdtest \&\& apt-get remove -y yarn \&\& apt-get clean \\\/g" $PATH_DOCKERFILE_BASE
sed -i '' "s/# NPM_TWO/\&\& apt-get install -y curl software-properties-common \\\/g" $PATH_DOCKERFILE_BASE
sed -i '' "s/# NPM_THREE/\&\& curl -sL https:\/\/deb.nodesource.com\/setup_18.x | bash - \\\/g" $PATH_DOCKERFILE_BASE
sed -i '' "s/# NPM_FOUR/\&\& apt-get install -y nodejs \&\& npm install -g npm@latest \\\/g" $PATH_DOCKERFILE_BASE
sed -i '' "s/# NPM_FIVE/\&\& cd .\/spec\/dummy\/ \&\& npm install/g" $PATH_DOCKERFILE_BASE
sed -i '' "s/# NPM_SIX/RUN cd .\//g" $PATH_DOCKERFILE_BASE
}
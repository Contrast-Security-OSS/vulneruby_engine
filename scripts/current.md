docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:2.7 -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=2.7/ARG RUBY_VER=3.0/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.0 -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=3.0/ARG RUBY_VER=3.1/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.1 -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=3.1/ARG RUBY_VER=3.2/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.2 -f ./docker/Dockerfile_base


sed -i '' "s/ARG DISTRO=''/ARG DISTRO='-slim-bullseye'/g" ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=3.2/ARG RUBY_VER=2.7/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:2.7-slim-bullseye -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=2.7/ARG RUBY_VER=3.0/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.0-slim-bullseye -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=3.0/ARG RUBY_VER=3.1/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.1-slim-bullseye -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=3.1/ARG RUBY_VER=3.2/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.2-slim-bullseye -f ./docker/Dockerfile_base


sed -i '' "s/ARG DISTRO='-slim-bullseye'/ARG DISTRO='-slim-buster'/g" ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=3.1/ARG RUBY_VER=2.7/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:2.7-slim-buster -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=2.7/ARG RUBY_VER=3.0/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.0-slim-buster -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=3.0/ARG RUBY_VER=3.1/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.1-slim-buster -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=3.1/ARG RUBY_VER=3.2/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.2-slim-buster -f ./docker/Dockerfile_base

sed -i '' "s/RUN apt-get update \&\& apt-get install -y build-essential coreutils git libsqlite3-dev gnupg pkg-config libxml2-dev libxslt-dev make autoconf automake/# DEBIAN DISTRO UPDATES RUN/g" ./docker/Dockerfile_base
sed -i '' "s/RUN apt-get remove -y cmdtest \&\& apt-get remove -y yarn \&\& apt-get clean \\\/# NPM_ONE/g" ./docker/Dockerfile_base
sed -i '' "s/\&\& apt-get install -y curl software-properties-common \\\/# NPM_TWO/g" ./docker/Dockerfile_base
sed -i '' "s/\&\& curl -sL https:\/\/deb.nodesource.com\/setup_18.x | bash - \\\/# NPM_THREE/g" ./docker/Dockerfile_base
sed -i '' "s/\&\& apt-get install -y nodejs \&\& npm install -g npm@latest \\\/# NPM_FOUR/g" ./docker/Dockerfile_base
sed -i '' "s/\&\& cd .\/spec\/dummy\/ \&\& npm install/# NPM_FIVE/g" ./docker/Dockerfile_base
sed -i '' "s/RUN cd .\//# NPM_SIX/g" ./docker/Dockerfile_base
sed -i '' "s/RUN curl -fsSL https:\/\/packages.redis.io\/gpg | gpg --dearmor -o \/usr\/share\/keyrings\/redis-archive-keyring.gpg \\\/# REDIS_ONE/g" ./docker/Dockerfile_base
sed -i '' "s/    echo \"deb \[signed-by=\/usr\/share\/keyrings\/redis-archive-keyring.gpg\] https:\/\/packages.redis.io\/deb \$(lsb_release -cs) main\" \| tee \/etc\/apt\/sources.list.d\/redis.list \\\/# REDIS_TWO/g" ./docker/Dockerfile_base
sed -i '' "s/    apt-get update \&\& apt-get install -y redis/# REDIS_THREE/g" ./docker/Dockerfile_base


sed -i '' "s/# ALPINE DISTRO UPDATES/RUN apk update \&\& apk add --update autoconf automake bash build-base coreutils curl git libxml2 libxml2-dev libxslt libxslt-dev nodejs openssh openssl openssl-dev perl ruby-nokogiri sqlite sqlite-dev tar shared-mime-info protobuf tzdata redis/g" ./docker/Dockerfile_base
sed -i '' "s/# ALPINE-UPDATES-NPM/RUN apk update \&\& apk add --update nodejs npm/g" ./docker/Dockerfile_base
sed -i '' "s/ARG DISTRO='-slim-buster'/ARG DISTRO='-alpine3.16'/g" ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=3.2/ARG RUBY_VER=2.7/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:2.7-alpine3.16 -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=2.7/ARG RUBY_VER=3.0/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.0-alpine3.16 -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=3.0/ARG RUBY_VER=3.1/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.1-alpine3.16 -f ./docker/Dockerfile_base
sed -i '' "s/ARG RUBY_VER=3.1/ARG RUBY_VER=3.2/g" ./docker/Dockerfile_base
docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.2-alpine3.16 -f ./docker/Dockerfile_base

sed -i '' "s/ARG DISTRO='-alpine3.16'/ARG DISTRO=''/g" ./docker/Dockerfile_base
sed -i '' "s/RUN apk update \&\& apk add --update autoconf automake bash build-base coreutils curl git libxml2 libxml2-dev libxslt libxslt-dev nodejs openssh openssl openssl-dev perl ruby-nokogiri sqlite sqlite-dev tar shared-mime-info protobuf tzdata redis/# ALPINE DISTRO UPDATES/g" ./docker/Dockerfile_base
sed -i '' "s/# # ALPINE DISTRO UPDATES/# RUN apk update \&\& apk add --update autoconf automake bash build-base coreutils curl git libxml2 libxml2-dev libxslt libxslt-dev nodejs openssh openssl openssl-dev perl ruby-nokogiri sqlite sqlite-dev tar shared-mime-info protobuf tzdata redis/g" ./docker/Dockerfile_base
sed -i '' "s/# REDIS_ONE/RUN curl -fsSL https:\/\/packages.redis.io\/gpg | gpg --dearmor -o \/usr\/share\/keyrings\/redis-archive-keyring.gpg \\\/g" ./docker/Dockerfile_base
sources.list.d\/redis.list \\\/# REDIS_TWO/g" ./docker/Dockerfile_base
sed -i '' "s/RUN curl -fsSL https:\/\/packages.redis.io\/gpg | gpg --dearmor -o \/usr\/share\/keyrings\/redis-archive-keyring.gpg \\\/# REDIS_ONE/g" ./docker/Dockerfile_base
sed -i '' "s/    echo \"deb \[signed-by=\/usr\/share\/keyrings\/redis-archive-keyring.gpg\] https:\/\/packages.redis.io\/deb \$(lsb_release -cs) main\" \| tee \/etc\/apt\/
sed -i '' "s/    apt-get update \&\& apt-get install -y redis/# REDIS_THREE/g" ./docker/Dockerfile_base
sed -i '' "s/# REDIS_TWO/    echo \"deb \[signed-by=\/usr\/share\/keyrings\/redis-archive-keyring.gpg\] https:\/\/packages.redis.io\/deb \$(lsb_release -cs) main\" \| tee \/etc\/apt\/sources.list.d\/redis.list \\\/g" ./docker/Dockerfile_base
sed -i '' "s/# REDIS_THREE/    apt-get update \&\& apt-get install -y redis/g" ./docker/Dockerfile_base
sed -i '' "s/RUN apk update \&\& apk add --update nodejs npm/# ALPINE-UPDATES-NPM/g" ./docker/Dockerfile_base
sed -i '' "s/# DEBIAN DISTRO UPDATES RUN/RUN apt-get update \&\& apt-get install -y build-essential coreutils git libsqlite3-dev gnupg pkg-config libxml2-dev libxslt-dev make autoconf automake/g" ./docker/Dockerfile_base
sed -i '' "s/# NPM_ONE/RUN apt-get remove -y cmdtest \&\& apt-get remove -y yarn \&\& apt-get clean \\\/g" ./docker/Dockerfile_base
sed -i '' "s/# NPM_TWO/\&\& apt-get install -y curl software-properties-common \\\/g" ./docker/Dockerfile_base
sed -i '' "s/# NPM_THREE/\&\& curl -sL https:\/\/deb.nodesource.com\/setup_18.x | bash - \\\/g" ./docker/Dockerfile_base
sed -i '' "s/# NPM_FOUR/\&\& apt-get install -y nodejs \&\& npm install -g npm@latest \\\/g" ./docker/Dockerfile_base
sed -i '' "s/# NPM_FIVE/\&\& cd .\/spec\/dummy\/ \&\& npm install/g" ./docker/Dockerfile_base
sed -i '' "s/# NPM_SIX/RUN cd .\//g" ./docker/Dockerfile_base

docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:2.7
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.0
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.1
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.2
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:2.7-alpine3.16
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.0-alpine3.16
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.1-alpine3.16
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.2-alpine3.16
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:2.7-slim-buster
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.0-slim-buster
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.1-slim-buster
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.2-slim-buster
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:2.7-slim-bullseye
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.0-slim-bullseye
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.1-slim-bullseye
docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:3.2-slim-bullseye
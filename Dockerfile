FROM alpine:3.18.4

WORKDIR /task_master

COPY . .

RUN apk upgrade --no-cache --update && \
    apk add --no-cache --update \
		ca-certificates \
		make \
		bash \
		build-base \
		ruby \
		setuptools \
		python3 \
		py3-pip \
		npm \
		ruby-dev && \
		cd ruby/ && \
		gem install bundler && \
		bundle check || bundle install && \
		ln -s ${PWD}/bin/task_master_rb /usr/local/bin/ && \
		cd ../javascript && \
		npm install && npm install -g



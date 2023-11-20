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
		ruby-dev && \
		cd ruby/ && \
		gem install bundler && \
		bundle check || bundle install


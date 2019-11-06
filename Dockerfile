FROM ruby:2.7-rc-alpine AS gem-install
WORKDIR /work
COPY ./local_gems gems
RUN apk add --no-cache --update --virtual=build-dependencies ruby-dev build-base
# TODO specify version
RUN gem install fluent-plugin-twitter fluent-plugin-kafka
RUN cd gems && gem install --local fluent-plugin-twitter-0.6.1.gem

FROM fluent/fluentd:v1.7-1
COPY --from=gem-install /usr/lib/ruby/gems/2.5.0/gems /usr/lib/ruby/gems/2.5.0/gems

ARG githash
FROM node:18-slim
ARG githash
ENV GITHASH=${githash}
COPY ./servers/relay/package.json /tmp
COPY ./servers/relay/yarn.lock /tmp
RUN yarn --frozen-lock --cwd /tmp

WORKDIR /relay
RUN cp -a /tmp/node_modules ./node_modules
COPY ./servers/relay .
RUN yarn build

USER node
CMD node /relay/dist

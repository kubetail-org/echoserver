# Copyright 2015 The Kubernetes Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#FROM nginx:1.24.0-alpine3.17-slim
#FROM nginx:1.26.1-alpine3.19-slim
#RUN apk add --no-cache nginx-mod-http-lua
#FROM fabiocicerchia/nginx-lua:1.27.0-alpine3.20.1
#RUN rm -rf /etc/nginx/conf.d
#FROM nginx:1.26.1-alpine3.19-slim
#FROM nginx:1.27.0-alpine3.19
#RUN apk update && apk add --no-cache nginx-plus-module-lua
#ADD nginx.conf /etc/nginx/nginx.conf
#ADD README.md README.md

FROM alpine:3.17.8

RUN apk add --no-cache nginx-mod-http-lua

# Create folder for PID file
RUN mkdir -p /run/nginx

# Add custom nginx conf
COPY ./nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx"]
CMD ["-c", "/etc/nginx/nginx.conf"]

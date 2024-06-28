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

FROM alpine:3.20.1

RUN apk update
RUN apk add --no-cache openssl nginx-mod-http-lua lua-dev luarocks
RUN luarocks-5.1 install lua-resty-template

# Create folder for PID file
RUN mkdir -p /run/nginx

# Add files
COPY entrypoint.sh /usr/local/bin/
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080
EXPOSE 8443

ENTRYPOINT ["entrypoint.sh"]
CMD ["nginx", "-c", "/etc/nginx/nginx.conf"]

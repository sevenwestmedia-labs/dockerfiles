FROM ubuntu:latest

USER root

RUN set -eux pipefail
RUN apt-get update \
  && apt-get install -y \
      wget \
      curl \
      gnupg2 \
      git \
  && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee -a /etc/apt/sources.list.d/google.list \
  && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get update \
  && apt-get install -y nodejs google-chrome-stable \
  && rm -rf /var/lib/apt/lists/*

RUN export CHROME_PATH=$(which google-chrome-stable)
RUN export LHCI_BUILD_CONTEXT__EXTERNAL_BUILD_URL="$BUILD_URL"

RUN npm install -g @lhci/cli@0.3.x \
 && npm cache clean --force

ENTRYPOINT ["lhci", "healthcheck", "--fatal"]


FROM ubuntu:latest

USER root

run set -eux pipefail
run apt-get update \
    && apt-get install -y \
      wget \
      curl \
      gnupg2 \
      build-essential

# Add Chrome's apt-key
run echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee -a /etc/apt/sources.list.d/google.list \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -

# Add Node's apt-key
run curl -sL https://deb.nodesource.com/setup_10.x | bash -

# Install NodeJS and Google Chrome
run apt-get update \
    && apt-get install -y nodejs google-chrome-stable

run export CHROME_PATH=$(which google-chrome-stable)
run export LHCI_BUILD_CONTEXT__EXTERNAL_BUILD_URL="$BUILD_URL"

run npm install -g @lhci/cli@0.3.x
ENTRYPOINT ["lhci", "healthcheck", "--fatal"]
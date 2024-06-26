#!/bin/bash -xe
#
# Download GPG keys into package sources for installation into /etc/apt/keyrings/

GPG_KEYS=(
    # Debian Bullseye
    0E98404D386FA1D9 6ED0E7B82643E131 605C66F00D6C9793
    # Debian Bullseye security
    112695A0E562B32A 54404762BBB6E853
)

cd $(dirname $0)

GPG_DIR="$(readlink -f extras)"
GPG_KEYRING=bullseye.gpg
GPG_KEYSERVER=hkps://keyserver.ubuntu.com
GPG_CMD=(
    gpg --homedir "$GPG_DIR" --no-default-keyring --keyring $GPG_KEYRING
)

# Remove any old keys
rm -f extras/bullseye.gpg

# Download keys
for KEY in "${GPG_KEYS[@]}"; do
    "${GPG_CMD[@]}" --keyserver $GPG_KEYSERVER --recv-keys $KEY
done

# List keys
"${GPG_CMD[@]}" -k

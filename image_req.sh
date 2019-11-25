#!/bin/bash


if [ `uname -m`  ==  "aarch64" ]; then
        apt-get update
        apt-get install -y --no-install-recommends gnupg ca-certificates dirmngr curl git wget
        #echo 'deb http://downloads.haskell.org/debian stretch main' > /etc/apt/sources.list.d/ghc.list && \
        #apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA3CBA3FFE22B574 && \
        #apt-get update && /
        apt-get install -y --no-install-recommends zlib1g-dev libtinfo-dev libsqlite3-dev \
                g++ netbase xz-utils libnuma-dev make openssh-client
        wget https://downloads.haskell.org/~ghc/8.8.1/ghc-8.8.1-aarch64-deb9-linux.tar.xz
        tar -xvf ghc-8.8.1-aarch64-deb9-linux.tar.xz
        cd ghc-8.8.1
        ./configure
        make install
        cd ../
        rm -rf ghc-8.8.1-aarch64-deb9-linux.tar.xz ghc-8.8.1
        apt-get install -y cabal-install
        curl -fSL https://github.com/commercialhaskell/stack/releases/download/v2.1.3/stack-2.1.3-linux-aarch64.tar.gz -o  stack.tar.gz
        curl -fSL https://github.com/commercialhaskell/stack/releases/download/v2.1.3/stack-2.1.3-linux-aarch64.tar.gz.asc -o stack.tar.gz.asc
        export GNUPGHOME="$(mktemp -d)"
        gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys C5705533DA4F78D8664B5DC0575159689BEFB442
        gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys 2C6A674E85EE3FB896AFC9B965101FF31C5C154D
        gpg --batch --trusted-key 0x575159689BEFB442 --verify stack.tar.gz.asc stack.tar.gz
        tar -xf stack.tar.gz -C /usr/local/bin --strip-components=1
        /usr/local/bin/stack config set system-ghc --global true
        /usr/local/bin/stack config set install-ghc --global false
        rm -rf "$GNUPGHOME" /var/lib/apt/lists/* /stack.tar.gz.asc /stack.tar.gz
else
       echo "This is not aarch64"
fi

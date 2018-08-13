FROM alpine:latest
LABEL maintainer = "November (novemb3r@protonmail.ch)"

RUN apk add --no-cache py-setuptools perl py-lxml sleuthkit
RUN apk add --no-cache -t .build \
  ca-certificates \
  py-lxml \
  py-pip \
  py-pillow \
  python-dev \ 
  openssl-dev \  
  build-base \ 
  zlib-dev \ 
  libc-dev \ 
  jpeg-dev \ 
  automake \ 
  autoconf \
  perl-dev \
  make \
  wget \
  git \

  && export PIP_NO_CACHE_DIR=off \
  && export PIP_DISABLE_PIP_VERSION_CHECK=on \
  && pip install --upgrade pip \
  && pip install distorm3 \
  yara-python \
  pycrypto \  
  dpapick \
  construct==2.5.5-reupload \
  ioc_writer \
  openpyxl \
  ujson \
  ipython \
  colorama \
  dfvfs \
  timelib \
    
  && git clone https://github.com/volatilityfoundation/volatility.git \
  && git clone https://github.com/nov3mb3r/sift-files.git \
 
  #volatility
  
  && cd volatility \
  && python setup.py install \
  && cd / \
  && chmod -R 644 /sift-files/volatility/*.py \
  && mkdir /plugins \
  && cp /sift-files/volatility/*.py /plugins \
  
  #regripper
  && wget https://cpanmin.us/ -O /bin/cpanm \
  && chmod +x /bin/cpanm \
  && cpanm Parse::Win32Registry \
  && rm -rf /var/cache/apk/* \

  && mkdir -p /usr/share/regripper \
  && cp -R sift-files/regripper/* /usr/share/regripper \ 
  && chmod -R 644 /usr/share/regripper/* \
  && cp /usr/share/regripper/rip.pl /usr/local/bin/ \ 

  #peframe
  && pip install https://github.com/guelfoweb/peframe/archive/master.zip \ 
  
  #manual scripts
  && git clone https://github.com/matonis/page_brute.git \
  && cp page_brute/*.py /usr/local/bin \
  && rm -rf page_brute \

  #sift scripts
  && cp sift-files/densityscout/* /usr/local/bin \
  && cp sift-files/pdf-tools/* /usr/local/bin \
  && cp sift-files/scripts/* /usr/local/bin \
  && cp sift-files/sorter/* /usr/share/tsk/sorter \  
  && cp sift-files/wbtools/* /usr/local/bin \ 
  
  && git clone https://github.com/cheeky4n6monkey/4n6-scripts.git \  
  && rm -rf /4n6-scripts/python-tutorials \ 
  && cp 4n6-scripts/* /usr/local/bin \
  && rm -rf 4n6-scripts \


  && chmod 755 /usr/local/bin/* \
  
  && echo "---- Cleaning up ----" \
  && rm -rf /sift-files \
  && rm -rf /volatility \
  && apk del --purge .build 

ENV VOLATILITY_PLUGINS=/plugins
WORKDIR /cases


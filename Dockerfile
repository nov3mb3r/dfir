FROM alpine:latest
LABEL maintainer = "November (novemb3r@protonmail.ch)"

RUN apk add --no-cache py-setuptools perl py-lxml sleuthkit
RUN apk add --no-cache -t .build \
  ca-certificates \
  py-lxml \
  py-pip \
  py-pillow \
  python2-dev \ 
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
  RUN pip install --upgrade pip \
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
    
  && git clone https://github.com/nov3mb3r/sift-files.git 
 
  #volatility
RUN git clone https://github.com/volatilityfoundation/volatility.git \
  && cd volatility \
  && python setup.py install \
  && cd / \
  && chmod -R 644 /sift-files/volatility/*.py \
  && mkdir /plugins \
  && cp /sift-files/volatility/*.py /plugins
  
  #prepare perl
RUN cd /tmp \
  && wget http://www.cpan.org/src/5.0/perl-5.24.0.tar.gz \
  && tar xvzf perl-5.24.0.tar.gz \
  && cd perl-5.24.0 \
  && ./Configure -des && make && make install \
  && cd /tmp && rm -rf perl-5.24.0* \
  && cd /usr/local/bin \
  && wget https://cpanmin.us/ -O cpanm \
  && chmod +x cpanm \
  
  #prepare reg
  && mkdir /usr/local/lib/rip-lib \
  && cpanm -l /usr/local/lib/rip-lib Parse::Win32Registry \
  
  #rr download, mod & installation
  && git clone https://github.com/keydet89/RegRipper2.8.git \ 
  && cd RegRipper2.8 \
  && tail -n +2 rip.pl > rip \
  && perl -pi -e 'tr[\r][]d' rip \
  && sed -i "1i #!`which perl`" rip \
  && sed -i '2i use lib qw(/usr/local/lib/rip-lib/lib/perl5/);' rip \
  && cp rip /usr/local/bin/rip.pl \
  && chmod +x /usr/local/bin/rip.pl \
  && mkdir /usr/local/bin/plugins \
  && cp plugins/* /usr/local/bin/plugins \
  && cd

  #peframe
RUN pip install https://github.com/guelfoweb/peframe/archive/master.zip \ 
  
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
  && rm -rf /RegRipper2.8 \
  && apk del --purge .build 

ENV VOLATILITY_PLUGINS=/plugins
WORKDIR /cases

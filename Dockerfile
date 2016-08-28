FROM    phusion/baseimage
MAINTAINER      Daniel Parnell <me@danielparnell.com>

RUN apt-get update &&\
    apt-get install -y sbcl curl rlwrap build-essential time && \
    cd /tmp && curl -O http://tenet.dl.sourceforge.net/project/sbcl/sbcl/1.3.8/sbcl-1.3.8-source.tar.bz2 && tar jxvf sbcl-1.3.8-source.tar.bz2 && cd /tmp/sbcl-1.3.8 && sh ./make.sh  && sh ./install.sh && rm -rf /tmp/sbcl* &&\
    apt-get remove -y sbcl && \
    cd /tmp && curl -O https://beta.quicklisp.org/quicklisp.lisp && echo "(load \"quicklisp.lisp\") (quicklisp-quickstart:install :path \"/opt/quicklisp\") (ql::without-prompting (ql:add-to-init-file))" | sbcl && cp $HOME/.sbclrc /etc/sbclrc &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



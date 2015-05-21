FROM    phusion/baseimage
MAINTAINER      Daniel Parnell <me@danielparnell.com>

RUN apt-get update

# Install the things we need
RUN apt-get install -y sbcl curl rlwrap build-essential time

# Install sbcl 1.2.11
RUN cd /tmp && curl -O http://internode.dl.sourceforge.net/project/sbcl/sbcl/1.2.11/sbcl-1.2.11-source.tar.bz2 && tar jxvf sbcl-1.2.11-source.tar.bz2 && cd /tmp/sbcl-1.2.11 && sh ./make.sh  && sh ./install.sh && rm -rf /tmp/sbcl*

# remove the ubuntu sbcl as we now have our own
RUN apt-get remove -y sbcl

# install quicklisp
RUN curl -O http://beta.quicklisp.org/quicklisp.lisp && echo "(load \"quicklisp.lisp\") (quicklisp-quickstart:install :path \"/opt/quicklisp\") (ql::without-prompting (ql:add-to-init-file))" | sbcl && cp $HOME/.sbclrc /etc/sbclrc

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Latest centos
FROM centos:7

#### Enable systemd ####
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/sbin/init"]

########################

#### Install tools ####

# System update
RUN yum -y update

# Install devtools
RUN yum install -y vim zsh git curl wget deltarpm rubygems python-devel

# Install Development Tools
#RUN yum -y groupinstall "Development Tools"

# Install tools for selenium
#RUN yum install -y libX11 GConf2 fontconfig unzip

# Install build essential tools
RUN yum install -y gcc gcc-c++ kernel-devel make pcre pcre-devel xz-devel bzip2 lua lua-devel

# Install essentail tools for git
RUN yum install -y curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel

# Install additional tools for golang
RUN yum install -y bison glibc-devel

# Install other tools
RUN yum install -y automake libevent libevent-devel ncurses ncurses-devel

# Install sudo
RUN yum install -y sudo

# Install firewalld (if install firewalld and want to use git or connect to network, need to modify configure)
#RUN yum -y install firewalld

# Install NetworkManager
#RUN yum -y install NetworkManager

# Install sshd
RUN yum -y install openssh-server

# Clean cache
RUN yum clean all

#######################

#### Add user ####

# Add $USER
ENV user golang
RUN useradd --create-home --home-dir /home/$user --shell /usr/bin/zsh $user
## change password
RUN echo "$user:$user" | chpasswd
## use sudo command without password
RUN echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

##################

#### Enable SSH ####

USER $user
## copy key
RUN mkdir -m 0700 -p ~/.ssh
COPY ./id_rsa     /home/$user/.ssh/id_rsa
COPY ./id_rsa.pub /home/$user/.ssh/authorized_keys
### avoid fingerprint yes or no
#COPY ./known_hosts /home/$user/.ssh/known_hosts
RUN ssh-keyscan -H github.com > ~/.ssh/known_hosts
RUN sudo chown -R $user:$user ~/.ssh
RUN chmod -R 0700 ~/.ssh
RUN chmod -R 0600 ~/.ssh/*
## change config file
USER root
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
## avoid slow ssh https://www.serverpronto.com/accounts/knowledgebase.php?action=displayarticle&id=16&language=german
RUN sed -i 's/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config

## Expose ports
EXPOSE 22

####################

#### Install dotfiles ####

USER $user
RUN git clone git@github.com:hirokisan/dotfiles.git ~/dotfiles
RUN git config --global user.name "hirokisan"
RUN git config --global user.email expsharetoworld@gmail.com
USER root

##########################

#### Install gvm ####

USER $user
RUN ["/bin/bash", "-c", "bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)"]
USER root

#######################

#### Install goenv ####

USER $user
RUN git clone https://github.com/syndbg/goenv.git ~/.goenv
USER root

#######################

#### Install redis ####

#USER $user
#RUN sudo yum -y install redis
#USER root

#######################

#### Install MariaDB ####

#USER $user
#RUN sudo yum -y install mariadb mariadb-server
#RUN sudo pip install mycli
#USER root

##########################

#### Install Nginx ####

#USER $user
#RUN sudo rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
#RUN sudo yum -y update nginx-release-centos
#RUN sudo yum -y --enablerepo=nginx install nginx
#EXPOSE 8080
#USER root

##########################

#### Copy Files ####

#COPY ./nginx/docker.conf /etc/nginx/conf.d/docker.conf
#COPY ./nginx/docker.myconf /etc/nginx/conf.d/docker.myconf
#COPY ./nginx/ssl.sh /etc/nginx/ssl.sh
#COPY ./mysql/my.cnf /etc/my.cnf
#COPY ./mariadb/my.cnf.d/server.cnf /etc/my.cnf.d/server.cnf
COPY .zshrc /home/$user/.zshrc

########################

#### Systemctl ####
# Basically Docker have concept that each process has each container, but this is sandbox, so we use 1 container having some process
USER $user
COPY ./init.sh /home/$user/init.sh
RUN sudo chmod 755 /home/$user/init.sh
USER root

###################

FROM centos:latest
LABEL maintainer "huangshumao"
WORKDIR /opt
RUN set -ex \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum clean all \
    && yum update -y \
    && yum -y install kde-l10n-Chinese \
    && yum -y reinstall glibc-common \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
    && export LC_ALL=zh_CN.UTF-8 \
    && echo 'LANG="zh_CN.UTF-8"' > /etc/locale.conf \
    && yum clean all \
    && rm -rf /var/cache/yum/*
RUN set -ex \    
    && yum -y install mariadb* \
    && yum clean all \
    && rm -rf /var/cache/yum/*

COPY readme.txt /opt/readme.txt

COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
VOLUME /var/lib/mysql
   
#导出端口
EXPOSE 3306
ENTRYPOINT ["entrypoint.sh"]

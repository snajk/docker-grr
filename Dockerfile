FROM resin/rpi-raspbian
LABEL architecture="ARMv7"
MAINTAINER Alexander Kopfinger <Alexander@Kopfinger.se>

# Install dumb-init 
ADD http://launchpadlibrarian.net/275973294/dumb-init_1.1.2-1_armhf.deb /tmp/dumb-init.deb
RUN chmod +x /tmp/dumb-init.deb && \
    dpkg -i /tmp/dumb-init.deb && \
    apt-get update && \
    apt-get upgrade && \
    apt-get install -f && \
    dpkg -i /tmp/dumb-init.deb && \
    apt-get install -y ca-certificates wget apt-transport-https vim nano && \
    apt-get install curl && \
    apt-get install wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \

    # Install gitlab-runner
    curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash && \
    apt-get install -y gitlab-ci-multi-runner=1.7.1 && \
    wget -q https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-Linux-x86_64 -O /usr/bin/docker-machine && \
    chmod +x /usr/bin/docker-machine && \
    mkdir -p /etc/gitlab-runner/certs && \
    chmod -R 700 /etc/gitlab-runner && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean \

VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]
ENTRYPOINT ["dumb-init", "gitlab-ci-multi-runner", "run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
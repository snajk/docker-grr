# docker-grr
A docker container to run a gitlab runner on rasbian with ARMv7 architecture

## Usage
Either build the docker image or run it from docker hub at:

    docker pull snajk/gitlab-runner-raspbian
	
docker run -d --name gitlab-runner-raspbian --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /srv/gitlab-runner/config:/etc/gitlab-runner snajk/gitlab-runner-raspbian:latest
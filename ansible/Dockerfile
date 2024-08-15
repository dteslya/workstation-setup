ARG ANSIBLE_IMAGE_TAG=2.16-alpine-3.16
FROM willhallonline/ansible:${ANSIBLE_IMAGE_TAG}

COPY requirements.yml /
RUN ansible-galaxy install -r /requirements.yml

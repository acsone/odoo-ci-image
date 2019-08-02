FROM ubuntu:18.04

# some environment variables
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y software-properties-common \
  && add-apt-repository -y ppa:deadsnakes/ppa \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    mercurial \
    wget \
    openssh-client \
    rsync \
    make \
    python \
    python3 \
    python3.5 \
    python3.5-venv \
    python3.6 \
    python3.6-venv \
    python3.7 \
    python3.7-venv \
    virtualenv \
    postgresql-client \
    # expect provides the unbuffer utility
    tcl \
    expect \
    # odoo dependencies
    graphviz \
    node-clean-css \
    node-less \
    poppler-utils \
    antiword \
    # libreoffice for py3o
    libreoffice-writer \
    libreoffice-calc \
    # gettext to manipulate .pot, .po files
    gettext \
  # wkhtmltopdf
  && wget -q -O /tmp/wkhtmltox.deb https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb \
  && echo "f1689a1b302ff102160f2693129f789410a1708a /tmp/wkhtmltox.deb" | sha1sum -c - \
  && apt -y install /tmp/wkhtmltox.deb \
  && rm -f /tmp/wkhtmltox.deb \
  # cleanup
  && rm -fr /var/lib/apt/lists/*

# git-autoshare
RUN python3 -m venv /opt/git-autoshare \
  && /opt/git-autoshare/bin/pip install "git-autoshare>=1.0.0b4" \
  && cd /usr/local/bin \
  && ln -s /opt/git-autoshare/bin/git-autoshare-clone \
  && ln -s /opt/git-autoshare/bin/git-autoshare-prefetch \
  && ln -s /opt/git-autoshare/bin/git-autoshare-submodule-add
COPY git-wrapper /usr/local/bin/git
COPY git-autoshare.yml /root/.config/git-autoshare/repos.yml

# set git user.name and user.email so the runner can git push
RUN git config --global user.email "gitlab@acsone.eu" \
  && git config --global user.name "GitLab"

COPY ssh_config /root/.ssh/config

# avoid potential race conditions in creating these directories
RUN mkdir -p \
  /root/.local/share/Odoo/addons \
  /root/.local/share/Odoo/filestore \
  /root/.local/share/Odoo/sessions

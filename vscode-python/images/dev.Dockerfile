FROM python:3.7

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV POETRY_VERSION=1.0.0

RUN pip install --upgrade pip setuptools wheel \
    && pip install "poetry==$POETRY_VERSION"

USER ${USERNAME}
ENV VIRTUAL_ENV=/home/$USERNAME/.virtualenvs/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN mkdir /home/$USERNAME/env
WORKDIR /home/$USERNAME/env
COPY --chown=${USERNAME} pyproject.toml ./

RUN python -m venv $VIRTUAL_ENV \
    && poetry install

ENV DEBIAN_FRONTEND=dialog

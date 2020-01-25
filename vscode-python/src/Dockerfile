FROM python:3.7

ENV DEBIAN_FRONTEND=noninteractive

ARG PROJECT=project

ARG USERNAME=user
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

WORKDIR /app
COPY poetry.* pyproject.toml ./

ENV VIRTUAL_ENV=/home/$USERNAME/.virtualenvs/$PROJECT
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN python -m venv $VIRTUAL_ENV \
    && poetry install

RUN chown -R ${USERNAME}:${USERNAME} ${VIRTUAL_ENV}

ENV DEBIAN_FRONTEND=dialog

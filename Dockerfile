FROM ollama/ollama

ARG UID
ARG GID

RUN apt update && apt install -y sudo gpg curl

RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
    sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg | \
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

RUN apt update && apt install -y nvidia-container-toolkit

RUN useradd -U ollama \
    && usermod -u $UID ollama \
    && groupmod -g $GID ollama

RUN mkdir -p /opt/ollama && chmod -R 775 /opt/ollama && chown -R ollama:ollama /opt/ollama

WORKDIR /opt/ollama

RUN chsh -s /bin/bash ollama





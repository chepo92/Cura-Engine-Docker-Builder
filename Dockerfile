FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Actualizar sistema e instalar dependencias base
RUN apt-get update && apt-get install -y \
    software-properties-common \
    build-essential \
    wget \
    git \
    python3 \
    python3-pip \
    python3-venv \
    ninja-build \
    cmake \
    gcc-13 \
    g++-13 \
    make \
    && rm -rf /var/lib/apt/lists/*

# Setear gcc 13 como default
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 100 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-13 100

# Crear entorno virtual
RUN python3 -m venv /opt/venv

# Activar venv por defecto
ENV PATH="/opt/venv/bin:$PATH"

# Instalar Conan dentro del venv
RUN pip install --upgrade pip \
 && pip install "conan>=2.7,<3.0"

# Crear usuario opcional (evita permisos root en build)
RUN useradd -ms /bin/bash builder
USER builder
WORKDIR /home/builder

# Inicializar Conan profile
RUN conan profile detect --force

# Carpeta de trabajo para montar código
WORKDIR /workspace

CMD ["/bin/bash"]
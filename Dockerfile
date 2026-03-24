FROM apache/superset:latest
USER root

RUN apt-get update && \
    apt-get install -y build-essential gcc g++ curl gnupg2 ca-certificates apt-transport-https unixodbc-dev

RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg

RUN echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" \
    > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18

RUN curl https://bootstrap.pypa.io/get-pip.py | /app/.venv/bin/python
RUN /app/.venv/bin/python -m pip install --no-cache-dir \
    pyodbc \
    pymssql \
    "sqlalchemy>=1.4,<2" \
    "greenlet>=3.0.3,<=3.1.1"

USER superset
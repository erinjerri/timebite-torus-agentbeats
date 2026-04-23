FROM python:3.11-slim

WORKDIR /app

COPY services/agents/purple/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

COPY services /app/services

EXPOSE 9009

ENTRYPOINT ["python", "-m", "services.agents.purple.a2a_server"]


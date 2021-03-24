# Building the main container
FROM python:3.6-slim

WORKDIR /alproject

RUN apt-get update && apt-get install -y build-essential

# Copy and install requirements.txt first for caching
COPY requirements.txt ./
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ENV PORT="8080"
ENV PROJECT_NAME="questionAnswering"
ENV HOST=0.0.0.0
ENV PROTOCOL=http://
# basic auth params
ENV USERNAME=""
ENV PASSWORD=""

EXPOSE ${PORT}

COPY . ./

RUN python setup.py develop

CMD ["./tools/run.sh"]

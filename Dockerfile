FROM pytorch/pytorch:2.2.2-cuda12.1-cudnn8-devel

WORKDIR /app

COPY ./ ./

ENTRYPOINT "run.sh"
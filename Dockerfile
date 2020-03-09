FROM python:3

LABEL "com.github.actions.name"="Azure Machine Learning Workspace"
LABEL "com.github.actions.description"="Connect to or create an Azure Machine Learning Workspace with this GitHub Action"
LABEL "com.github.actions.icon"="arrow-up-right"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="1.0.0"
LABEL repository="https://github.com/marvinbuss/AMLWorkspace"
LABEL homepage="https://github.com/marvinbuss/AMLWorkspace"
LABEL maintainer=""

ADD requirements.txt requirements.txt

RUN pip install -r requirements.txt

RUN mkdir code
ADD main.py code/main.py
ENTRYPOINT ["python", "code/main.py"]

FROM google/cloud-sdk:latest
RUN apt-get -y update 
COPY ./app /src
COPY ./requirements/dev.txt /src/requirements.txt
WORKDIR /src
RUN pip install -r requirements.txt
RUN chmod +x /src/api.py
RUN chmod +x /src/auth.sh
ENTRYPOINT ["bash","/src/auth.sh"]  

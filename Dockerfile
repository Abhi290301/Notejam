FROM ubuntu

 

LABEL author="Abhishek Chandel"

 

RUN apt-get update

RUN apt-get install -y python2 && apt-get install curl -y && apt-get install libpq-dev -y

 

COPY . .

 

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && python2 get-pip.py && pip2 install -r requirements.txt
RUN pip install psycopg2-binary
 

RUN python2 ./notejam/manage.py syncdb

RUN python2 ./notejam/manage.py migrate

 

CMD ["python2", "./notejam/manage.py", "runserver", "0.0.0.0:8000"]
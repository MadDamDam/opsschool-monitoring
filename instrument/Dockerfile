FROM python:3.7

RUN python3 -m pip install prometheus_client

COPY ./mock_python.py /src/mock_python

RUN chmod +x /src/mock_python

WORKDIR /src

ENTRYPOINT [ "/bin/sh", "-c" ]

CMD [ "./mock_python" ]

USER nobody

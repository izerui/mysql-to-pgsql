FROM dimitri/pgloader:ccl.latest

RUN cp /etc/apt/sources.list /etc/apt/sources.list_bak
RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get update && \
    apt-get install -y python3 python3-pip

RUN python3 --version

RUN pip config set global.index-url https://mirror.baidu.com/pypi/simple/
RUN pip install fastapi[all]

WORKDIR /data

COPY app.py /data

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
import os
from subprocess import Popen, PIPE, STDOUT

import uvicorn
from fastapi import FastAPI, Query
from pydantic import Required
from starlette.responses import PlainTextResponse

app = FastAPI(title='postgres数据迁移', description='mysql迁移到pgsql服务')


def exe_command(command):
    outputs = []
    """
    执行 shell 命令并实时打印输出
    :param command: shell 命令
    :return: process, exitcode
    """
    print(command)
    process = Popen(command, stdout=PIPE, stderr=STDOUT, shell=True)
    with process.stdout:
        for line in iter(process.stdout.readline, b''):
            try:
                output = line.decode().strip()
            except:
                output = str(line)
            print(output)
            if output:
                outputs.append(output)
    exitcode = process.wait()
    if exitcode != 0:
        print('错误: 命令执行失败, 继续下一条... ')
    return outputs  # process, exitcode


@app.post("/migration/database", description='开始迁移', response_class=PlainTextResponse)
async def migration(sourceDB: str = Query(default=Required, description='mysql源数据库')):
    my_host = os.environ['MYSQL_HOST']
    my_user = os.environ['MYSQL_USER']
    my_pass = os.environ['MYSQL_PASS']

    pg_host = os.environ['PGSQL_HOST']
    pg_user = os.environ['PGSQL_USER']
    pg_pass = os.environ['PGSQL_PASS']
    pg_database = os.environ['PGSQL_DATABASE']

    if not my_host and not my_user and not my_pass:
        return 'mysql源库定义缺失参数'
    if not pg_host and not pg_user and not pg_pass:
        return 'pgsql目标库定义缺失参数'

    # schema only 不迁移数据 参考: https://pgloader.readthedocs.io/en/latest/ref/mysql.html#mysql-database-migration-options-with
    outputs = exe_command(
        f'pgloader --with "batch rows = 15000" --with "create no indexes" mysql://{my_user}:{my_pass}@{my_host}/{sourceDB} pgsql://{pg_user}:{pg_pass}@{pg_host}/{pg_database}')
    return '\n'.join(outputs)


if __name__ == '__main__':
    # prod: uvicorn main:app --host 0.0.0.0 --port 80
    uvicorn.run(app, host="127.0.0.1", port=8000)

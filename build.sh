export https_proxy=http://192.168.1.39:7890 http_proxy=http://192.168.1.39:7890 all_proxy=socks5://192.168.1.39:7890
docker build -f Dockerfile -t mysql-to-pgsql:1.0 .
docker tag mysql-to-pgsql:1.0 harbor.yj2025.com/library/mysql-to-pgsql:1.0
docker push harbor.yj2025.com/library/mysql-to-pgsql:1.0
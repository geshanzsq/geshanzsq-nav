#!/bin/bash

# 进入各目录并启动服务
cd mysql && docker-compose up -d && cd ..
echo "MySQL8 启动成功"
cd redis && docker-compose up -d && cd ..
echo "Redis 启动成功"
cd nginx && docker-compose up -d && cd ..
echo "Nginx 启动成功"
cd project/frontend && docker-compose up -d --build && cd ../../
echo "格姗导航前端 启动成功"
cd project/backend && docker-compose up -d --build && cd ../../
echo "格姗导航后端 启动成功"
echo "所有服务启动成功"
# 查看后端启动日志
echo "格姗导航后端启动日志......"
docker logs -f gesdh-cn-backend

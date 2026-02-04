#!/bin/bash
docker-compose up -d --build
docker logs -f gesdh-cn-frontend

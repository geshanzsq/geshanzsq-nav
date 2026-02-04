# AdoptOpenJDK 停止发布 OpenJDK 二进制，而 Eclipse Temurin 是它的延伸，提供更好的稳定性
FROM eclipse-temurin:8-jre

# 创建一个目录用于存放应用
RUN mkdir /app

# 将构建的 JAR 文件复制到容器中
COPY geshanzsq-nav-admin-application.jar /app/app.jar

# 指定工作目录
WORKDIR /app

# 设置默认环境变量（可以被docker-compose覆盖）
ENV SPRING_PROFILES_ACTIVE=prod

# 暴露应用运行的端口（与你的application.properties中配置的端口一致）
EXPOSE 8083

# 启动应用
ENTRYPOINT ["java", "-jar", "app.jar"]
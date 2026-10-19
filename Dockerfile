# syntax=docker/dockerfile:1
# =============================================================================
#  Dockerfile - FILE KHUNG (multi-stage build cho Spring Boot 4 / Java 21 / Gradle)
#  Sinh viên hoàn chỉnh các ô ______ theo yêu cầu Phần 2 của đề thi.
# =============================================================================

# ---------- Stage 1: build - biên dịch & đóng gói bằng Gradle + JDK 21 ----------
# Spring Boot 4 yêu cầu Gradle >= 8.14
FROM gradle:8.5-jdk21-alpine  AS builder
WORKDIR /app

# Copy build.gradle + settings.gradle trước, tải dependency để tận dụng cache layer
COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

RUN chmod +x gradlew && ./gradlew dependencies --no-daemon

COPY src src
RUN ./gradlew bootJar -x test --no-daemon

FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

RUN addgroup -S nguyenlevu123group && adduser -S nguyenlevu123 -G nguyenlevu123group

COPY --from=builder --chown=nguyenlevu123:nguyenlevu123group /app/build/libs/*.jar app.jar

USER nguyenlevu123


EXPOSE 8083

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]

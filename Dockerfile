FROM --platform=linux/amd64 eclipse-temurin:8-jdk-focal

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    wget \
    bash \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN wget -q https://services.gradle.org/distributions/gradle-6.9-bin.zip && \
    unzip -q gradle-6.9-bin.zip -d /opt && \
    rm gradle-6.9-bin.zip
ENV PATH=$PATH:/opt/gradle-6.9/bin

ENV JPF_HOME=/app
ENV LD_LIBRARY_PATH=/app/jpf-symbc/lib

RUN mkdir -p /root/.jpf
RUN echo "jpf-core = /app/jpf-core" > /root/.jpf/site.properties && \
    echo "jpf-symbc = /app/jpf-symbc" >> /root/.jpf/site.properties && \
    echo "extensions=\${jpf-core},\${jpf-symbc}" >> /root/.jpf/site.properties

COPY . .

RUN echo 'alias spf-build="cd /app/jpf-core && ./gradlew build -x test && cd /app/jpf-symbc && ./gradlew build -x test"' >> /root/.bashrc
RUN echo 'alias spf-run="java -Xmx1024m -ea -Djava.library.path=/app/jpf-symbc/lib -jar /app/jpf-core/build/RunJPF.jar"' >> /root/.bashrc
RUN echo 'alias spf-sv="bash /app/jpf-symbc/bin/jpf-sv-comp.sh"' >> /root/.bashrc

# Convert Windows CRLF line endings to Unix LF to avoid execution issues
RUN chmod +x /app/jpf-symbc/bin/jpf-sv-comp.sh && \
    dos2unix /app/jpf-symbc/bin/jpf-sv-comp.sh

ENTRYPOINT ["/bin/bash"]

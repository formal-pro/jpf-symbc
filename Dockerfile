FROM eclipse-temurin:8-jdk-focal

RUN apt-get update && apt-get install -y \
    git unzip wget bash dos2unix \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN wget -q https://services.gradle.org/distributions/gradle-6.9-bin.zip && \
    unzip -q gradle-6.9-bin.zip -d /opt && \
    rm gradle-6.9-bin.zip

ENV PATH=/opt/gradle-6.9/bin:$PATH

# JPF runtime environment
ENV JPF_HOME=/workspace
ENV LD_LIBRARY_PATH=/workspace/jpf-symbc/lib

# JPF config
RUN mkdir -p /root/.jpf && \
    echo "jpf-core = /workspace/jpf-core" > /root/.jpf/site.properties && \
    echo "jpf-symbc = /workspace/jpf-symbc" >> /root/.jpf/site.properties && \
    echo "extensions=\${jpf-core},\${jpf-symbc}" >> /root/.jpf/site.properties

RUN echo 'alias spf-run="java -Xmx1024m -ea -Djava.library.path=/workspace/jpf-symbc/lib -jar /workspace/jpf-core/build/RunJPF.jar"' >> /root/.bashrc

ENTRYPOINT ["/bin/bash"]

FROM registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7

ENV OPENSHIFT_JENKINS_JVM_ARCH x86_64
ENV JAVA_MAX_HEAP_PARAM -Xmx512m
ENV CONTAINER_HEAP_PERCENT 0.5
ENV JNLP_MAX_HEAP_UPPER_BOUND_MB 512
ENV JAVA_INITIAL_HEAP_PARAM -Xms32m
ENV CONTAINER_INITIAL_PERCENT 0.1
ENV CONTAINER_CORE_LIMIT 2
ENV JAVA_TOOL_OPTIONS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Dsun.zip.disableMemoryMapping=true
ENV JAVA_GC_OPTS -XX:+UseParallelGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90

USER root

RUN yum install -y yum-utils device-mapper-persistent-data lvm2 && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y docker-ce && \
    usermod -aG docker $(whoami)

USER 1001
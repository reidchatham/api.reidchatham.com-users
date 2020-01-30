FROM swift:5.0

ARG ENVIRONMENT
ENV ENVIRONMENT ${ENVIRONMENT:-production}
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Europe/Berlin
ENV TERM xterm
RUN apt-get update && apt-get -y install wget lsb-release apt-transport-https libssl-dev zlib1g-dev
RUN wget -q https://repo.vapor.codes/apt/keyring.gpg -O- | apt-key add -
RUN echo "deb https://repo.vapor.codes/apt $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/vapor.list
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER root

RUN apt-get update && apt-get install
RUN mkdir /root/vapor
ADD . /root/vapor
WORKDIR /root/vapor
RUN cd /root/vapor && rm -rf .build
RUN swift package update
RUN swift build --configuration release
EXPOSE 443
RUN export JWT_SECRET='ohFcON5JWImUWAa-SCC2yYOsFwlHwj3ZBOqpDNFX6JbOqkGrSaGjQWkieAj1fJhuYpTQq7A__s0G6yujmnE6N-I9UHEqXmKxI87ek9z5uxhzIeIHBS6ToyoXHECMS_jN8MbsM4bjec7FLuO9bVNJALFmCgEwcSzZdP9zFHjlj32ATWuSwXbNHNAJnk2IUk2eYiMNiG1BzZM8OApsCF1ASa9zcXdm2QYtOat7hhP-Uo6y_zflx9Ahg-CUBqPTpfOUUuJoGjeWgbhy0-ISveueGjzj7x5UYKNCRZyCircJ_-v51wFvx1lbgRmqH4eJy0dh8Ra-zmzLsFCDs2Akz8Oy0Q'
RUN export POSTGRES_HOST='db'
RUN export POSTGRES_USER='test'
RUN export POSTGRES_PASSWORD='test'
RUN export POSTGRES_DB='test'
RUN export JWT_PUBLIC='IiLd9ex8LnXsFQ52jeK2HYPqf3-o6bT1PR_gM570kT0SkrH6TiwJowFuDTJ14qSIu6L0wPUCxbyRtH8gmqs2xAaXO5Zagj7vaMduAl8NCud_eKePKvxAhKGc9Ip0ApyJZCnCHqhOyZ1P0yyM_bYJLmgvQfQ2K-ByfT5BExLT54EFwUJ63tPQiU0gyycDULZAGTQBPzJNB5yWrVFW6s_VPZo73wd_4r86VErMeMgT0u4Nb5FihOcCjsdHt8X43oU4sf-YnHdzO7reHS8g11JLHrWL_sQlrC-gtJFq88UTzsevdsziDTByuB-Kf8cPATXPhTaisEb-TuURR_61wGLbQQ'
CMD .build/release/Run --hostname 0.0.0.0 --port 443

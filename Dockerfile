FROM php:7.2-cli

RUN apt-get update && apt-get install -y \
  bash \
  git

# Todo replace with a modern Composer package and to allow verifying the download.
RUN ln -s /usr/local/bin/php /usr/bin/php && \
  mkdir -p /compiler/ && \
  git clone https://github.com/gocom/MassPlugCompiler.git /compiler/bin && \
  chmod +x /compiler/bin/compile

ENV PATH "$PATH:/compiler/bin"

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

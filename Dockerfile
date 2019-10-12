FROM php:7.2-cli

# Todo replace with a modern Composer package and to allow verifying the download.
RUN mkdir -p /compiler/ && \
  git clone https://github.com/gocom/MassPlugCompiler.git /compiler/bin && \
  chmod +x /compiler/bin/compile

ENV PATH "$PATH:/compiler/bin"

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

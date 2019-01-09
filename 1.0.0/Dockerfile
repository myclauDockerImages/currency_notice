From ubuntu:16.04
RUN apt-get update && apt-get install -y jq bc
COPY entry.sh /entry.sh
RUN chmod a+x /entry.sh

CMD ["bash","/entry.sh"]

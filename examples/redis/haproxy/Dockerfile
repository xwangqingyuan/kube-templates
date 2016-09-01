FROM haproxy:1.5

COPY tmpl-haproxy.cfg /
COPY starthaproxy.sh /

CMD ["sh", "-c", "/starthaproxy.sh"]

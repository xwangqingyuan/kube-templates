echo "Proxying localhost ${INPUT_PORT} to ${TARGET_IP}:${TARGET_PORT}"
cat tmpl-haproxy.cfg | sed -e "s/INPUT_PORT/${INPUT_PORT}/" -e "s/TARGET_IP/${TARGET_IP}/" -e "s/TARGET_PORT/${TARGET_PORT}/" > /haproxy.cfg
haproxy -f /haproxy.cfg

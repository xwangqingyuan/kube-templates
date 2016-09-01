#cat /mnt/hgfs/Downloads/gitws/kube-templates/haproxy/template.cfg | sed 's/INPUT_PORT/80/' | sed 's/TARGET_IP/192.168.1.1/' | sed 's/TARGET_PORT/10080/'
#cat /mnt/hgfs/Downloads/gitws/kube-templates/haproxy/template.cfg | sed -e "s/INPUT_PORT/80/" -e "s/TARGET_IP/192.168.1.1/" -e "s/TARGET_PORT/10080/"
#cat /mnt/hgfs/Downloads/gitws/kube-templates/haproxy/template.cfg | sed -e "s/INPUT_PORT/$1/" -e "s/TARGET_IP/$2/" -e "s/TARGET_PORT/$3/"
cat tmpl-haproxy.cfg | sed -e "s/INPUT_PORT/${INPUT_PORT}/" -e "s/TARGET_IP/${TARGET_IP}/" -e "s/TARGET_PORT/${TARGET_PORT}/" | cat -

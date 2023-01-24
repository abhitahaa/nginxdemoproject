[web-server]
%{ for ip in nginx-hosts ~}
${ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=${keyfile}
%{ endfor ~}
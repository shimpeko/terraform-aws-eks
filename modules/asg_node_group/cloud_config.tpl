## template: jinja
#cloud-config
fqdn: ${node_name_prefix}-{{ v1.instance_id }}
runcmd:
- [aws, --region={{ v1.region }}, ec2, create-tags, --resources={{ v1.instance_id }}, "--tags=Key=Name,Value=${node_name_prefix}-{{ v1.instance_id }}"]
- [systemctl, restart, docker]
- [/etc/eks/bootstrap.sh, ${cluster_name}, --kubelet-extra-args, '--node-labels=${labels} --register-with-taints="${taints}"', --dns-cluster-ip, ${dns_cluster_ip}]

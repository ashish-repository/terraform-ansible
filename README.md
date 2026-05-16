```
*A step-by-step guide to using this repository efficiently*


Before running this first create an EC2 instance 
install terraform and ansible
create a directory terraform-project
cd terraform-project
git clone https://github.com/ashish-repository/terraform-ansible.git
configure aws CLI
asw configure
ssh-keygen -t rsa -b 4096 -f devops-key
chmod 400 /root/terraform-project/devops-key
terraform init
terraform validate
terraform plan
terraform apply 
you'll het ip copy ip and update in inventory.ini with REPLACE_WITH_TARGET_PUBLIC_IP (ansible_host) and nginx_setup.yml with REPLACE_WITH_TARGET_PUBLIC_IP (server_ip)

ansible -i inventory.ini webservers -m ping
ansible-playbook -i inventory.ini nginx_setup.yml

once done destroy the resource
```

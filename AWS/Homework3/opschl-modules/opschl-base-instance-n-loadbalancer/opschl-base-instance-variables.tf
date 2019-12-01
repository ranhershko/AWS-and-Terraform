variable "instances_count" {
  description = "instances count"
  type        = number
}

variable "instance_type" {
  description = "HA web & db OpsSchool instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_key_pair" {
  description = "instance key_pair"
  type        = string
}

variable "public_instance" {
  description = "if instance is public(true/false)"
  type = bool
}

variable "sg_ids" {
  description = "Security id"
  type = string
}

variable "pub_lb_sg_id" {
  description = "Pub lb Security id"
  type = string
}

variable "subnet_ids" {
  type = list
}

variable "opschl_tags" {
  type = map
  default = {prefix_name = "opschl"}
}

variable "web_user_data" {
  type = string
  default = <<EOF
  echo '<html><head></head><body><h1>This page served by '"$HOSTNAME"' server</h1></body></html>' > /var/www/html/index.html
  curl -L https://toolbelt.treasuredata.com/sh/install-debian-buster-td-agent3.sh | sh
  echo -e "<source>\n   @type tail\n   path /var/log/nginx/access.log\n   pos_file /var/log/td-agent/httpd-access.log.pos\n   tag nginx.access #fluentd tag!\n   format nginx\n </source>\n \n<match s3.*.*>\n   @type s3\n \n   s3_bucket opschl-web-db-ha-nginx-accesslog\n   path logs/\n \n   <buffer>\n     @type file\n     path /var/log/td-agent/s3\n     timekey 3600  # 1 hour\n     timekey_wait 10m\n     chunk_limit_size 256m\n   </buffer>\n \n   time_slice_format %Y%m%d%H\n</match>\n" > /etc/td-agent/td-agent.conf
  sudo systemctl start td-agent.service
EOF
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner = "Ran"
    Purpose = "Learning"
  }
}

variable "ami_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_instances_ip" {
  description = "List of public instances public IP's addresses"
  type        = list
}

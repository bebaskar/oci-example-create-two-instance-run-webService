variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "ssh_public_key" {}
variable "region" {}


# Variables to create compartments

variable "compartment_name" { default = "Baskar-instance" }
variable "compartment_description" { default = "Exercise for webApp" }

# Variables to create Tag Namespace

variable "tags" {
  type = "map"
  default = {
    "TagNamespace.Environment" = "poc"
    "TagNamespace.Owner"       = "Me"
  }
}
variable "tag_names" { default = ["Environment", "Owner"] }

variable "tag_namespace_description" { default = "Tag namespace for all resources" }
variable "tag_namespace_name" { default = "TagNamespace" }
variable "is_retired" { default = "false" }

variable "tag_description" { default = ["Environment purpose", "Owner for resource"] }

# IGW variables
variable "internet_gateway_enabled" { default = "true" }
variable "internet_gateway_display_name" { default = "MyIGW" }

variable "igw_route_table_rules_cidr_block" { default = "0.0.0.0/0" }

# VCN variables

variable "vcn_cidr_block" { default = "172.27.0.0/16" }
variable "vcn_display_name" { default = "MyVCN" }
variable "vcn_dns_label" { default = "BaskarDns" }

variable "route_table_display_name" {
  default = "MyRouteTable"
}

variable "ad_number" {
  default = "0"
}

variable "compartment_display_name" {
  default = "instances-poc"
}

variable "vcn_ingress_protocol" {
  default = "all"
}

# Applications security list variables

variable "private_security_list_name" {
  default = "MyPrivateSL"
}

variable "egress_destination" {
  default = "0.0.0.0/0"
}

variable "egress_protocol" {
  default = "all"
}

variable "ingress_source" {
  default = "0.0.0.0/0"
}

variable "ingress_protocol" {
  default = "6"
}

variable "ingress_stateless" {
  default = false
}

variable "user_data" {
  default = <<EOF
#!/bin/bash -x
echo '################### webserver userdata begins #####################'
touch userdata.`date +%s`.start
# echo '########## yum update all ###############'
sudo apt-get update -y
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update -y 
sudo apt-get install docker-ce docker-ce-cli containerd.io -y 
echo '########## basic webserver ##############'
docker run -d -p 80:80 tutum/hello-world
touch userdata.`date +%s`.finish
echo '################### webserver userdata ends #######################'
EOF
}

# Subnet variables
variable "cidr_block_subnet" {
  default = "172.27.0.0/24"
}

variable "display_name_subnet" {
  default = "poc-subnet"
}

variable "dns_label_subnet" {
  default = "poc"
}

variable "image_id_name" {
  default = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaa3utttlteyocj5s5y47g4uk2hjpmfjz2c4yehjfxi7cd6kpom3o2q"
}


variable "ingress_ports" {
  description = "all the ports for security list"
  default = [
    { minport     = 22
      maxport     = 22
      source_cidr = "0.0.0.0/0"
    },{ minport     = 80
      maxport     = 80
      source_cidr = "0.0.0.0/0"
    },
    { minport     = 0
      maxport     = 0
      source_cidr = "172.27.0.0/16"
  }]
}

// INSTANCE VARIABLES

variable "operating_system" {
  default = "Oracle Linux"
} // Name for the OS

variable "operating_system_version" {
  default = "7.6"
} // OS Version

variable "shape_name" {
  default = "VM.Standard2.1"
} // Shape what to be used. Smallest shape selected by default

variable "source_type" {
  default = "image"
} // What type the image source is

variable "assign_public_ip" {
  default = "true"
} // This is server in public subnet it will have a public IP

variable "instance_variables" {
  description = "Map instance name to hostname"
  default = {
    "Baskar1" = "Baskar1"
    "Baskar2" = "Baskar2"
  }
}
variable "instance_create_vnic_details_hostname_label" {
  default = "ForEach"
}

variable "is_monitoring_disabled" {
  default = false
}

# variable "ssh_public_key" {
#   default = "EDIT ME TO BE REAL SSH KEY"
# }

variable "instance_create_vnic_details_skip_source_dest_check" {
  default = false
}

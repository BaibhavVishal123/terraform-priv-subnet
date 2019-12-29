aws_access_key = "xxxxxxxxxxxxxxxx"
aws_secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxx"
region         = "ap-south-1"
vpc            = "bombay-vpc" #"vpc-67a4850f" 172.31.0.0/16
# last used 172.31.32.0/20   (172.31.47.255 lu, 172.31.48.0 na)
# existing public subnet tag name for NAT
subnet_id = "subnet-4e92dc26" #1b

# cidr and tag variable for private subnet-1
private_subnet_1a = "172.31.48.0/20"
priv_subnet1      = "priv_sub_1a" # tag name for private subnet-1

# cidr and tag variable for private subnet-2
private_subnet_1b = "172.31.64.0/20"
priv_subnet2      = "priv_sub_1b"

# cidr and tag variable for private subnet-3
private_subnet_1c = "172.31.80.0/20"
priv_subnet3      = "test_priv_sub_1c"

# remaining 172.31.96.0 (2^12= 4096)

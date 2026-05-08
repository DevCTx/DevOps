#!/usr/bin/env bash

# Exercises for Module "AWS Services"
# Your company has decided that they will use AWS as a cloud provider to deploy their applications. 
# It's too much overhead to manage multiple platforms, including the billing etc.
# 
# So you need to deploy the previous NodeJS application on an EC2 instance now. 
# This means you need to create and prepare an EC2 server with the AWS Command Line Tool to run your 
# NodeJS app container on it.
# 
# You know there are many steps to set this up, so you go through it with step by step exercises.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# EXERCISE 1: Create IAM user
# First of all, you need an IAM user with correct permissions to execute the tasks below.
# 
# Create a new IAM user using "your name" as a username and "devops" as the user-group
# Give the "devops" group all needed permissions to execute the tasks below 
# - with login and CLI credentials. 
# Note: Do that using the AWS UI with Admin User
 
1. we need to check that we are connected to the client AWS
$ aws configure
AWS Access Key ID [****************LIT6]: 
AWS Secret Access Key [****************mrw+]: 
Default region name [eu-west-3]: 
Default output format [json]: 

2. create a new IAM user
$ aws iam create-user --user-name my_name
{
    "User": {
        "Path": "/",
        "UserName": "my_name",
        "UserId": "AIDA4IIAVZARYUVQEJPNK",
        "Arn": "arn:aws:iam::<ACCOUNT_ID>:user/my_name",
        "CreateDate": "2026-05-08T08:14:07+00:00"
    }
}

3. Create the devops group
$ aws iam list-groups
shows that devops group does not exist

$ aws iam create-group --group-name devops
{
    "Group": {
        "Path": "/",
        "GroupName": "devops",
        "GroupId": "AGPA4IIAVZARSIW45YOKO",
        "Arn": "arn:aws:iam::<ACCOUNT_ID>:group/devops",
        "CreateDate": "2026-05-08T08:17:26+00:00"
    }
}

4. associate the devops group to the my_name user
$ aws iam add-user-to-group --user-name my_name --group-name devops

$ aws iam get-group --group-name devops
{
    "Users": [
        {
            "Path": "/",
            "UserName": "my_name",
            "UserId": "AIDA4IIAVZARYUVQEJPNK",
            "Arn": "arn:aws:iam::<ACCOUNT_ID>:user/my_name",
            "CreateDate": "2026-05-08T08:14:07+00:00"
        }
    ],
    "Group": {
        "Path": "/",
        "GroupName": "devops",
        "GroupId": "AGPA4IIAVZARSIW45YOKO",
        "Arn": "arn:aws:iam::<ACCOUNT_ID>:group/devops",
        "CreateDate": "2026-05-08T08:17:26+00:00"
    }
}
    


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# EXERCISE 2: Configure AWS CLI
# You want to use the AWS CLI for the following tasks. So, to be able to interact with the AWS account 
# from the AWS Command Line tool you need to configure it correctly:
# Set credentials for that user for AWS CLI
# Configure correct region for your AWS CLI

Got to IAM > IAM users > my_name > Create access key
* Use Case : Command Line Interface (CLI)
* Tag : aws-exercises
* Download .csv file with AKIA4IIAVZARYECAYSWV / 9zzOWzUiOTF08FrX2Go7R/Wy6WzGw8WbKKpOxNWl

or use :
$ aws iam create-access-key --user-name my_name > my_name_key.txt


Got to IAM > IAM users > my_name > Enable console access
* Custom password : MyP45$word
* Download .csv file 

or use :
$ aws iam create-login-profile --user-name my_name --password MyP45$word

Go to the link : http://<ACCOUNT_ID>.signin.aws.amazon.com/console
Enter credentials : my_name / MyP45$word
Update region to eu-west-3 (Europe - Paris)


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# EXERCISE 3: Create VPC
# You want to create the EC2 Instance in a dedicated VPC, instead of using the default one. So, using 
# the AWS CLI, you:
# 
# create a new VPC with 1 subnet
# create a security group in the VPC that will allow you access on ssh port 22 and will allow browser 
# access to your Node application

List the policy of VPC
$ aws iam list-policies | grep VPCFullAccess
            "PolicyName": "AmazonVPCFullAccess",
            "Arn": "arn:aws:iam::aws:policy/AmazonVPCFullAccess",

Add it to devops group
$ aws iam attach-group-policy --group-name devops --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess

Login as my_name
$ aws configure
AWS Access Key ID [****************]: <my_name_key>
AWS Secret Access Key [****************]: <my_name_secret_key>
Default region name [eu-west-3]: eu-west-3
Default output format [json]: json

Create a VPC (256 IP addresses)
$ aws ec2 create-vpc --cidr-block 10.0.0.0/24
{
    "Vpc": {
        "OwnerId": "<ACCOUNT_ID>",
        "InstanceTenancy": "default",
        "Ipv6CidrBlockAssociationSet": [],
        "CidrBlockAssociationSet": [
            {
                "AssociationId": "vpc-cidr-assoc-06b675567563a5ba6",
                "CidrBlock": "10.0.0.0/24",
                "CidrBlockState": {
                    "State": "associated"
                }
            }
        ],
        "IsDefault": false,
        "VpcId": "vpc-0a7d03e6f6e56c279",
        "State": "pending",
        "CidrBlock": "10.0.0.0/24",
        "DhcpOptionsId": "dopt-0c77f77d609ebf473"
    }
}

Create a subnet into this VPC (16 IP addresses)
$ aws ec2 create-subnet --cidr-block 10.0.0.0/28 --vpc-id vpc-0a7d03e6f6e56c279
{
    "Subnet": {
        "AvailabilityZoneId": "euw3-az3",
        "MapCustomerOwnedIpOnLaunch": false,
        "OwnerId": "<ACCOUNT_ID>",
        "AssignIpv6AddressOnCreation": false,
        "Ipv6CidrBlockAssociationSet": [],
        "SubnetArn": "arn:aws:ec2:eu-west-3:<ACCOUNT_ID>:subnet/subnet-0c581dd5f125e2d77",
        "EnableDns64": false,
        "Ipv6Native": false,
        "PrivateDnsNameOptionsOnLaunch": {
            "HostnameType": "ip-name",
            "EnableResourceNameDnsARecord": false,
            "EnableResourceNameDnsAAAARecord": false
        },
        "SubnetId": "subnet-0c581dd5f125e2d77",
        "State": "available",
        "VpcId": "vpc-0a7d03e6f6e56c279",
        "CidrBlock": "10.0.0.0/28",
        "AvailableIpAddressCount": 11,
        "AvailabilityZone": "eu-west-3c",
        "DefaultForAz": false,
        "MapPublicIpOnLaunch": false
    }
}

Create a Internet GateWay to be able to be accessed from internet
$ aws ec2 create-internet-gateway
{
    "InternetGateway": {
        "Attachments": [],
        "InternetGatewayId": "igw-02633dfe601243d44",
        "OwnerId": "<ACCOUNT_ID>",
        "Tags": []
    }
}

Then Attach it to the VPC
$ aws ec2 attach-internet-gateway --vpc-id vpc-0a7d03e6f6e56c279 --internet-gateway-id igw-02633dfe601243d44

Create a Route Table for this VPC
$ aws ec2 create-route-table --vpc-id vpc-0a7d03e6f6e56c279
{
    "RouteTable": {
        "Associations": [],
        "PropagatingVgws": [],
        "RouteTableId": "rtb-07b2a54b62c46df2e",
        "Routes": [
            {
                "DestinationCidrBlock": "10.0.0.0/24",
                "GatewayId": "local",
                "Origin": "CreateRouteTable",
                "State": "active"
            }
        ],
        "Tags": [],
        "VpcId": "vpc-0a7d03e6f6e56c279",
        "OwnerId": "<ACCOUNT_ID>"
    },
    "ClientToken": "f9a81b66-a5d4-4a95-b129-f45d28846aa0"
}

And define a route to handle out of local IPs to the IGW
$ aws ec2 create-route \
  --route-table-id rtb-07b2a54b62c46df2e \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id igw-02633dfe601243d44
{
    "Return": true
}

Associate it to the subnet of our VPC
$ aws ec2 associate-route-table  --subnet-id subnet-0c581dd5f125e2d77 --route-table-id rtb-07b2a54b62c46df2e
{
    "AssociationId": "rtbassoc-07485072bfecba60b",
    "AssociationState": {
        "State": "associated"
    }
}

Create a security group my_security_group
$ aws ec2 create-security-group --group-name my_security_group --description "AWS Exercises" --vpc-id vpc-0a7d03e6f6e56c279
{
    "GroupId": "sg-02ec557ec33cd2f7a",
    "SecurityGroupArn": "arn:aws:ec2:eu-west-3:<ACCOUNT_ID>:security-group/sg-02ec557ec33cd2f7a"
}

Authorize SSH connection on port 22 for my local IP
$ aws ec2 authorize-security-group-ingress --group-id sg-02ec557ec33cd2f7a --protocol tcp --port 22 --cidr <LOCAL_IP>/32
{
    "Return": true,
    "SecurityGroupRules": [
        {
            "SecurityGroupRuleId": "sgr-075f513f1e32f06fa",
            "GroupId": "sg-02ec557ec33cd2f7a",
            "GroupOwnerId": "<ACCOUNT_ID>",
            "IsEgress": false,
            "IpProtocol": "tcp",
            "FromPort": 22,
            "ToPort": 22,
            "CidrIpv4": "<LOCAL_IP>/32",
            "SecurityGroupRuleArn": "arn:aws:ec2:eu-west-3:<ACCOUNT_ID>:security-group-rule/sgr-075f513f1e32f06fa"
        }
    ]
}

And to the port 80 from anyone
$ aws ec2 authorize-security-group-ingress --group-id sg-02ec557ec33cd2f7a --protocol tcp --port 80 --cidr 0.0.0.0/0
{
    "Return": true,
    "SecurityGroupRules": [
        {
            "SecurityGroupRuleId": "sgr-0824baa53d4238ba4",
            "GroupId": "sg-02ec557ec33cd2f7a",
            "GroupOwnerId": "<ACCOUNT_ID>",
            "IsEgress": false,
            "IpProtocol": "tcp",
            "FromPort": 80,
            "ToPort": 80,
            "CidrIpv4": "0.0.0.0/0",
            "SecurityGroupRuleArn": "arn:aws:ec2:eu-west-3:<ACCOUNT_ID>:security-group-rule/sgr-0824baa53d4238ba4"
        }
    ]
}



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# EXERCISE 4: Create EC2 Instance
# Once the VPC is created, using the AWS CLI, you:
# 
# Create an EC2 instance in that VPC with the security group you just created and ssh key file

Create the SSH Key to access to the instance
$ aws ec2 create-key-pair --key-name my_web_server_key --query 'KeyMaterial' --output text > ~/.ssh/my_web_server_key.pem
$ chmod 400 ~/.ssh/my_web_server_key.pem

Be sure to authorize the creation of public IP address automatically
$ aws ec2 modify-subnet-attribute \
  --subnet-id subnet-0c581dd5f125e2d77 \
  --map-public-ip-on-launch

Create the instance with a tag name to facilitate the identification of it
$ aws ec2 run-instances \
  --image-id ami-05d43d5e94bb6eb95 \
  --count 1 \
  --instance-type t3.micro \
  --key-name my_web_server_key \
  --security-group-ids sg-02ec557ec33cd2f7a \
  --subnet-id subnet-0c581dd5f125e2d77 \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=my_web_server}]'
{
    "ReservationId": "r-02883a94133bf031d",
    "OwnerId": "<ACCOUNT_ID>",
    "Groups": [],
    "Instances": [
        {
            "Architecture": "x86_64",
            "BlockDeviceMappings": [],
            "ClientToken": "af471558-c427-4f2e-a9ee-f91191bb5ecc",
            "EbsOptimized": false,
            "EnaSupport": true,
            "Hypervisor": "xen",
            "NetworkInterfaces": [
                {
                    "Attachment": {
                        "AttachTime": "2026-05-08T14:10:24+00:00",
                        "AttachmentId": "eni-attach-062448f8de2cb9da2",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attaching",
                        "NetworkCardIndex": 0
                    },
                    "Description": "",
                    "Groups": [
                        {
                            "GroupId": "sg-02ec557ec33cd2f7a",
                            "GroupName": "my_security_group"
                        }
                    ],
                    "Ipv6Addresses": [],
                    "MacAddress": "0e:01:f2:86:2c:2b",
                    "NetworkInterfaceId": "eni-036cd69c25b49f95a",
                    "OwnerId": "<ACCOUNT_ID>",
                    "PrivateIpAddress": "10.0.0.10",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateIpAddress": "10.0.0.10"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-0c581dd5f125e2d77",
                    "VpcId": "vpc-0a7d03e6f6e56c279",
                    "InterfaceType": "interface",
                    "Operator": {
                        "Managed": false
                    }
                }
            ],
            "RootDeviceName": "/dev/xvda",
            "RootDeviceType": "ebs",
            "SecurityGroups": [
                {
                    "GroupId": "sg-02ec557ec33cd2f7a",
                    "GroupName": "my_security_group"
                }
            ],
            "SourceDestCheck": true,
            "StateReason": {
                "Code": "pending",
                "Message": "pending"
            },
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "my_web_server"
                }
            ],
            "VirtualizationType": "hvm",
            "CpuOptions": {
                "CoreCount": 1,
                "ThreadsPerCore": 2
            },
            "CapacityReservationSpecification": {
                "CapacityReservationPreference": "open"
            },
            "MetadataOptions": {
                "State": "pending",
                "HttpTokens": "required",
                "HttpPutResponseHopLimit": 2,
                "HttpEndpoint": "enabled",
                "HttpProtocolIpv6": "disabled",
                "InstanceMetadataTags": "disabled"
            },
            "EnclaveOptions": {
                "Enabled": false
            },
            "BootMode": "uefi-preferred",
            "PrivateDnsNameOptions": {
                "HostnameType": "ip-name",
                "EnableResourceNameDnsARecord": false,
                "EnableResourceNameDnsAAAARecord": false
            },
            "MaintenanceOptions": {
                "AutoRecovery": "default",
                "RebootMigration": "default"
            },
            "CurrentInstanceBootMode": "uefi",
            "Operator": {
                "Managed": false
            },
            "InstanceId": "i-00bba5692c2336920",
            "ImageId": "ami-05d43d5e94bb6eb95",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "PrivateDnsName": "ip-10-0-0-10.eu-west-3.compute.internal",
            "PublicDnsName": "",
            "StateTransitionReason": "",
            "KeyName": "my_web_server_key",
            "AmiLaunchIndex": 0,
            "ProductCodes": [],
            "InstanceType": "t3.micro",
            "LaunchTime": "2026-05-08T14:10:24+00:00",
            "Placement": {
                "AvailabilityZoneId": "euw3-az3",
                "GroupName": "",
                "Tenancy": "default",
                "AvailabilityZone": "eu-west-3c"
            },
            "Monitoring": {
                "State": "disabled"
            },
            "SubnetId": "subnet-0c581dd5f125e2d77",
            "VpcId": "vpc-0a7d03e6f6e56c279",
            "PrivateIpAddress": "10.0.0.10"
        }
    ]
}

$ aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=my_web_server" \
            "Name=instance-state-name,Values=running" \
  --query 'Reservations[*].Instances[*].[InstanceId,PublicIpAddress,PrivateIpAddress]' \
  --output table
------------------------------------------------------
|                  DescribeInstances                 |
+---------------------+----------------+-------------+
|  i-00bba5692c2336920|  <WEB_SERVER_PUBLIC_IP>  |  10.0.0.10  |
+---------------------+----------------+-------------+


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# EXERCISE 5: SSH into the server and install Docker on it
# Once the EC2 instance is created successfully, you want to prepare the server to run Docker containers. 
# So you:
# 
# ssh into the server and
# install Docker on it to run the dockerized application later
# 
# Set up Continuous Deployment

$ cat >> ~/.ssh/config <<EOF

Host web-server
  HostName <WEB_SERVER_PUBLIC_IP>
  User ec2-user
  IdentityFile ~/.ssh/my_web_server_key.pem
EOF

$ ssh web-server 
   ,     #_
   ~\_  ####_        Amazon Linux 2023
  ~~  \_#####\
  ~~     \###|
  ~~       \#/ ___   https://aws.amazon.com/linux/amazon-linux-2023
   ~~       V~' '->
    ~~~         /
      ~~._.   _/
         _/ _/
       _/m/
Last login: Fri May  8 15:04:19 2026 from <LOCAL_IP>

[ec2-user@ip-10-0-0-10 ~]$ sudo yum update
...
Dependencies resolved.
Nothing to do.
Complete!

[ec2-user@ip-10-0-0-10 ~]$ sudo dnf install docker
...
Complete!
[ec2-user@ip-10-0-0-10 ~]$ docker --version
Docker version 25.0.14, build 0bab007

[ec2-user@ip-10-0-0-10 ~]$ sudo systemctl enable --now docker
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /usr/lib/systemd/system/docker.service.

[ec2-user@ip-10-0-0-10 ~]$ sudo usermod -aG docker ec2-user

[ec2-user@ip-10-0-0-10 ~]$ sudo mkdir -p /usr/local/lib/docker/cli-plugins
[ec2-user@ip-10-0-0-10 ~]$ sudo curl -fsSL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
[ec2-user@ip-10-0-0-10 ~]$ sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
[ec2-user@ip-10-0-0-10 ~]$ sudo mkdir -p /opt/app
[ec2-user@ip-10-0-0-10 ~]$ sudo chown -R ec2-user:docker /opt/app
[ec2-user@ip-10-0-0-10 ~]$ docker compose version
Docker Compose version v5.1.3


# Now you don't want to deploy manually to the server all the time, because it's time-consuming and 
# also sometimes you miss it, when changes are made and the new docker image is built by the pipeline. 
# When you forget to check the pipeline, your team members need to write you and ask you to deploy the 
# new version.
# 
# As a solution, you want to automate this thing to save you and your team members time and energy.


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# EXERCISE 6: Add docker-compose for deployment
# First:
# add docker-compose to your NodeJS application
# This is because you want to have the whole configuration for starting the docker container in a file, 
# in case you need to make change or add a database later, instead of a plain docker command with parameters.
# 
# Use repository: https://gitlab.com/twn-devops-bootcamp/latest/09-aws/aws-exercises
# 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# EXERCISE 7: Add "deploy to EC2" step to your existing pipeline
# Add a deployment step to the Jenkinsfile from the previous exercise’s project to deploy to EC2.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# EXERCISE 8: Configure access from browser (EC2 Security Group)
# After executing the Jenkins pipeline successfully, the application is deployed, but you still can't access 
# it from the browser. You need to open the correct port on the server. For that, using the AWS CLI, you:
# 
# Configure the EC2 security group to access your application from a browser

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# EXERCISE 9: Configure automatic triggering of multi-branch pipeline
# Your team members are creating branches to add new features to the application or fix any issues, so you 
# don't want to build and deploy these half-done features or bug fixes. You want to build and deploy only 
# to the master branch. All # other branches should only run tests. Add this logic to the Jenkinsfile:
# 
# Add branch based logic to Jenkinsfile
# Add webhook to trigger pipeline automatically
# 

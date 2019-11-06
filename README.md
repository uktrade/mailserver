# Postfix and dovecot mailserver deployed in AWS
  
## NOTEs

* ECS is used purely for convenience.  We are currently only running a single instance, and that instance has an elastic IP address manually mapped to it.  The relevant MX/A records point to this EIP.

## Steps to build the stack

There are two separate, but related, terraform stacks.  The first stack builds the ECS cluster, and the second stack provisions the ECS service.  The stacks are separate and should be run separately as there are manual steps required to stand up an email server - namely mapping an EIP.

### Step 1 - build the cluster

### Step 2 - map EIP

### Step 3 - provision the service

## Administration 

### Changing the SMTP password

### Changing the POP3 password
 
## Failure and recovery scenarios

The cluster instance dies:
















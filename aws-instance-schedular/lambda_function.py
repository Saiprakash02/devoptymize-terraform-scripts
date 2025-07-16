import json
import re
import os
import boto3
def lambda_handler(event, context):
    instances_str = os.environ['instances']
    region = os.environ['Region']
    ec2 = boto3.client('ec2', region_name=region)
    instances= re.findall(r"i-[0-9a-z]{17}|i-[0-9a-z]{8}", instances_str)
    print('started your instances: ' + str(instances)+ "in Region "+ region)
    ec2.start_instances(InstanceIds=instances)

def lambda_handler2(event, context):
    instances_str = os.environ['instances']
    region = os.environ['Region']
    ec2 = boto3.client('ec2', region_name=region)
    instances= re.findall(r"i-[0-9a-z]{17}|i-[0-9a-z]{8}", instances_str)
    print('stopped your instances: ' + str(instances) + "in Region "+ region)
    ec2.stop_instances(InstanceIds=instances)

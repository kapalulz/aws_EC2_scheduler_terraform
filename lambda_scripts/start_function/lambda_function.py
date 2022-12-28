import boto3
import os

region = os.environ['region']
name_ID = os.environ['name_ID']
values_ID = os.environ['values_ID']
filter_ID = 'tag:'+ name_ID

ec2 = boto3.resource('ec2', region)

def lambda_handler(event, context):

    filters = [{
            'Name': filter_ID,
            'Values': [values_ID]
        },
        {
            'Name': 'instance-state-name', 
            'Values': ['stopped']
        }
    ]
    
    instances = ec2.instances.filter(Filters=filters)
    RunningInstances = [instance.id for instance in instances]

    if len(RunningInstances) > 0:
        shuttingDown = ec2.instances.filter(InstanceIds=RunningInstances).start()
        print (shuttingDown)
    else:
        print ("EC2 instance doesn't exist")
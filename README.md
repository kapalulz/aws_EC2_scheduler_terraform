# ec2_scheduler
Turn Off/On your EC2 instances at a specific time/day
(cron expression)


_
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

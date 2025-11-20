import json
from datetime import datetime

def lambda_handler(event, context):
    print('Event:', json.dumps(event))
    
    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Hello from Lambda!',
            'timestamp': datetime.now().isoformat()
        })
    }
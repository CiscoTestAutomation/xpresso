import json
import sys
jdata = open(sys.argv[1])

data = json.load(jdata)

fp = open('/s3/logs/mapping.json','w')

results = data['results']

output = {}
for  d in results:
    output[d['result_id']] = d['id']


json_formatted_str = json.dumps(output, indent=2)
print(json_formatted_str)
fp.write(json_formatted_str)
fp.close()

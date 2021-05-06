import os
import sys
import yaml
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("gr", help="GR conf file path", type=str)
parser.add_argument("bs", help="BS conf file path", type=str)
parser.add_argument("cs", help="CS conf file path", type=str)
parser.add_argument("outputfile", help="output file path", type=str)
args = parser.parse_args()

def parse(file_path, channel_type):
  channel_dict_list = []
  if os.path.exists(file_path):
    with open(file_path, encoding='utf-8') as fp:
      channel = ""
      service_id = 0
      for line in fp:
        if "[" in line:
          channel = line.split("[")[1].split("]")[0]
        if "SERVICE_ID" in line:
          service_id = int(line.split("=")[1].strip())
        if channel != "" and service_id != 0:
          channel_dict_list.append(
            {
              "name": channel,
              "type": channel_type,
              "serviceId": service_id,
              "channel": channel
            }
          )
          channel = ""
          service_id = 0

  return channel_dict_list

channel_dict_list = []
channel_dict_list.extend(parse(args.gr, "GR"))
channel_dict_list.extend(parse(args.bs, "BS"))
channel_dict_list.extend(parse(args.cs, "CS"))

with open(args.outputfile, mode="w", encoding='utf-8') as fp:
  yaml.dump(channel_dict_list, fp, encoding='utf8', allow_unicode=True, default_flow_style=False)

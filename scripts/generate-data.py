#!/usr/bin/python

import random
import uuid
import os
import re
import sys
import argparse

def load_random_line(file):
    lines = open(os.path.join(os.path.dirname(__file__),file)).read().splitlines()
    return random.choice(lines)


def generate_resources():
    os = load_random_line("./data/host.os.full.txt")
    id = uuid.uuid4().hex
    return "OTEL_RESOURCE_ATTRIBUTES_ENV=\"device.model="+ load_random_line("./data/device.model.txt") + ","\
            + "host.os.full=" + os + ","\
            + "os.description=" + os + ","\
            + "service.version=" + load_random_line("./data/service.version.txt") + ","\
            + 'device.id=' + id + ","\
            + 'host.id=' + id + "\""


if __name__ == '__main__':
    destination = "platform=iOS Simulator,name=iPhone 8"
    

    parser = argparse.ArgumentParser(description='run ios-integration-testing with generated OTEL_RESOURCE_ATTRIUTES_ENV')
    parser.add_argument('--destination', help='set a device/simulator target for ios-integation-testing', default="platform=iOS Simulator,name=iPhone 8")
    parser.add_argument('--disable-generate-resources', help='use to disable randomly generated resource values.', action='store_true')
    parser.add_argument('--collector-address', help='collector address to use, host name or ip acceptable.')
    parser.add_argument('--collector-port', help='collector port to use')
    parser.add_argument('--collector-tls', help='flag if tls is enabled for collector. true/false')
    parser.add_argument('--secret-token', help='secret auth token for using with token auth of apm-server')

    parser.add_argument('--opbeans-address', help='host name of obbeans service to use for requests. include port number')
    parser.add_argument('--opbeans-auth', help='base64 encoded user:password used for basic auth')

    args = parser.parse_args()
    
    print(args)

    envvars = ""
    if not args.disable_generate_resources:
        envvars += generate_resources()
    
    if args.collector_address:
        envvars += ' OTEL_COLLECTOR_ADDRESS="' + args.collector_address + '"'
    
    if args.collector_port:
        envvars += ' OTEL_COLLECTOR_PORT="' + args.collector_port + '"'

    if args.collector_tls:
        envvars += ' OTEL_COLLECTOR_TLS="' + args.collector_tls + '"'

    if args.secret_token:
        envvars += ' ELASTIC_SECRET_TOKEN="' + args.secret_token + '"'

    if args.opbeans_address:
        envvars += ' ELASTIC_OPBEANS_ADDRESS="' + args.opbeans_address + '"'
    
    if args.opbeans_auth:
        envvars += ' ELASTIC_OPBEANS_AUTH="' + args.opbeans_auth + '"'

    print("using environmental variables:\n" + envvars)
    xcodeProjectPath = os.path.join(os.path.dirname(__file__),"..")
    cmd = "pushd " + xcodeProjectPath + " && "  + envvars + " xcodebuild clean test  -scheme \"opbeans-swift (iOS)\" -destination \"" + args.destination + "\""
    print(cmd)
    os.system(cmd)

#!/usr/bin/env python3

import argparse
import json
import os
import zipfile

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='run ios-integration-testing with generated OTEL_RESOURCE_ATTRIUTES_ENV')
    parser.add_argument('--apm-server', help='collector address to use, host name or ip acceptable.')
    parser.add_argument('--secret-token', help='secret auth token for using with token auth of apm-server')
    parser.add_argument('--opbeans-node', help='host name of obbeans service to use for requests. include port number')
    parser.add_argument('--opbeans-auth', help='base64 encoded user:password used for basic auth')
    parser.add_argument('--saucelabs-auth', help='used to upload built artifact to saucelabs')

    args = parser.parse_args()

    apm_server = "http://localhost:8200"
    secret_token = None

    opbeans_node = "http://localhost:3000"
    opbeans_auth = None

    saucelabs_auth = ""

    if args.saucelabs_auth:
        saucelabs_auth = args.saucelabs_auth

    if args.apm_server:
        apm_server = args.apm_server

    if args.secret_token:
        secret_token = args.secret_token

    if args.opbeans_node:
        opbeans_node = args.opbeans_node

    if args.opbeans_auth:
        opbeans_auth = args.opbeans_auth

    path = os.path.dirname(os.path.realpath(__file__))

    agent_conf = path + "/../../Shared/Resources/agent-conf.json"
    api_data = path + "/../../Shared/Resources/apiData.json"

    agent_conf_json = {
        "url" : apm_server,
        "token": secret_token
    }

    json_object = json.dumps(agent_conf_json, indent=4)
    with open(agent_conf, "w") as outfile:
        outfile.write(json_object)

    api_data_json = {
        "url": opbeans_node,
        "auth" : opbeans_auth
    }

    json_object = json.dumps(api_data_json, indent=4)
    with open(api_data, "w") as outfile:
        outfile.write(json_object)

    cmd = "pushd \"" + path + "/../..\"" + " && " + "xcodebuild clean build -scheme \"opbeans-swift (iOS)\" -destination \"platform=iOS Simulator,name=iPhone 8\" -derivedDataPath ./DerivedData/ "
    os.system(cmd)
    with zipfile.zipfile("opbeans_swift.app.zip", mode="w") as archive:
        archive.write("./opbeans-swift/DerivedData/Build/Products/Debug-iphonesimulator/opbeans-swift.app/")

    upload_cmd =" curl -u " + saucelabs_auth + " --location --request POST https://api.us-west-1.saucelabs.com/v1/storage/upload --form payload=@\"opbeans_swift.app.zip\" --form 'name=\"opbeans_swift.app.zip\"'"




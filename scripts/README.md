# Opbeans-Swift Data generation
The `generat-data.py` script provides an easy way to run the opbeans-swift-loadgenerator target from the command line.
It provides options for setting endpoints & auto-generate resources data (device model, os version, device id, etc).

At the moment, the opbeans-swift-loadgenerator only runs a single user flow of selecting a product and checking out. 
Additional user flows will be added at a later time. 


## Usage
```asciidoc
usage: generate-data.py [-h] [--destination DESTINATION] [--disable-generate-resources] [--collector-address COLLECTOR_ADDRESS] [--collector-port COLLECTOR_PORT]
[--collector-tls COLLECTOR_TLS] [--secret-token SECRET_TOKEN] [--opbeans-address OPBEANS_ADDRESS] [--opbeans-auth OPBEANS_AUTH]

run ios-integration-testing with generated OTEL_RESOURCE_ATTRIUTES_ENV

optional arguments:
-h, --help            show this help message and exit
--destination DESTINATION
set a device/simulator target for ios-integation-testing
--disable-generate-resources
use to disable randomly generated resource values.
--collector-address COLLECTOR_ADDRESS
collector address to use, host name or ip acceptable.
--collector-port COLLECTOR_PORT
collector port to use
--collector-tls COLLECTOR_TLS
flag if tls is enabled for collector. true/false
--secret-token SECRET_TOKEN
secret auth token for using with token auth of apm-server
--opbeans-address OPBEANS_ADDRESS
host name of obbeans service to use for requests. include port number
--opbeans-auth OPBEANS_AUTH
base64 encoded user:password used for basic auth
```
### Default usage
```asciidoc
 python ./scripts/generate-data.py
```
This will run with default settings for connecting to a locally run apm-integration-testing suite. 
- apm host : `localhost:8200`
- node js  : `localhost:3000`
- target : iOS Simulator iPhone8

### Cloud example

```asciidoc
python ./scripts/generate-data.py --collector-address "my-apm-server.elastic.cloud.co" \
    --collector-port 443 \
    --collector-tls true \
    --secret-token "my-secret-token"
```

this will target a cloud apm server. opbeans-node backend will still be assumed running locally using `localhost:3000`

### Targeting real device

By default, this script targets a simulator version of an iPhone 8. A real device can be targeted using the `--destination` argument.
After connecting a real iOS device you can find details about it by running `xcodebuild -showdestinations -scheme "opbeans-swift (iOS)`
Find your device in that list and add it to the `--destination` flag in the following format : 
`--desination "platform=<device platform>,name=<my device name>"`.

Additionally, the flag `--disable-generate-resources` should be used, or else the real device attributes will be overwitten by the random attribute values. 

Note: you need to make sure the opbeans-node & apm-server endpoints are accessible from your iOS device network connection. 
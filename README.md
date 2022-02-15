# ios-integration-testing

An opbeans based integration test for the iOS Agent. 
This project is intended to be used in conjunction with [apm-integration-testing](https://github.com/elastic/apm-integration-testing)

Agent configuration can be found in `./Shared/Model/ios_integration_testingApp.swift` including options to set collector address & secret token. 

use `Shared/Resources/apiData.json` to configure the target opbean endpoint in the apm-integration-testing suite.



### Data generation

use `./script/generate-data.py` to prep and run `ios-integration-testing` with a random selection of attributes from the files in `./scripts/data` applied to the Resources object.

`generate-data.py` accepts a several parameters to set app installation destination, and collector / opbean configurations. A list of possible desinations can be provided by `xcodebuild -showdestinations`. The default value is `"platform=iOS Simulator,name=iPad (8th generation)"` more details can be found calling `python3 ./script/generate-data.py -h`.

Agent configuration must be done through `ios-integration-testing` for this script.


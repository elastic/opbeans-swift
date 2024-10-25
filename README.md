# opbeans-swift

An opbeans based app for the iOS Agent. 
This project is intended to be used in conjunction with [apm-integration-testing](https://github.com/elastic/apm-integration-testing) and the other opbeans applications.

Agent configuration can be found in `./Shared/Model/ios_integration_testingApp.swift` including options to set collector address & secret token. 

use `Shared/Resources/apiData.json` to configure the target opbeans endpoint. Default to the opbeans-node on port `3000`.


### Data generation
Data generate TBD

[//]: # (use `./script/generate-data.py` to prep and run `ios-integration-testing` with a random selection of attributes from the files in `./scripts/data` applied to the Resources object.)

[//]: # ()
[//]: # (`generate-data.py` accepts several parameters to set app installation destination, and collector / opbeans configurations. A list of possible destinations can be provided by `xcodebuild -showdestinations`.  The default value is `"platform=iOS Simulator,name=iPad &#40;8th generation&#41;"` more details can be found calling `python3 ./script/generate-data.py -h`.)

[//]: # ()
[//]: # (Agent configuration must be done through `ios-integration-testing` for this script.)


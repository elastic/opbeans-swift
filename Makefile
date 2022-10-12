SHELL := /bin/bash

# The APM Server URL to connect to
APM_URL ?=
# The APM token
APM_TOKEN ?=
# The Opbeans Node URL
OPBEANS_NODE_URL ?=
# The Opbeans Auth
OPBEANS_AUTH ?=
# The Saucelabs username
SAUCE_USERNAME ?=
# The Saucelabs access key
SAUCE_ACCESS_KEY ?=

oblt:
	python3 .ci/scripts/generate-oblt-conf.py \
		--apm-server $(APM_URL) \
		--secret-token $(APM_TOKEN) \
		--opbeans-node $(OPBEANS_NODE_URL) \
		--opbeans-auth $(OPBEANS_AUTH)
	xcodebuild build-for-testing \
		-project opbeans-swift.xcodeproj \
		-scheme "opbeans-swift (iOS)" \
		-derivedDataPath "./DerivedData"
	zip -r \
		opbeans-swift.app.zip  \
		./DerivedData/Build/Products/Debug-iphonesimulator/opbeans-swift.app
	curl -u $(SAUCE_USERNAME):$(SAUCE_ACCESS_KEY) \
		--location \
		--request POST https://api.us-west-1.saucelabs.com/v1/storage/upload \
		--form payload=@"./opbeans-swift.app.zip" \
		--form 'name="opbeans-swift.app.zip"'

.PHONY: oblt

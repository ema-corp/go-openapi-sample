BASE_DIR=`pwd`/../..
BUILD_DIR=src

.PHONY: gen
gen:
	openapi-generator generate \
	-i openapi.yml \
	-g "go-server" \
	-o $(BASE_DIR)/$(BUILD_DIR)
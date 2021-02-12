.PHONY: gen
gen:
	openapi-generator generate \
	-i build/openapi/openapi.yml \
	-g "go-server" \
	-o src
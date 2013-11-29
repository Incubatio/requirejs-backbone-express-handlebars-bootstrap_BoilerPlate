build: clean
	@if [ ! -f "public/build" ]; then ln -s ../build public/build; fi
	@if [ ! -f "public/assets" ]; then ln -s ../assets public/assets; fi
	coffee --compile --output build src

watch:
	coffee --compile --watch --lint --output build src

install:
	r.js -o baseUrl=./build/client paths.requireLib=./node_modules/requirejs-browser/require.js include=requireLib name=main out=assets/js/boilerPlate.min.js mainConfigFile=build/client.js insertRequire=main
	r.js -o optimize=none baseUrl=./build/client paths.requireLib=./node_modules/requirejs-browser/require.js include=requireLib name=main out=assets/js/boilerPlate.js mainConfigFile=build/client.js insertRequire=main

clean: 
	rm -rf build

server: 
	node build/server.js

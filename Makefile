build: clean
	@if [ ! -f "public/build" ]; then ln -s ../build public/build; fi
	@if [ ! -f "public/assets" ]; then ln -s ../assets public/assets; fi
	coffee --compile --output build src

watch:
	coffee --compile --watch --lint --output build src

install:
	r.js -o baseUrl=build/lib/ name=main out=assets/js/boiler-plate.min.js

clean: 
	rm -rf build

server: 
	node build/server.js

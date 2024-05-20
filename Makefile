configure:
	mkdir -p build

assemble: configure
	as main.s -o ./build/main.o

link: assemble
	ld -o ./build/main.x ./build/main.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path`

run: link
	./build/main.x

clean:
	rm -r ./build
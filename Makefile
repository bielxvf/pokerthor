pokerthor:
	mkdir -p bin
	odin build src -out:bin/pokerthor -show-system-calls -show-timings -strict-style -vet -vet-semicolon -warnings-as-errors

clean:
	rm bin/*

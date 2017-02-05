CPPFLAGS = -I include -Wall -pthread

src = $(wildcard src/*.c)
obj = $(patsubst src/%.c, build/%.o, $(src))
headers = $(wildcard include/*.h)

lvl-ip: $(obj)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(obj) -o lvl-ip

build/%.o: src/%.c ${headers}
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

debug: CFLAGS+= -g -fsanitize=address
debug: lvl-ip

all: lvl-ip
	$(MAKE) -C tools
	$(MAKE) -C apps/curl

clean:
	rm build/*.o lvl-ip

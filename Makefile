BUILD_DIR=build

${BUILD_DIR}/%.o: %.s
	@mkdir -p $(@D)
	nasm -f elf64 -F dwarf -g -o $@ $<

${BUILD_DIR}/%.out: ${BUILD_DIR}/%.o %.s
	@mkdir -p $(@D)
	ld -o $@ $<

clean:
	rm -rf ${BUILD_DIR}/*

title: $(OBJS)

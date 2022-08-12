BUILD_DIR=build

${BUILD_DIR}/%.o: %.s
	@mkdir -p $(@D)
	nasm -f elf64 -o $@ $<

${BUILD_DIR}/%.out: ${BUILD_DIR}/%.o
	@mkdir -p $(@D)
	ld -o $@ $<

clean:
	rm -rf ${BUILD_DIR}/*.o

title: $(OBJS)

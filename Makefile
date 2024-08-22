OBJ_TYPE_FLAG = -g
CC = gcc
TARGET	= pjc
DIRS = parser util codegen 
LIBS = parser/libparser-g.a util/libutil-g.a codegen/libcodegen-g.a
ANTLRLIB = 
DOXYGEN_SRC = PJCompilerDocumentation.Doxyfile

RM = /bin/rm -f

CFLAGS	= $(OBJ_TYPE_FLAG) 

.SILENT:

$(TARGET): $(LIBS)
	echo "Creating $@"
	$(CC) $(CFLAGS) -o $@ $(LIBS) $(ANTLRLIB)

.PHONY: $(LIBS) clean docs

$(LIBS): 
	echo "Making directory $(dir $@)"
	$(MAKE) -C $(dir $@)

clean:
	for dir in $(DIRS); do \
		echo "Cleaning directory $$dir"; \
		$(MAKE) -C $$dir clean; \
	done
	$(RM) $(TARGET)

docs:
	doxygen $(DOXYGEN_SRC)

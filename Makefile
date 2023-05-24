CXX      ?= g++
CXXFLAGS ?= -std=c++20
CPPFLAGS ?= -O3 -Wall -I. -Wno-conversion-null -Wno-deprecated-declarations

LDFLAGS ?= 
LDLIBS  ?= 

# Flags for the muParser example.
CPPFLAG_MUPARSER ?= -I./ -I../zeroFun/include
EXEC_MUPARSER     = main_getpot_muparser
LDFLAGS_MUPARSER ?= -L../zeroFun/lib -Wl,-rpath=../zeroFun/lib
LIB_MUPARSER     ?= -lmuparser

HEADERS = solverParam.hpp solverTraits.hpp solverBase.hpp secant.hpp secant.hpp solverFactory.hpp


all: $(EXEC_MUPARSER)

%.o: %.cpp 
	$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $<

$(EXEC_MUPARSER).o: %.o: %.cpp  muparser_fun.hpp
	$(CXX) -c $(CPPFLAGS) $(CPPFLAG_MUPARSER) $(CXXFLAGS) $<


$(EXEC_MUPARSER): %: %.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(LDFLAGS_MUPARSER) $< $(LIBS) $(LIB_MUPARSER) -o $@

clean:
	$(RM) *.o

distclean: clean
	$(RM) $(EXEC) $(EXEC_MUPARSER)
	$(RM) *~
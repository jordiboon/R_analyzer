import sys
from antlr4 import *
from RLexer import RLexer
from RParser import RParser
from RFilter import RFilter

from Visitors import *

def main():
    # first arg is the file name
    input_stream = FileStream(sys.argv[1], encoding='utf-8')
    lexer = RLexer(input_stream)
    tokens = CommonTokenStream(lexer)
    
    tokens.fill()

    filter = RFilter(tokens)
    filter.stream()
    tokens.reset()

    parser = RParser(tokens)
    tree = parser.prog()
    print(tree.toStringTree(recog=parser))

    # visitor = ExtractNames()
    # output = visitor.visit(tree)
    # print(output)

    visitor = ExtractImports()
    output = visitor.visit(tree)
    print(output)

    visitor = ExtractConfigs()
    output = visitor.visit(tree)
    print(output)

    visitor = ExtractParams()
    output = visitor.visit(tree)
    print(output)

    visitor = ExtractDefs()
    defs = visitor.visit(tree)
    print(defs)

    visitor = ExtractInputs(defs)
    inputs = visitor.visit(tree)
    print(inputs)


if __name__ == '__main__':
    main()
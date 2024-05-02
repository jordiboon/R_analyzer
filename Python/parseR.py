import sys
from antlr4 import *
from RLexer import RLexer
from RParser import RParser
from RFilter import RFilter

from ExtractNames import ExtractNames
from ExtractImports import ExtractImports
from ExtractConfigs import ExtractConfigs
from ExtractParams import ExtractParams

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

    visitor = ExtractNames()
    output = visitor.visit(tree)
    print(output)

    visitor = ExtractImports()
    output = visitor.visit(tree)
    print(output)

    visitor = ExtractConfigs()
    output = visitor.visit(tree)
    print(output)

    visitor = ExtractParams()
    output = visitor.visit(tree)
    print(output)
    # print(tree.toStringTree(recog=parser))

    # progListener = MyListener(tokens)
    # walker = ParseTreeWalker()
    # walker.walk(progListener, tree)

if __name__ == '__main__':
    main()
import sys
from antlr4 import *
from RLexer import RLexer
from RParser import RParser
from RFilter import RFilter

from MyVisitor import MyVisitor
from MyListener import MyListener
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

    visitor = MyVisitor()
    output = visitor.visit(tree)
    print(output)
    print(tree.toStringTree(recog=parser))

    # progListener = MyListener(tokens)
    # walker = ParseTreeWalker()
    # walker.walk(progListener, tree)

if __name__ == '__main__':
    main()
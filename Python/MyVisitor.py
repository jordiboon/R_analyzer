
from RVisitor import RVisitor
from RParser import RParser

class MyVisitor(RVisitor):

    def visitProg(self, ctx:RParser.ProgContext):
        print("visitProg")
        return self.visitChildren(ctx)
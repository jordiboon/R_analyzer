// Generated from R.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link RParser}.
 */
public interface RListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link RParser#prog}.
	 * @param ctx the parse tree
	 */
	void enterProg(RParser.ProgContext ctx);
	/**
	 * Exit a parse tree produced by {@link RParser#prog}.
	 * @param ctx the parse tree
	 */
	void exitProg(RParser.ProgContext ctx);
	/**
	 * Enter a parse tree produced by the {@code next}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterNext(RParser.NextContext ctx);
	/**
	 * Exit a parse tree produced by the {@code next}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitNext(RParser.NextContext ctx);
	/**
	 * Enter a parse tree produced by the {@code parens}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterParens(RParser.ParensContext ctx);
	/**
	 * Exit a parse tree produced by the {@code parens}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitParens(RParser.ParensContext ctx);
	/**
	 * Enter a parse tree produced by the {@code userop}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterUserop(RParser.UseropContext ctx);
	/**
	 * Exit a parse tree produced by the {@code userop}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitUserop(RParser.UseropContext ctx);
	/**
	 * Enter a parse tree produced by the {@code for}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterFor(RParser.ForContext ctx);
	/**
	 * Exit a parse tree produced by the {@code for}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitFor(RParser.ForContext ctx);
	/**
	 * Enter a parse tree produced by the {@code addsub}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterAddsub(RParser.AddsubContext ctx);
	/**
	 * Exit a parse tree produced by the {@code addsub}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitAddsub(RParser.AddsubContext ctx);
	/**
	 * Enter a parse tree produced by the {@code unary}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterUnary(RParser.UnaryContext ctx);
	/**
	 * Exit a parse tree produced by the {@code unary}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitUnary(RParser.UnaryContext ctx);
	/**
	 * Enter a parse tree produced by the {@code while}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterWhile(RParser.WhileContext ctx);
	/**
	 * Exit a parse tree produced by the {@code while}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitWhile(RParser.WhileContext ctx);
	/**
	 * Enter a parse tree produced by the {@code float}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterFloat(RParser.FloatContext ctx);
	/**
	 * Exit a parse tree produced by the {@code float}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitFloat(RParser.FloatContext ctx);
	/**
	 * Enter a parse tree produced by the {@code not}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterNot(RParser.NotContext ctx);
	/**
	 * Exit a parse tree produced by the {@code not}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitNot(RParser.NotContext ctx);
	/**
	 * Enter a parse tree produced by the {@code and}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterAnd(RParser.AndContext ctx);
	/**
	 * Exit a parse tree produced by the {@code and}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitAnd(RParser.AndContext ctx);
	/**
	 * Enter a parse tree produced by the {@code repeat}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterRepeat(RParser.RepeatContext ctx);
	/**
	 * Exit a parse tree produced by the {@code repeat}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitRepeat(RParser.RepeatContext ctx);
	/**
	 * Enter a parse tree produced by the {@code complex}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterComplex(RParser.ComplexContext ctx);
	/**
	 * Exit a parse tree produced by the {@code complex}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitComplex(RParser.ComplexContext ctx);
	/**
	 * Enter a parse tree produced by the {@code hex}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterHex(RParser.HexContext ctx);
	/**
	 * Exit a parse tree produced by the {@code hex}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitHex(RParser.HexContext ctx);
	/**
	 * Enter a parse tree produced by the {@code nan}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterNan(RParser.NanContext ctx);
	/**
	 * Exit a parse tree produced by the {@code nan}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitNan(RParser.NanContext ctx);
	/**
	 * Enter a parse tree produced by the {@code id}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterId(RParser.IdContext ctx);
	/**
	 * Exit a parse tree produced by the {@code id}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitId(RParser.IdContext ctx);
	/**
	 * Enter a parse tree produced by the {@code doubleIndex}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterDoubleIndex(RParser.DoubleIndexContext ctx);
	/**
	 * Exit a parse tree produced by the {@code doubleIndex}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitDoubleIndex(RParser.DoubleIndexContext ctx);
	/**
	 * Enter a parse tree produced by the {@code exp}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExp(RParser.ExpContext ctx);
	/**
	 * Exit a parse tree produced by the {@code exp}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExp(RParser.ExpContext ctx);
	/**
	 * Enter a parse tree produced by the {@code if}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterIf(RParser.IfContext ctx);
	/**
	 * Exit a parse tree produced by the {@code if}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitIf(RParser.IfContext ctx);
	/**
	 * Enter a parse tree produced by the {@code sep}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterSep(RParser.SepContext ctx);
	/**
	 * Exit a parse tree produced by the {@code sep}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitSep(RParser.SepContext ctx);
	/**
	 * Enter a parse tree produced by the {@code inf}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterInf(RParser.InfContext ctx);
	/**
	 * Exit a parse tree produced by the {@code inf}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitInf(RParser.InfContext ctx);
	/**
	 * Enter a parse tree produced by the {@code comp}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterComp(RParser.CompContext ctx);
	/**
	 * Exit a parse tree produced by the {@code comp}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitComp(RParser.CompContext ctx);
	/**
	 * Enter a parse tree produced by the {@code or}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterOr(RParser.OrContext ctx);
	/**
	 * Exit a parse tree produced by the {@code or}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitOr(RParser.OrContext ctx);
	/**
	 * Enter a parse tree produced by the {@code break}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterBreak(RParser.BreakContext ctx);
	/**
	 * Exit a parse tree produced by the {@code break}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitBreak(RParser.BreakContext ctx);
	/**
	 * Enter a parse tree produced by the {@code false}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterFalse(RParser.FalseContext ctx);
	/**
	 * Exit a parse tree produced by the {@code false}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitFalse(RParser.FalseContext ctx);
	/**
	 * Enter a parse tree produced by the {@code index}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterIndex(RParser.IndexContext ctx);
	/**
	 * Exit a parse tree produced by the {@code index}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitIndex(RParser.IndexContext ctx);
	/**
	 * Enter a parse tree produced by the {@code compound}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterCompound(RParser.CompoundContext ctx);
	/**
	 * Exit a parse tree produced by the {@code compound}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitCompound(RParser.CompoundContext ctx);
	/**
	 * Enter a parse tree produced by the {@code int}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterInt(RParser.IntContext ctx);
	/**
	 * Exit a parse tree produced by the {@code int}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitInt(RParser.IntContext ctx);
	/**
	 * Enter a parse tree produced by the {@code muldiv}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterMuldiv(RParser.MuldivContext ctx);
	/**
	 * Exit a parse tree produced by the {@code muldiv}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitMuldiv(RParser.MuldivContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ifelse}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterIfelse(RParser.IfelseContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ifelse}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitIfelse(RParser.IfelseContext ctx);
	/**
	 * Enter a parse tree produced by the {@code str}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterStr(RParser.StrContext ctx);
	/**
	 * Exit a parse tree produced by the {@code str}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitStr(RParser.StrContext ctx);
	/**
	 * Enter a parse tree produced by the {@code call}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterCall(RParser.CallContext ctx);
	/**
	 * Exit a parse tree produced by the {@code call}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitCall(RParser.CallContext ctx);
	/**
	 * Enter a parse tree produced by the {@code help}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterHelp(RParser.HelpContext ctx);
	/**
	 * Exit a parse tree produced by the {@code help}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitHelp(RParser.HelpContext ctx);
	/**
	 * Enter a parse tree produced by the {@code na}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterNa(RParser.NaContext ctx);
	/**
	 * Exit a parse tree produced by the {@code na}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitNa(RParser.NaContext ctx);
	/**
	 * Enter a parse tree produced by the {@code extract}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExtract(RParser.ExtractContext ctx);
	/**
	 * Exit a parse tree produced by the {@code extract}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExtract(RParser.ExtractContext ctx);
	/**
	 * Enter a parse tree produced by the {@code func}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterFunc(RParser.FuncContext ctx);
	/**
	 * Exit a parse tree produced by the {@code func}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitFunc(RParser.FuncContext ctx);
	/**
	 * Enter a parse tree produced by the {@code null}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterNull(RParser.NullContext ctx);
	/**
	 * Exit a parse tree produced by the {@code null}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitNull(RParser.NullContext ctx);
	/**
	 * Enter a parse tree produced by the {@code true}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterTrue(RParser.TrueContext ctx);
	/**
	 * Exit a parse tree produced by the {@code true}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitTrue(RParser.TrueContext ctx);
	/**
	 * Enter a parse tree produced by the {@code namespace}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterNamespace(RParser.NamespaceContext ctx);
	/**
	 * Exit a parse tree produced by the {@code namespace}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitNamespace(RParser.NamespaceContext ctx);
	/**
	 * Enter a parse tree produced by the {@code colon}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterColon(RParser.ColonContext ctx);
	/**
	 * Exit a parse tree produced by the {@code colon}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitColon(RParser.ColonContext ctx);
	/**
	 * Enter a parse tree produced by the {@code formula}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterFormula(RParser.FormulaContext ctx);
	/**
	 * Exit a parse tree produced by the {@code formula}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitFormula(RParser.FormulaContext ctx);
	/**
	 * Enter a parse tree produced by the {@code assign}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterAssign(RParser.AssignContext ctx);
	/**
	 * Exit a parse tree produced by the {@code assign}
	 * labeled alternative in {@link RParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitAssign(RParser.AssignContext ctx);
	/**
	 * Enter a parse tree produced by {@link RParser#exprlist}.
	 * @param ctx the parse tree
	 */
	void enterExprlist(RParser.ExprlistContext ctx);
	/**
	 * Exit a parse tree produced by {@link RParser#exprlist}.
	 * @param ctx the parse tree
	 */
	void exitExprlist(RParser.ExprlistContext ctx);
	/**
	 * Enter a parse tree produced by {@link RParser#formlist}.
	 * @param ctx the parse tree
	 */
	void enterFormlist(RParser.FormlistContext ctx);
	/**
	 * Exit a parse tree produced by {@link RParser#formlist}.
	 * @param ctx the parse tree
	 */
	void exitFormlist(RParser.FormlistContext ctx);
	/**
	 * Enter a parse tree produced by {@link RParser#form}.
	 * @param ctx the parse tree
	 */
	void enterForm(RParser.FormContext ctx);
	/**
	 * Exit a parse tree produced by {@link RParser#form}.
	 * @param ctx the parse tree
	 */
	void exitForm(RParser.FormContext ctx);
	/**
	 * Enter a parse tree produced by {@link RParser#sublist}.
	 * @param ctx the parse tree
	 */
	void enterSublist(RParser.SublistContext ctx);
	/**
	 * Exit a parse tree produced by {@link RParser#sublist}.
	 * @param ctx the parse tree
	 */
	void exitSublist(RParser.SublistContext ctx);
	/**
	 * Enter a parse tree produced by {@link RParser#sub}.
	 * @param ctx the parse tree
	 */
	void enterSub(RParser.SubContext ctx);
	/**
	 * Exit a parse tree produced by {@link RParser#sub}.
	 * @param ctx the parse tree
	 */
	void exitSub(RParser.SubContext ctx);
}
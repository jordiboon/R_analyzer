# R_analyzer
ANTLR parser for analyzing R code

# Python
Build using
`antlr4 -Dlanguage=Python3 R.g4 RFilter.g4 -visitor`

Within the `RFilter.py` file change the line
`(0 if localctx._NL is None else localctx._NL.channel) = Token.HIDDEN_CHANNEL` 
to
`localctx._NL.channel = Token.HIDDEN_CHANNEL`

Run using
`python3 parseR.py test.r`

# Java
Build using
`antlr4 R.g4 RFilter.g4 -visitor`
`javac *.java`

Run using
`java TestR.java test.r`

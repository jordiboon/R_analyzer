# R_analyzer
ANTLR parser for analyzing R code

Build using
`antlr4 R.g4 RFilter.g4 -visitor`
`javac *.java`

Then run using
`java TestR.java test.r`

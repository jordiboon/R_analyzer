lab.x = ifelse(log10(at.x) %% 1 == 0, sapply(log10(at.x),function(i) 
      as.expression(bquote(10^ .(i)))), NA)

mod=lm(log(density)~log(xx),data=data.frame(mat))
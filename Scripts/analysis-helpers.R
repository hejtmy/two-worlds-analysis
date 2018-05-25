make_graph <- function(data, x_name, y_name, fill_name){
  ggplot(data, aes(x = data[, x_name], y = data[, y_name], fill=factor(data[, fill_name]))) +
    stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95),geom="errorbar") + 
    stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar")
}

library(tidyverse)

reg_lambda <- c(0, 0, 0, 0, 0, 0,
                .05, .05, .05, .05, .05, .05,
                .1, .1, .1, .1, .1, .1)
split <- c(.01, .01, .05, .05, .1, .1,
           .01, .01, .05, .05, .1, .1,
           .01, .01, .05, .05, .1, .1)
test_on <- c(0, 1, 0, 1, 0, 1,
             0, 1, 0, 1, 0, 1,
             0, 1, 0, 1, 0, 1)
wcss <- c(.000020913029026612122, .000024050547456201633,
         .00009093906399071993, .00009534792707635364,
         .0002612278671243408, .00025927579541418433,
         .0015179743964808946, .0013822679022768643,
         .0013123978298941407, .0013878167128284552,
         .0013967887494633145, .0013931202792705894,
         .001466853611247302, .0013371728947324528,
         .0012642820801902065, .0013382759004983563,
         .0013427336365777103, .0013401579908486009)
bcss <- c(.00001876614495238682, .00000036224056193523424,
          .00003399515750862614, .00000036403923275862837,
          .00006837967848971616, .0000008350564219550272,
          .0009961261079596828, .00000436309028117865,
          .0005147524944623116, .000004337570567114479,
          .00036568431731942574, .000004341670271024167,
          .0009630843071649631, .0000041556330881986625,
          .0004961956457017469, .00000414298224732379,
          .0003515164833163831, .0000041442884662346025)
data <- data.frame(reg_lambda, split, test_on, wcss, bcss)
data$ratio <- wcss/bcss

ggplot(data, aes(as.factor(reg_lambda), ratio,
                 color=as.character(test_on), shape=as.character(split))) +
  geom_point(position=position_jitter(width=.25, seed=8), size=2) +
  scale_color_manual(breaks=c("0", "1"),
                     labels=c("Known Images", "Unseen Images"),
                     values=c("#7b3294", "#008837")) +
  scale_shape_discrete(breaks=c("0.01", "0.05", "0.1"), labels=c("1%", "5%", "10%")) +
  labs(title="Sum of Squares Ratio For Varied Hyperparameters",
       color="Tested On",
       shape="Dataset in Hint") +
  xlab("Regularization Coefficient") +
  ylab("Within / Between Cluster Sum of Squares") +
  theme_light() +
  theme(text = element_text(family="Avenir"))

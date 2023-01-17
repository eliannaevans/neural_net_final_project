library(tidyverse)
data <- read.csv("neuralNetVisualizations/preds_vs_labels_reg0split1percent.csv")
summary(data)

means <- aggregate(Prediction ~ Action, data, mean)
means

ggplot(data, aes(x=Action, y=Prediction, color=Action)) +
  geom_point(position=position_jitter(width=.5, height=0)) +
  geom_boxplot() +
  scale_x_discrete(limits=c("calling", "running", "sitting", "sleeping", "texting"),
                   labels=c("Calling", "Running", "Sitting", "Sleeping", "Texting")) +
  scale_color_manual(values=c("#7b3294", "#008837", "#e66101", "#d01c8b", "#0571b0")) +
  ylim(0.98974, 0.99002) +
  theme_light() +
  theme(text = element_text(family="Avenir"),
        legend.position = "none")

ggplot(data, aes(x=Prediction, y=Prediction, color=Action)) +
  geom_point(position=position_jitter(width=.004, height=0)) +
  facet_grid(cols=vars(Action))

hist_data <- read.csv("neuralNetVisualizations/gradnorm_history.csv")
summary(hist_data)
ggplot(hist_data, aes(x=Iteration, y=Gradnorm, color=Model)) +
  geom_line(aes(linetype=Model)) +
  scale_color_manual(values=c("#7b3294", "#008837", "#e66101")) +
  scale_linetype_manual(values=c("dashed", "solid", "solid")) +
  scale_y_continuous(breaks=c(0.0, .1, .2, .3, .4, .5, .6, .7)) +
  scale_x_continuous(breaks=c(0, 1000, 2000, 3000, 4165)) +
  theme_light() +
  theme(text = element_text(family="Avenir"))

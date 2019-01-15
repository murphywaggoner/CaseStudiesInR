# 
# M. E. (Murphy) Waggoner - Using the same analysis as in "Data Science in R : 
# A Case Studies Approach to Computational Reasoning and Problem Solving"
# by Duncan Temple Lang and Deborah Nolan
# MEW rewrote the code to implement the tidyverse and to include
# some other analysis - February 2018
#
# The original R code (before Murphy edits)
# corresponds to 3 or 7 videos on YouTube
# the first video in the series is located at the following URL:
#     http://www.youtube.com/watch?v=32o0DnuRjfg
#

# From the original code:  Copyright 2012 Dave Langer
#    
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#  	http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


##########Load libraries up front

# Load up tidyverse packages:
# ggplot2, purrr, tibble, dplyr, tidyr, stringr, readr, forcats 
require(tidyverse)

###########Load the data and do some adjusting

# Load raw data
train <- read.csv("Titanic_train.csv", header = TRUE)
test <- read.csv("Titanic_test.csv", header = TRUE)

# Add a "survived" variable to the test set as a column on the left 
# so that test and train have the same variables
test <- test %>% 
  mutate(survived = rep("Test", nrow(test))) %>% 
  select(survived, everything())  # Puts survived as first column

# Combine data sets one on top of the other
passengers <- rbind(train, test)

##########Look at the data

# A bit about R data types (e.g., factors)
str(passengers)
summary(passengers)

# Have the students look at the passenger data (View(passengers))
# and describe the types of groups of passengers there are
# families, singles, etc., what type of family (single mother, etc.)
# Look at a typical cruise ship class system, what do the cabin names
# tell us?
# What do duplicate ticket numbers tell us?

# The overall question is whether we can predict who survives or not
# in the training set, but FIRST we must understand the data.  This 
# means looking at it closely, gleaming whatever we can, making assumption
# only when necessary, etc., before we ever build a model of the data
# to try to answer the question

# Some of the variables should be factor data instead
# compare structure before and after
passengers <- passengers %>% 
  mutate(survived = as.factor(survived))
passengers <- passengers %>% 
  mutate(pclass = as.factor(pclass))
str(passengers)
summary(passengers)

# Take a look at gross survival rates
passengers %>% 
  group_by(survived, pclass) %>% 
  summarise(n=n())

# Distribution across classes
passengers %>% 
  group_by(pclass) %>% 
  summarise(n=n())

# Creating a hypothesis on who survived at greater rates.
passengers %>% 
  mutate(pclass = as.factor(pclass)) ->
  passengers

passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = pclass, fill = factor(survived))) +
  geom_bar() +
  xlab("pclas") +
  ylab("Total Count") +
  labs(fill = "survived") 

#########What's in a name?

# Examine the first few 20 passenger names.  Observations?
passengers %>% 
  select(name) %>% 
  head(20)

#####          Duplicate names
# How many unique names are there among the passengers?
passengers %>% 
  group_by(name) %>% 
  summarise(n = n())

# Some duplicate names (how do we know?) 
# See which ones are duplicates
passengers %>% 
  group_by(name) %>% 
  summarise(n = n()) %>% 
  filter(n > 1) 

# grab and list the duplicate names
passengers %>% 
  group_by(name) %>% 
  summarise(n = n()) %>% 
  filter(n > 1) ->
  dup.names

dup.names

# Who are these passengers and are they distinct?
# MEW note: how can I avoid the $?
passengers %>% 
  filter(name %in% dup.names$name ) %>% 
  arrange(name)

#####          Titles

#Create a new variable (feature engineering) with the title of the passenger
# this is a complicated command but it says 
# regex(", (.*?)\\.) = a string that starts with ", " and ends with "."
# and has anything of any length in between the ", " and the "."
# this is a regular expression and we'll talk about these more later
# str_match(name, ...) => extract the string described by the regex from name
# as.factor(...) => make the variable a factor rather than string class
# mutate(title = ...) => create a new column called title containing this factor variable
passengers %>% 
  mutate(title = str_match(name, regex(", (.*?)\\."))[,2]) ->
  passengers

# What titles are there and how many of each? min and max ages? mean age?
passengers %>% 
  group_by(title) %>% 
  summarise(n = n(), 
            minage = min(age), 
            maxage = max(age), 
            meanage = mean(age))

# Why do we get NAs for the stats for some titles?
passengers %>% 
  group_by(title) %>% 
  summarise(n = n(), 
            minage = min(age), 
            maxage = max(age), 
            meanage = mean(age),
            sum(is.na(age)))
  
passengers %>% 
  group_by(title) %>% 
  summarise(n = n(),
            ageexists = n() - sum(is.na(age)),
            minage = min(age, na.rm=TRUE),
            meanage = mean(age,na.rm=TRUE),
            maxage = max(age, na.rm=TRUE))
  

# How does title effect survival?
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = pclass, fill = survived)) +
  geom_bar() +
  facet_wrap(~title) + 
  xlab("Class") +
  ylab("Total Count") +
  labs(fill = "survived") 

# The plot above is not very useful.  Why not?

passengers %>% 
  ggplot(aes(x = age, fill = title)) +
  geom_histogram() +
  xlab("age") +
  ylab("Total Count")  

# NOTA BENE:  if_else retains object attributes and 
# ifelse does not

passengers %>% 
  mutate(simple_title = 
           if_else(title %in% c("Capt", "Col", "Don", 
                                "Dona", "Dr", "Jonkheer", 
                                "Lady", "Major", "Rev",
                                "Sir", "the Countess"), 
                "Other", 
                title)
        ) ->
  passengers

# How does title effect survival?

passengers %>% 
  group_by(simple_title) %>% 
  summarise(n = n(), 
            minage = min(age, na.rm = TRUE), 
            maxage = max(age, na.rm = TRUE), 
            meanage = mean(age, na.rm = TRUE))

# What story does this histogram tell?
passengers %>% 
  ggplot(aes(x = age, fill = simple_title)) +
  geom_histogram() +
  xlab("age") +
  ylab("Total Count")  

# Is there a relationship between title and survival?
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = pclass, fill = survived)) +
  geom_bar() +
  facet_wrap(~simple_title) + 
  xlab("Class") +
  ylab("Total Count") +
  labs(fill = "survived") 

##########Ages

# What other variables could we create (engineer) 
# that don't exist and how can we get around the 
# missing age variables?
passengers %>% 
  mutate(adult = if_else(age >= 15, TRUE, FALSE)) ->
  passengers

passengers %>% 
  filter(is.na(age)) %>% 
  group_by(title) %>% 
  summarise(n = n()) ->
  ageless

# Note that sex and title have no missing variables
# can we use title as a proxy for age?
# How do the passengers with missing ages compare
# to passengers's ages with the same title
passengers %>% 
  filter(title %in% ageless$title) %>% 
  group_by(title, sex, adult, parch, sibsp) %>% 
  summarise(n = n(), 
            minage = min(age), 
            meanage = mean(age),
            maxage = max(age),
            family = sum(parch),
            samegen = sum(sibsp)) %>% 
            arrange(title)

# Validate that "Master." is a good proxy for male children
passengers %>% 
  filter(title == "Master") %>% 
  summarise(n = n(), 
          minage = min(age, na.rm = TRUE), 
          meanage = mean(age, na.rm = TRUE),
          maxage = max(age, na.rm = TRUE),
          males = sum(sex == "male"))

passengers %>% 
  mutate(adult = if_else(title == "Master", FALSE, adult)) -> 
  passengers

## Visualize the 3-way relationship of sex, pclass, 
## and survival, compare to analysis of title
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = sex, fill = survived)) +
  geom_bar() +
  facet_wrap(~pclass) + 
  ggtitle("pclass") +
  xlab("sex") +
  ylab("Total Count") +
  labs(fill = "survived")


# Just to be thorough, take a look at survival rates broken out by 
# sex, pclass, and age
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = age, fill = survived)) +
  facet_wrap(~sex + pclass) +
  geom_histogram(binwidth = 10) +
  xlab("Age") +
  ylab("Total Count")


# We know that "Miss." is more complicated, let's examine further

passengers %>% 
  filter(title == "Miss") %>% 
  summarise(n = n(), 
            minage = min(age, na.rm = TRUE), 
            meanage = mean(age, na.rm = TRUE),
            maxage = max(age, na.rm = TRUE),
            females = sum(sex == "female"))

passengers %>% 
  filter(title == "Miss") %>%
  ggplot(aes(x = age, fill = survived)) +
  facet_wrap(~pclass) +
  geom_histogram(binwidth = 5) +
  ggtitle("Age for title of Miss by Class") + 
  xlab("Age") +
  ylab("Total Count")


# OK, appears female children may have different survival rate, 
# could be a candidate for feature engineering later

# What about Misses traveling alone?
passengers %>% 
  filter(title == "Miss" & sibsp == 0 & parch == 0) %>% 
  summarise(n = n(), 
            minage = min(age, na.rm = TRUE), 
            meanage = mean(age, na.rm = TRUE),
            maxage = max(age, na.rm = TRUE))


# Move on to the sibsp variable, summarize the variable
# Can we treat as a factor?  Would we want to?
passengers %>% 
   summarise(n = n(), 
            minsibsp = min(sibsp, na.rm = TRUE), 
            meansibsp = mean(sibsp, na.rm = TRUE),
            maxsibsp = max(sibsp, na.rm = TRUE),
            uniquesibsp = n_distinct(sibsp))

# We believe title is predictive. Visualize survival reates by 
#  sibsp,
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = sibsp, fill = survived)) +
  geom_bar() +
  xlab("SibSp") +
  ylab("Total Count") +
  labs(fill = "survived")

# We believe title is predictive. Visualize survival reates by 
#  parch
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = parch, fill = survived)) +
  geom_bar() +
  xlab("ParCh") +
  ylab("Total Count") +
  labs(fill = "survived")

# Let's try some feature engineering. What about 
# creating a family size feature?
passengers %>% 
  mutate(family = sibsp + parch + 1) ->
  passengers

# Visualize it to see if it is predictive
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = family, fill = survived)) +
  geom_bar() +
  xlab("family.size") +
  ylab("Total Count") +
  labs(fill = "survived")



# Based on the huge number of levels ticket really isn't a factor variable it is a string. 
# Convert it and display first 20
str(passengers)
passengers %>% 
  mutate(ticket = as.character(ticket)) ->
  passengers

# There's no immediately apparent structure in the data, 
# let's see if we can find some.
# We'll start with taking a look at just the first char for each



# First, a high-level plot of the data
passengers %>% 
  mutate(ticket.first.char = str_sub(ticket, 1, 1)) %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = ticket.first.char, 
         fill = survived)) +
  geom_bar() +
  ggtitle("Survivability by ticket.first.char") +
  xlab("ticket.first.char") +
  ylab("Total Count") +
  labs(fill = "survived")

# Ticket seems like it might be predictive, drill down a bit

passengers %>% 
  mutate(ticket.first.char = str_sub(ticket, 1, 1)) ->
  passengers

passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = ticket.first.char, fill = survived)) +
  geom_bar() +
  facet_wrap(~pclass) + 
  ggtitle("pclass") +
  xlab("ticket.first.char") +
  ylab("Total Count") +
  labs(fill = "survived")



# Lastly, see if we get a pattern when using combination of 
# pclass & simple_title
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = ticket.first.char, fill = survived)) +
  geom_bar() +
  facet_wrap(~pclass + simple_title) + 
  ggtitle("pclas, simple_title") +
  xlab("ticket.first.char") +
  ylab("Total Count") 
  labs(fill = "survived")




# Next up - the fares Titanic passengers paid
passengers %>% 
    summarise(maxfare = max(fare, na.rm = TRUE),
            meanfare = mean(fare, na.rm = TRUE),
            minfare = min(fare, na.rm = TRUE),
            unique = n_distinct(fare))


# Can't make fare a factor, treat as numeric & visualize with histogram
ggplot(passengers, aes(x = fare)) +
  geom_histogram(binwidth = 5) +
  ggtitle("Combined Fare Distribution") +
  xlab("Fare") +
  ylab("Total Count") 


# Let's check to see if fare has predictive power
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = fare, fill = survived)) +
  geom_histogram(binwidth = 5) +
  facet_wrap(~pclass + simple_title) + 
  ggtitle("pclas, simple_title") +
  xlab("fare") +
  ylab("Total Count") 
  labs(fill = "survived")


# Analysis of the cabin variable
str(passengers)


# Cabin really isn't a factor, make a string and the display first 100
passengers %>% 
  mutate(cabin = as.character(cabin)) ->
  passengers 

passengers %>% 
  select(cabin) %>% 
  head(100)


# Replace empty cabins with a "U"
passengers %>% 
  mutate(cabin = if_else(cabin == "","U",cabin)) ->
  passengers 

passengers %>% 
  select(cabin) %>% 
  head(100)


# Take a look at just the first char as a factor
passengers %>% 
  mutate(cabin.first.char = str_sub(cabin, 1, 1)) ->
  passengers

passengers %>% 
  group_by(cabin.first.char) %>% 
  summarise(n = n())



# High level plot
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = cabin.first.char, fill = survived)) +
  geom_bar() +
  ggtitle("Survivability by cabin.first.char") +
  xlab("cabin.first.char") +
  ylab("Total Count") 
  labs(fill = "survived")

# Could have some predictive power, drill in
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = cabin.first.char, fill = survived)) +
  geom_bar() +
  facet_wrap(~pclass) +
  ggtitle("Survivability by cabin.first.char") +
  xlab("pclas") +
  ylab("Total Count") 
  labs(fill = "survived")

# Does this feature improve upon pclass + simple_title?
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = cabin.first.char, fill = survived)) +
  geom_bar() +
  facet_wrap(~pclass + simple_title) +
  ggtitle("pclas, simple_title") +
  xlab("cabin.first.char") +
  ylab("Total Count") 
  labs(fill = "survived")


# What about folks with multiple cabins?
passengers %>% 
  mutate(cabin.multiple = str_detect(cabin, " ")) ->
  passengers

passengers %>% 
  summarise(count = sum(cabin.multiple))

passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = cabin.multiple, fill = survived)) +
  geom_bar() +
  facet_wrap(~pclass + simple_title) +
  ggtitle("pclas, simple_title") +
  xlab("cabin.multiple") +
  ylab("Total Count") +
  labs(fill = "survived")


# Does survivability depend on where you got onboard the Titanic?
str(passengers$embarked)
levels(passengers$embarked)


# Plot data for analysis
passengers %>% 
  filter(survived != "Test") %>% 
  ggplot(aes(x = embarked, fill = survived)) +
  geom_bar() +
  ggtitle("pclas, simple_title") +
  xlab("embarked") +
  ylab("Total Count") +
  labs(fill = "survived")
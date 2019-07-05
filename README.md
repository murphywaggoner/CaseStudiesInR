# CaseStudiesInR
Case Studies written using the tidyverse to be used as illustrations of concepts in data science courses

## Contents

This repository contains RMarkdown files and associated data files for a variety of case studies in data science.  Most of these are well-known case studies or come from textbooks or other sources.  The contribution provided by this repository is that the case study code has been rewritten using the *tidyverse*.  The intention is that these case studies can be used in the classroom as illustration of various data science concepts and techniques.

## Additional Case Studies

Other case study sources besides those in this repository are listed here.  This author is happy to accept recommendations for other detailed cased studies to list here. 

### Cleaning and visualizing genomic data

This article demonstrates the value of tidy data for visualization.  The tidying is done to a gene expression data set, but the process can be understood without knowing anything about genomics.  In fact, that is the point of the article! The article can be found at [Cleaning and visualizing genomic data: a case study in tidy analysis](http://varianceexplained.org/r/tidy-genomics/), but the code is a little dated.  See the instructor for suggestions on how to "fix" the code.

### Vignettes for tidy data

This is not so much a case study as a series of examples of tidying various data, including Billboard ratings.
The vignettes can be found at [Tidy data](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html), which is a code-heavy and shorter version of Hadley Wickham's, [Tidy data](http://vita.had.co.nz/papers/tidy-data.html) published in the The Journal of Statistical Software, vol. 59, 2014.

### International Adoptions - Box-Cox Transformations

This case study uses a dataset from the May 1993 *Ours Magazine* published by [Adoptive Parents](https://www.adoptivefamilies.com/)
to investigate changes in the
number of visas issued to prospective parents from the U.s. who are adopting from other countries.  The data has a long right 
tail and so a transformation of the data is needed to understand it.  The original case study comes from 
*A Casebook for a First Course in Statistics and Data Analysis* by Chatterjee, Handcock, and Simonoff.  A version of it with
R code is in your course Scholar site along with the data set.  It might be possible to do a more contemporary study or long-term
study using data from the [U.S. government travel site](https://travel.state.gov/content/travel/en/Intercountry-Adoption/adopt_ref/adoption-statistics.html.).

### La Quinta

[A well-developed case study](https://www.rstudio.com/resources/webinars/data-science-case-study/)
on scraping the web for data for La Quinta Hotels 
and Denny's Restaurants to see the geographical relationship between these companies. 
Includes a video and other materials.


### Irises

The iris dataset  has been analyzed by many people, but 
[this case study](https://github.com/rhiever/Data-Analysis-and-Machine-Learning-Projects/blob/master/example-data-science-notebook/Example%20Machine%20Learning%20Notebook.ipynb) lays out
the analysis beginning with a good look at the data.


### Flights

[This case study](https://www.r-bloggers.com/a-data-science-case-study-in-r/) attempts to answer questions about flight data similar to what Hadley and Grolemund did in R4DS.

### Old Faithful

The data on eruption time and intervals between eruptions has been analyzed in many ways.  [Mike Anderson's analysis](http://faculty.business.utsa.edu/manderso/R-examples/Geyser/Geyser.html) focuses on models of the data on Old Faithful found in the **geyser** dataset on R.  Flip through all the tabs in this analysis to see all the models.  The **geyser** dataset is taken from Azzalini and Bowman, “A look at some data on the Old Faithful Geyser”, JRSS-C (Applied Statistics), 39(3), pp357-365 (1990).  For this case study, you are asked to go beyond just what is in Anderson's website, which analyzes data from the 1980s.  At [The Geyser Study and Observation Association](http://www.geyserstudy.org/geyser.aspx?pGeyserNo=OLDFAITHFUL)  you'll find Old Faithful data for 2000 to 2011.  However, the data is in a different format than the **geyser** data.  Use R to read the data there, create a tibble with the same variables as **geyser** and rerun Anderson's analysis.  Are the results the same?


### Internal Positioning System

Chapter 1 from **Data Science in R: A Case Studies Approach
to Computational Reasoning and Problems Solving** by Deborah Nolan and Duncan Temple Lang is a more sophistocated case study on using an indoor position system to predict locations.  The case study changes the shape of the data and uses a *k*-nearest neighbors model to make predictions on locations of transmitters.  The [R code](http://rdatasciencecases.org/GeoLoc/code.R) and the [first 32 pages of the case study](https://books.google.com/books?id=A5O9BwAAQBAJ&printsec=frontcover&source=gbs_ge_summary_r&cad=0#v=onepage&q&f=false) are available online. 

### Beer Ratings

This open-ended case study asks you to look at data about beer and customer ratings.  Dr. James D. Wilson of University
of San Francisco wrote the [questions](https://github.com/murphywaggoner/Intro-Data-Science/blob/master/Code_Demonstrations/Case%20Study%201/Beer_Analysis.pdf) and gathered the [data](https://github.com/murphywaggoner/Intro-Data-Science/blob/master/Code_Demonstrations/Case%20Study%201/beer.data.RData).

### Text Analysis

This open-ended case study asks you to use text manipulation and regular expressions to gather information from a set of 
tweets and the State of the Union speeches from 1790 to 2012.  Dr. James D. Wilson of University
of San Francisco wrote the [questions](https://github.com/murphywaggoner/Intro-Data-Science/blob/master/Code_Demonstrations/Case%20Study%202/CaseStudy2.pdf) and gathered the [data](https://github.com/murphywaggoner/Intro-Data-Science/tree/master/Data).

### UN Voting Data

This case study is an exploratory data analysis of historical voting data from the General Assembly of the United Nations and goes through tidying, visualizing, and modeling.  This case study is a part of a DataCamp course on *Exploratory Data Analysis in R*.  Sources include the [lectures for the course](https://www.datacamp.com/courses/exploratory-data-analysis-in-r-case-study) and the [course notes](https://rpubs.com/williamsurles/299664) written by William Surles. To get to the lectures on the course page, scroll down until you get to "Data Cleaning and Summarizing with R." Note that to access all the lectures in this DataCamp course, you might need a subscription to DataCamp

### Analyzing U.S. Census Data

Another case study from DataCamp uses the **tidycensus** package and other tools to access census data, wrangle it, and learn how to visualize the data in a multitude of ways.  This case study uses some advanced wrangling and plotting tools for exploratory data analysis, but does not have any predictive modeling.  The first chapter of DataCamp's [Analyzing U.S. Census Data in R](https://campus.datacamp.com/courses/analyzing-us-census-data-in-r/census-data-in-r-with-tidycensus) is free, but you'll need a subscription to access the full case study. 

### Analyzing Election and Polling Data in R

This case study from DataCamp uses the **tidyverse**, linear models, and other tools to wrangle election and polling data, visualize it, and create predictive models from it.  Some of the questions investigated are why Brexit was difficult to predict and how can we predict the 2020 election.  The first chapter of DataCamp's [Analyzing Election and Polling Data in R](https://www.datacamp.com/courses/analyzing-election-and-polling-data-in-r) is free, but you'll need a subscription to access the full case study. 

### Supervised Learning in R: Case Studies

This DataCamp course uses 4 different data sets to investigate regression and classification models and how to evaluate them. The data sets include the ubiquitous **mtcars**, a StackOverflow developer survey, polling data, and a survey of nuns in 1967.  The final chapter looks at 3 models that are not covered in the courses at Simpson.   The first chapter of DataCamp's [Supervised Learning in R: Case Studies](https://campus.datacamp.com/courses/supervised-learning-in-r-case-studies) is free, but you'll need a subscription to access the full course.

### Exploring Pitch Data with R

Students who are interested in honing their exploratory data analysis skills in R while looking at publicly available Major League Baseball data will be interested in this case study.  The **tidyverse** tools are used in this course, especially **ggplot** for creating a variety of plots including heatmaps to explore data about pitching in MLB. The first chapter of DataCamp's [Exploring Pitch Data with R](https://www.datacamp.com/courses/exploring-pitch-data-with-r) is free, but you'll need a subscription to access the full course.

### Logistic Modeling to Predict Employee Turnover

This case study uses human resource data to predict employee turnover.  The course has 4 chapters focusing on acquiring data, feature engineering, creating a logistic regression model, and validating and using that model, respectively.  Emphasis is placed on recognizing and handling multicolinarity and using a confusion table.  The first chapter of DataCamp's [Human Resources Analytics in R: Predicting Employee Churn](https://www.datacamp.com/courses/human-resources-analytics-in-r-predicting-employee-churn) is free, but you'll need a subscription to access the full course.

### 






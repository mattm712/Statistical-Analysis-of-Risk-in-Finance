# Overview
This is a project using R programming that investigates Value-at-Risk, Expected Shortfall and backtesting techniques on popular equity data. Please download the R code alongside the historical equity data for Amazon, Tesla and Apple.

# Value-at-Risk (VaR)
Value-at-Risk (VaR) is a statistical measurement that determines the maximum amount of possible financial loss within an investment, taken over a specific time frame assuming a certain level of probability. For example, if the 99% one-day VaR is $1,000 for a portfolio, over the following day it can be said that with 99% certainty, the portfolio will lose no more than $1,000. VaR remains a popular method amongst various banks across the globe and is a brilliant tool for representing trading risks to directors and shareholders. VaR can be computed in various different ways including Gaussian VaR, historical VaR and using extreme value theory, which will all be explored here. The one-day VaR will be calculated for the individual stocks of Amazon (AMZN), Tesla (TSLA), Apple (APPL) and an equal weighted portfolio comprising of these three stocks. 

# Gaussian VaR
The Gaussian method for estimating VaR, or commonly referred to as the parametric method, makes the assumption that the returns follow a normal distribution. Although simple, the Gaussian method remains effective for the computation of VaR in many cases. However, concerns arise when considering the validity of the normality assumption. In this case Amazon, Tesla, Apple and the portfolios returns do in fact approximately follow a normal distribution, however this may not always be the case. The Gaussian method involves the calculation of parameters including the portfolio standard deviation and the average return, which is where the parametric name stems from. The formula used is as follows: 

VaRα = −(μ + σZα)*𝐼  

Where: 
* 𝑉𝑎𝑅𝛼 𝑖𝑠 𝑡h𝑒 𝑉𝑎𝑙𝑢𝑒 − 𝑎𝑡 − 𝑅𝑖𝑠𝑘 𝑓𝑜𝑟 𝑎 𝑔𝑖𝑣𝑒𝑛 𝑠𝑖𝑔𝑛𝑖𝑓𝑖𝑐𝑎𝑛𝑐𝑒 𝑙𝑒𝑣𝑒𝑙 𝛼  
* 𝜇 𝑖𝑠 𝑡h𝑒 𝑚𝑒𝑎𝑛 𝑜𝑓 𝑡h𝑒 𝑝𝑜𝑟𝑡𝑓𝑜𝑙𝑖𝑜 𝑟𝑒𝑡𝑢𝑟𝑛𝑠  
* 𝜎 𝑖𝑠 𝑡h𝑒 𝑠𝑡𝑎𝑛𝑑𝑎𝑟𝑑 𝑑𝑒𝑣𝑖𝑎𝑡𝑖𝑜𝑛 𝑜𝑓 𝑡h𝑒 𝑝𝑜𝑟𝑡𝑓𝑜𝑙𝑖𝑜 𝑟𝑒𝑡𝑢𝑟𝑛𝑠  
* 𝑍𝛼 𝑖𝑠 𝑡h𝑒 𝑧 − 𝑠𝑐𝑜𝑟𝑒 𝑏𝑎𝑠𝑒𝑑 𝑜𝑛 𝑡h𝑒 𝑉𝑎𝑅 𝑠𝑖𝑔𝑛𝑖𝑓𝑖𝑐𝑎𝑛𝑐𝑒 𝑙𝑒𝑣𝑒𝑙 𝛼  
* 𝐼 𝑖𝑠 𝑡h𝑒 𝑐𝑢𝑟𝑟𝑒𝑛𝑡 𝑝𝑜𝑟𝑡𝑓𝑜𝑙𝑖𝑜 𝑣𝑎𝑙𝑢𝑒

# Historical VaR
The historical method is another simple yet effective strategy for the computation of VaR. It works by collecting the historical returns data from the individual security or portfolio and assuming history will repeat itself, where having more historical data to analyse deems to produce a more precise measurement for VaR. To make the analysis more simplistic, the returns are organised from worst to best and the VaR for a given confidence interval can be extracted from the far left of the distribution, where the smallest returns lie. The method makes no distributional assumption which in turn makes it a more accurate method for non-linear products in comparison to the Gaussian method. The historical returns from 2019-2021 for Amazon, Tesla, Apple and an equal weighted portfolio of these three stocks were plotted, analysed and calculations of the historical VaR were made in R. 

# Extreme Value Theory VaR
Extreme value theory (EVT) is a theory that examines extreme events within a data set, which in our case is the returns of Amazon, Tesla, Apple and an equal weighted portfolio of these three stocks. Often, extreme events are disregarded and named as outliers, however, in the financial world, extreme events can carry the most importance. EVT uses two approaches to extract extreme events from the data, Block Maxima (BM) and Peaks over Threshold (POT). To detail the Block Maxima approach, the data is split into groups, in our case this could be the different months/years over which the data was recorded. The largest value from each group is then chosen to make inference on. The Block Maxima approach however has been frequently labelled as a wasteful approach when used with financial data due to extreme events regularly clustering together which leaves certain blocks with multiple extreme values, but only the largest can be included. The second approach, POT, deems to be more effective and will be the approach used to evaluate VaR here. Firstly, for the POT method, a threshold must be carefully selected and any values above this threshold are considered extreme. This can be done a few different ways through calculation or examining different plots of the data. In this case, I have used a Mean residual life plot to determine the appropriate thresholds. Picking an optimal threshold from this plot and many others is subjective and may differ from person to person, however a value too high mustn’t be chosen as you will be left with too little extreme values to make inference on. The next step in the POT method would be to fit the Generalised Pareto Distribution (GPD), and then calculate the VaR using the following formula:with the following formula: 

VaRα = u + (ψ(u)/ε)((N/Nu)((1 − α)^−ε) − 1 )

Where: 
* VaRα 𝑖𝑠 𝑡h𝑒 𝑉𝑎𝑙𝑢𝑒 − 𝑎𝑡 − 𝑅𝑖𝑠𝑘 𝑎𝑡 𝑎 𝑔𝑖𝑣𝑒𝑛 𝑠𝑖𝑔𝑛𝑖𝑓𝑖𝑐𝑎𝑛𝑐𝑒 𝑙𝑒𝑣𝑒𝑙
* u is the threshold
* 𝜀 𝑖𝑠 𝑡h𝑒 𝑠h𝑎𝑝𝑒 𝑝𝑎𝑟𝑎𝑚𝑒𝑡𝑒𝑟
* 𝜎 𝑖𝑠 𝑡h𝑒 𝑠𝑐𝑎𝑙𝑒 𝑝𝑎𝑟𝑎𝑚𝑒𝑡𝑒𝑟 
* 𝜇 𝑖𝑠 𝑡h𝑒 𝑙𝑜𝑐𝑎𝑡𝑖𝑜𝑛 𝑝𝑎𝑟𝑎𝑚𝑡𝑒𝑟 • 𝜓(𝑢)= 𝜎+ 𝜀(𝑢−𝜇) 
* N 𝑖𝑠 𝑡h𝑒 𝑝𝑟𝑜𝑝𝑜𝑟𝑡𝑖𝑜𝑛 𝑜𝑓 𝑠𝑎𝑚𝑝𝑙𝑒𝑠 𝑎𝑏𝑜𝑣𝑒 𝑡h𝑒 𝑡h𝑟𝑒𝑠h𝑜𝑙𝑑 

# Expected Shortfall (ES)
Although VaR is an effective method for the quantification of risk for an investment, it does have some inefficiencies. In particular, VaR does not capture the tail of the distribution. Expected shortfall (ES), which is also commonly referred to as conditional VaR or tail risk, is a method that explores the small possibility of our investment losses exceeding VaR. For example, if a VaR value was calculated at a 99% confidence interval, there is a 1% chance our losses will exceed this estimate, so this possibility must be explored. Generally, the more proof of stability shown in an investment over time, the more likely VaR is to be sufficient at quantifying the risk. However, as evidence of stability decreases, expected shortfall should become more of a likely option to quantify risk. To parallel the previous VaR analysation, the same methods of calculation will be used for expected shortfall as were used for VaR. 

# Gaussian ES
Following the same principles as Gaussian VaR discussed previously, Gaussian Expected Shortfall makes the assumption that the returns are normally distributed. The formula is as follows:

𝐸𝑆𝛼 = 𝜇+ 𝜎(𝜑(Φ(𝛼))/𝛼) 

Where: 
* 𝐸𝑆𝛼 𝑖𝑠 𝑡h𝑒 𝐸𝑥𝑝𝑒𝑐𝑡𝑒𝑑 𝑆h𝑜𝑟𝑡𝑓𝑎𝑙𝑙 𝑎𝑡 𝑎 𝑔𝑖𝑣𝑒𝑛 𝑠𝑖𝑔𝑛𝑖𝑓𝑖𝑐𝑎𝑛𝑐𝑒 𝑙𝑒𝑣𝑒𝑙 α
* 𝜇 𝑖𝑠 𝑡h𝑒 𝑚𝑒𝑎𝑛 𝑝𝑜𝑟𝑡𝑓𝑜𝑙𝑖𝑜 𝑟𝑒𝑡𝑢𝑟𝑛
* 𝜎 𝑖𝑠 𝑡h𝑒 𝑠𝑡𝑎𝑛𝑑𝑎𝑟𝑑 𝑑𝑒𝑣𝑖𝑎𝑡𝑖𝑜𝑛 𝑜𝑓 𝑡h𝑒 𝑝𝑜𝑟𝑡𝑓𝑜𝑙𝑖𝑜 𝑟𝑒𝑡𝑢𝑟𝑛𝑠
* 𝜑 𝑖𝑠 𝑡h𝑒 h𝑒𝑖𝑔h𝑡 𝑜𝑓 𝑡h𝑒 𝑛𝑜𝑟𝑚𝑎𝑙 𝑝𝑜𝑟𝑏𝑎𝑏𝑖𝑙𝑖𝑡𝑦 𝑑𝑒𝑛𝑖𝑠𝑡𝑦 𝑓𝑢𝑛𝑐𝑡𝑖𝑜𝑛
* Φ 𝑖𝑠 𝑡h𝑒 𝑖𝑛𝑣𝑒𝑟𝑠𝑒 𝑛𝑜𝑟𝑚𝑎𝑙 𝑐𝑢𝑚𝑚𝑢𝑙𝑎𝑡𝑖𝑣𝑒 𝑑𝑒𝑛𝑠𝑖𝑡𝑦 𝑓𝑢𝑛𝑐𝑡𝑖𝑜𝑛

# Historical ES
Historical expected shortfall again analyses historical data and computes the average of all loses exceeding VaR. For example, if your portfolio VaR was calculated at a 95% confidence level, it would be the average of the worst 5% of losses. 

# Extreme Value Theory ES
Following a similar process as EVT VaR, the expected shortfall can be calculated using the following equation:

𝐸𝑆𝛼 = (VaRα/(1-𝜀)) + ((𝜓(𝑢) − 𝜀𝑢)/(1−𝜀)) 

Where: 
* 𝐸𝑆𝛼 𝑖𝑠 𝑡h𝑒 𝑒𝑥𝑝𝑒𝑐𝑡𝑒𝑑 𝑠h𝑜𝑟𝑡𝑓𝑎𝑙𝑙 𝑎𝑡 𝑎 𝑔𝑖𝑣𝑒𝑛 𝑠𝑖𝑔𝑛𝑖𝑓𝑐𝑎𝑛𝑐𝑒 𝑙𝑒𝑣𝑒𝑙 𝛼
* VaRα 𝑖𝑠 𝑡h𝑒 𝑉𝑎𝑙𝑢𝑒 − 𝑎𝑡 − 𝑅𝑖𝑠𝑘 𝑎𝑡 𝑎 𝑔𝑖𝑣𝑒𝑛 𝑠𝑖𝑔𝑛𝑖𝑓𝑖𝑐𝑎𝑛𝑐𝑒 𝑙𝑒𝑣𝑒𝑙 𝛼
* 𝑢 𝑖𝑠 𝑡h𝑒 𝑡h𝑟𝑒𝑠h𝑜𝑙𝑑
* 𝜀 𝑖𝑠 𝑡h𝑒 𝑠h𝑎𝑝𝑒 𝑝𝑎𝑟𝑎𝑚𝑒𝑡𝑒𝑟
* 𝜎 𝑖𝑠 𝑡h𝑒 𝑠𝑐𝑎𝑙𝑒 𝑝𝑎𝑟𝑎𝑚𝑒𝑡𝑒𝑟
* 𝜇 𝑖𝑠 𝑡h𝑒 𝑙𝑜𝑐𝑎𝑡𝑖𝑜𝑛 𝑝𝑎𝑟𝑎𝑚𝑡𝑒𝑟
* 𝜓(𝑢)= 𝜎+ 𝜀(𝑢−𝜇)

# Backtesting VaR
Back testing is a method that analyses the real profits and loses and compares it to a VaR estimate, ultimately to come to a conclusion as to whether or not the VaR estimate is a legitimate representation of the risk for the stock/portfolio. For example, if a VaR estimate was computed at a 95% confidence interval, on average it would be expected for there to be 5 times that the loss exceeds the VaR estimate (exception) in every 100 days. Back testing is split into different groups, namely, unconditional convergence and conditional convergence. The former takes a specific time period and measures the number of exceptions that occurred, and checks it is in line with the given confidence interval. Conditional convergence tests also follow this procedure however are extended to involve the independence of exceptions, proving to be a more optimal approach to evaluate the validity of a VaR estimate. Firstly, we will look at an unconditional convergence test called Kupiec’s POF test (proportion of failures) which will test whether the number of exceptions is in line with the given confidence interval. The test has the null hypothesis:

𝐻0:𝑝 = 𝑝̂ = 𝑥/𝑇 

Where: 
* 𝐻0 𝑖𝑠 𝑡h𝑒 𝑛𝑢𝑙𝑙 h𝑦𝑝𝑜𝑡h𝑒𝑠𝑖𝑠
* 𝑝 𝑖𝑠 𝑡h𝑒 𝑓𝑎𝑖𝑙𝑢𝑟𝑒 𝑟𝑎𝑡𝑒 𝑔𝑖𝑣𝑒𝑛 𝑓𝑟𝑜𝑚 𝑡h𝑒 𝑐𝑜𝑛𝑓𝑖𝑑𝑒𝑛𝑐𝑒 𝑖𝑛𝑡𝑒𝑟𝑣𝑎𝑙
* 𝑝̂ 𝑖𝑠 𝑡h𝑒 𝑜𝑏𝑠𝑒𝑟𝑣𝑒𝑑 𝑓𝑎𝑖𝑙𝑢𝑟𝑒 𝑟𝑎𝑡𝑒
* 𝑥 𝑖𝑠 𝑡h𝑒 𝑛𝑢𝑚𝑏𝑒𝑟 𝑜𝑓 𝑒𝑥𝑐𝑒𝑝𝑡𝑖𝑜𝑛𝑠
* 𝑇 𝑖𝑠 𝑡h𝑒 𝑛𝑢𝑚𝑏𝑒𝑟 𝑜𝑓 𝑜𝑏𝑠𝑒𝑟𝑣𝑎𝑡𝑖𝑜𝑛𝑠

The test statistic can then be given as:

𝐿𝑅𝑃𝑂𝐹 = −2ln( (((1 − 𝑝)^(𝑇−𝑥))*(𝑝^𝑥))/(((1 − (𝑥/𝑇))^(𝑇-𝑥))*((𝑥/𝑇)^𝑥))

Where: 
* 𝐿𝑅𝑃𝑂𝐹 𝑖𝑠 𝑡h𝑒 𝑡𝑒𝑠𝑡 𝑠𝑡𝑎𝑡𝑖𝑠𝑡𝑖𝑐
* 𝑝 𝑖𝑠 𝑡h𝑒 𝑓𝑎𝑖𝑙𝑢𝑟𝑒 𝑟𝑎𝑡𝑒 𝑔𝑖𝑣𝑒𝑛 𝑓𝑟𝑜𝑚 𝑡h𝑒 𝑐𝑜𝑛𝑓𝑖𝑑𝑒𝑛𝑐𝑒 𝑖𝑛𝑡𝑒𝑟𝑣𝑎𝑙
* 𝑥 𝑖𝑠 𝑡h𝑒 𝑛𝑢𝑚𝑏𝑒𝑟 𝑜𝑓 𝑒𝑥𝑐𝑒𝑝𝑡𝑖𝑜𝑛𝑠
* 𝑇 𝑖𝑠 𝑡h𝑒 𝑛𝑢𝑚𝑏𝑒𝑟 𝑜𝑓 𝑜𝑏𝑠𝑒𝑟𝑣𝑎𝑡𝑖𝑜𝑛𝑠  

This test statistic can then be compared against the chi-squared distribution with one degree of freedom. If the test statistic is less then the chi-squared value, then we accept the backtest as appropriate. However as already mentioned, unconditional convergence tests do not involve the independence of exceptions, so Kupiec’s POF test can be extended to a conditional convergence test called Christoffersen’s interval forecast test. The extension must start by introducing the following indicator variables for exceptions:

1 𝑖𝑓 𝑒𝑥𝑐𝑒𝑝𝑡𝑖𝑜𝑛 𝑜𝑐𝑐𝑢𝑟𝑠, 0 𝑖𝑓 𝑒𝑥𝑐𝑒𝑝𝑡𝑖𝑜𝑛 𝑑𝑜𝑒𝑠𝑛′𝑡 𝑜𝑐𝑐𝑢𝑟 

We can then introduce the formulae:

𝜋0 =  𝑛01 / (𝑛00 + 𝑛01),     𝜋1 = 𝑛11 / (𝑛10 + 𝑛11),    𝜋 = (𝑛01 + 𝑛11) / (𝑛00 + 𝑛01 + 𝑛10 + 𝑛11)

Where:
* 𝜋𝑖 𝑖𝑠 𝑡h𝑒 𝑝𝑟𝑜𝑏𝑎𝑏𝑖𝑙𝑖𝑡𝑦 𝑜𝑓 𝑎𝑛 𝑒𝑥𝑐𝑒𝑝𝑡𝑖𝑜𝑛 𝑜𝑐𝑐𝑢𝑟𝑖𝑛𝑔 
* 𝑛𝑖𝑗 𝑖𝑠 𝑡h𝑒 𝑛𝑢𝑚𝑏𝑒𝑟 𝑜𝑓 𝑑𝑎𝑦𝑠 𝑤h𝑒𝑛 𝑗 𝑜𝑐𝑐𝑢𝑟𝑠 𝑐𝑜𝑛𝑑𝑖𝑡𝑖𝑜𝑛𝑎𝑙 𝑜𝑛 𝑖 𝑜𝑐𝑐𝑢𝑟𝑖𝑛𝑔 𝑡h𝑒 𝑝𝑟𝑒𝑣𝑖𝑜𝑢𝑠 𝑑𝑎𝑦 


The following test statistic is then given as:

 𝐿𝑅𝑖𝑛𝑑 = −2ln((((1 − 𝜋)^(𝑛00+ 𝑛10)) * ((𝜋^(𝑛01+𝑛11))/(((1−𝜋0)^𝑛00)*(𝜋0^𝑛01)*((1-𝜋1)^𝑛10)*(𝜋1^𝑛11))

Where: 
* 𝐿𝑅𝑖𝑛𝑑 𝑖𝑠 𝑡h𝑒 𝑡𝑒𝑠𝑡 𝑠𝑡𝑎𝑡𝑖𝑠𝑡𝑖𝑐
* 𝜋𝑖 𝑖𝑠 𝑡h𝑒 𝑝𝑟𝑜𝑏𝑎𝑏𝑖𝑙𝑖𝑡𝑦 𝑜𝑓 𝑎𝑛 𝑒𝑥𝑐𝑒𝑝𝑡𝑖𝑜𝑛 𝑜𝑐𝑐𝑢𝑟𝑖𝑛𝑔
* 𝑛𝑖𝑗𝑖𝑠 𝑡h𝑒 𝑛𝑢𝑚𝑏𝑒𝑟 𝑜𝑓 𝑑𝑎𝑦𝑠 𝑤h𝑒𝑛 𝑗 𝑜𝑐𝑐𝑢𝑟𝑠 𝑐𝑜𝑛𝑑𝑖𝑡𝑖𝑜𝑛𝑎𝑙 𝑜𝑛 𝑖 𝑜𝑐𝑐𝑢𝑟𝑖𝑛𝑔  𝑡h𝑒 𝑝𝑟𝑒𝑣𝑖𝑜𝑢𝑠 𝑑𝑎𝑦  

Finally, we combine the two test statistics and compare against the chi-squared distribution with two degrees of freedom. If the test statistic is less then the chi-squared value, then we accept the backtest as appropriate.

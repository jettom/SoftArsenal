# This simple script gathers data of stocks and uses it to simulate future price for
# 1 year (255 days). Then it optimises the portfolio for risk and returns using risk
# measures such as VaR
# 
# Note: tickers are all lower case, such as "aapl"

from scipy.special import ndtri
import matplotlib.pyplot as plt
import numpy as np
import itertools
import time
import math
import os

# Set chdir where the tickers lie
os.chdir(mypath)

# Get tickers as a list
stocks = os.listdir()

# Get data on stocks
file = open(mystockData,"r")
data = file.read()
file.close()
lines = data.split("\n")

# A dictionary containing raw data as a string for each stock
stocks_dictionary = dict()

# Previons for 255 days for each stock
prevision = dict()

# Correlation data
tickersCorr = []  # tickers
returnsCorr = []  # for correlation matrix

# Standard deviation dictionary
stdv = dict()

# Stocks average returns
meanReturns = dict()

# Stocks mu/stdv ratio
muStdvRatio = dict()

# Store data in dictionaries and run prevision of future prices
def runSimulation(ticker):

    mu = float(stocks_dictionary[ticker][0])
    sd = float(stocks_dictionary[ticker][1])

    try:
        # Storing initial price
        initialp = float(stocks_dictionary[ticker][2])
        # Calculating and storing standard deviation
        returnsData = np.array([float(i) for i in stocks_dictionary[ticker][3:-1]])
        sd = returnsData.std()
        stdv[ticker] = sd
        # Storing average returns
        meanReturns[ticker] = mu
        # Storing mu/stdv ratio
        muStdvRatio[ticker] = mu/sd
        
    except Exception as e:
        # In case initial price is not available, 100 is fixed as default
        initialp = 100
        print(initialp,ticker.upper(),"Exception: ",e)

    try:
        # Calculate correlation only for stocks with datapoints > 509 days
        if (len(stocks_dictionary[ticker])-2) >= 509:
            tickersCorr.append(ticker)
            returnsCorr.append(stocks_dictionary[ticker][3:505])
        else:
            pass
        
    except Exception as e:
        print("Exception triggered: ",e)
        
    # Run stock simulation for a year (255 days)
    prevision_price = []
    for t in range(255):
        try:
            n = np.random.normal(0,1,1)
            r = mu + n*sd
            price = initialp * math.pow(math.e,r)
            prevision_price.append(price)
            initialp = price
        except Exception as e:
            print("Exception triggered__2",e)
    prevision[ticker] = np.array(prevision_price)
    

def fillDicts():
    global tickersCorr, returnsCorr

    # Fill dictionaries with values
    for line in lines[1:]:
        try:
            lines_data = line.split(",")
            stocks_dictionary[lines_data[0]] = lines_data[1:]
        except Exception as e:
            print("Exception triggered",e)

    # Run simulation for each stock
    for stock in stocks_dictionary.keys():
        try:
            runSimulation(stock)
        except Exception as e:
            print("Exception triggered",e)

    # Convert returnsCorr into a numpy array
    returnsCorr = np.array(returnsCorr)


# This function builds a correlation matrix and if plott = True plots the heat-map
def correlationMatrix(plott = False):
    cmatrix = np.corrcoef(returnsCorr)
    if plott:
        plt.imshow(cmatrix,interpolation='nearest')
        plt.colorbar()
        plt.show()
        return cmatrix
    else:
        return cmatrix 
    
# This function plots price prediction for the last 20 stocks in the sample
def plotStocks(index=1,ticker=0,single=False):
    plt.style.use("ggplot")
    if single:
        ticker = ticker.lower()
        returns = [float(i) for i in stocks_dictionary[ticker][3:-1]]
        prev = prevision[ticker]
        plt.plot(returns,label=ticker)
        plt.plot(prev,label=ticker)
    else:
        for i in stocks[-index:]:
            try:
                plt.plot(prevision[i],label=i)
            except:
                pass
        plt.xlim([0,255])
    if index < 8 or single:
        plt.legend()
    plt.title("Stock price simulation")
    plt.show()


# This function builds the variance covariance matrix given a set of tickers (stocks)
def varCovarMatrix(stocksInPortfolio):
    cm = correlationMatrix()
    vcv = []
    for eachStock in stocksInPortfolio:
        row = []
        for ticker in stocksInPortfolio:
            if eachStock == ticker:
                variance = math.pow(stdv[ticker],2)
                row.append(variance)
            else:
                cov = stdv[ticker]*stdv[eachStock]* cm[tickersCorr.index(ticker)][tickersCorr.index(eachStock)]
                row.append(cov)
        vcv.append(row)

    vcvmat = np.mat(vcv)

    return vcvmat

# This function calculates Value at Risk for the given portfolio
def VaR(stocksInPortfolio,stocksExposure,confidenceAlpha,Print=False):
    alpha = ndtri(confidenceAlpha)
    # Stocks weighs in portfolio
    weight = (np.array(stocksExposure)/sum(stocksExposure))*100
    # VarianceCovariance matrix and exposure matrix
    vcvm = varCovarMatrix(stocksInPortfolio)
    vmat = np.mat(stocksExposure)
    # Variance of portfolio in euro/usd
    varianceRR = vmat * vcvm * vmat.T
    # Value at Risk (portfolio)
    var = alpha * np.sqrt(varianceRR)
    if Print:
        print("\nPortfolio total value: ",sum(stocksExposure))
        for s, v, w in zip(stocksInPortfolio,stocksExposure,weight):
            print(s.upper(),v,"usd/euro",round(w,2),"% of portfolio")
        print("VaR: @ "+str(confidenceAlpha*100)+"% confidence:",var,"euro/usd")
        print("VaR: "+str(var[0][0]/sum(stocksExposure)*100)+"% of portfolio value.")
    return var
    

# Calculates expected return for the portfolio
def portfolioExpectedReturn(stocksInPortfolio,stocksExposure,alpha=0.99,weightRisk=False,Print=False):
    weight = (np.array(stocksExposure)/sum(stocksExposure))

    returnsPortfolio = []
    for stock in stocksInPortfolio:
        returnsPortfolio.append(meanReturns[stock])

    returnsPortfolio = np.array(returnsPortfolio)
    # Dot product: elementwise moltiplication and then sum
    weightedReturn = weight.dot(returnsPortfolio)

    if weightRisk:
        varPortfolio = VaR(stocksInPortfolio,stocksExposure,alpha,Print=False)
        portfolioPercentage = varPortfolio/sum(stocksExposure)*100
        weightedRiskReturn = weightedReturn/portfolioPercentage

    if Print:
        print("\nPortfolio composition and expected returns (daily):")
        for s,r,w in zip(stocksInPortfolio,returnsPortfolio,weight):
            print(s.upper(),"expected return:",r*100,"%","weight",w*100,"%")
        print("Portfolio percentage weighted return:",weightedReturn*100,"%")
    if weightRisk and Print:
        print("Portfolio return risk weighted:",weightedRiskReturn*100,"%")
        return weightedRiskReturn

    return weightedReturn


# Optimizes portfolio for the most performing (returningwhise) stocks
def simple_optimise_return(n,portfolio=False,Print=False):
    avgReturns = meanReturns.copy()
    
    ticks = []
    returns = []

    for i in range(n):
        bigReturn = max(avgReturns.values())
        # >5% average daily return is usually an outlier or some kind of error in the data
        while (bigReturn*100) > 5:
            ticker = [key for key in avgReturns.keys() if avgReturns[key] == bigReturn][0]
            del avgReturns[ticker]
            bigReturn = max(avgReturns.values())
            
        ticker = [key for key in avgReturns.keys() if avgReturns[key] == bigReturn][0]
        ticks.append(ticker)
        returns.append(avgReturns[ticker])
        del avgReturns[ticker]

    if Print:
        print("\n")
        print("##########################################################")
        print("OPTIMISING FOR RETURN")
        print("Daily returns")
        for t,r in zip(ticks,returns):
            print(t.upper(),r*100,"%")

    if portfolio:
        amounts = [1000 for i in range(n)]
        VaR(ticks,amounts,0.99,Print=True)
        portfolioExpectedReturn(ticks,amounts,weightRisk=True,Print=True)
    
# Optimizes portfolio with n stocks for mu/stdv ratio.
# The greater the ratio, the better
def optimise_risk_return(n,portfolio,Print):
    muStdv = muStdvRatio.copy()

    ticks = []
    ratios = []

    k = 0
    while k < n:
        bigRatio = max(muStdv.values())
        ticker = [key for key in muStdv.keys() if muStdv[key] == bigRatio][0]
        # The data for these stocks seems to be corrupted so I delete it
        if ticker in ["spls","unm","pgr"]:
            del muStdv[ticker]
        else:
            ticks.append(ticker)
            ratios.append(muStdv[ticker])
            del muStdv[ticker]
            k += 1
    if Print:
        print("\n")
        print("##########################################################")
        print("OPTIMISING FOR RETURN/RISK")
        print("Avg return to stdv ratios (return for unit of risk):")
        for t,r in zip(ticks,ratios):
            print(t.upper(),r)
    if portfolio:
        amounts = [1000 for i in range(n)]
        VaR(ticks,amounts,0.99,Print=True)
        portfolioExpectedReturn(ticks,amounts,weightRisk=True,Print=True)

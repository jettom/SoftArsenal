#---------------------------------RUN THE PROGRAM------------------------------------
fillDicts()
# plotStocks(index=20)

# Testing the VaR function with a random portfolio of stocks
VaR(["aapl","aes","bks"],[10000,20000,25000],0.99,Print=True)

# Optimising
simple_optimise_return(10,portfolio=True,Print=True)
optimise_risk_return(10,portfolio=True,Print=True)
'''result
# >>> ================================ RESTART ================================
# >>> 
# 
# Portfolio total value:  55000
# AAPL 10000 usd/euro 18.18 % of portfolio
# AES 20000 usd/euro 36.36 % of portfolio
# BKS 25000 usd/euro 45.45 % of portfolio
# VaR: @ 99.0% confidence: [[ 2928.10001036]] euro/usd
# VaR: [[ 5.3238182]]% of portfolio value.
# 
# Portfolio composition and expected returns (daily):
# AAPL expected return: 0.163040987239 % weight 18.1818181818 %
# AES expected return: 0.0338781514838 % weight 36.3636363636 %
# BKS expected return: 0.0612855150617 % weight 45.4545454545 %
# Portfolio percentage weighted return: 0.0698201959747 %
# Portfolio return risk weighted: [[ 0.01311468]] %
# 
# 
# ##########################################################
# OPTIMISING FOR RETURN
# Daily returns
# ABBV 0.29866450622999996 %
# TSLA 0.263525046606 %
# NTRI 0.236777417156 %
# MNST 0.22788141423299998 %
# PCLN 0.20846570118 %
# ECYT 0.20556515452000002 %
# PETS 0.199334672597 %
# LIFE 0.197835842242 %
# NFLX 0.19741444376199999 %
# GMCR 0.189683647114 %
# 
# Portfolio total value:  10000
# ABBV 1000 usd/euro 10.0 % of portfolio
# TSLA 1000 usd/euro 10.0 % of portfolio
# NTRI 1000 usd/euro 10.0 % of portfolio
# MNST 1000 usd/euro 10.0 % of portfolio
# PCLN 1000 usd/euro 10.0 % of portfolio
# ECYT 1000 usd/euro 10.0 % of portfolio
# PETS 1000 usd/euro 10.0 % of portfolio
# LIFE 1000 usd/euro 10.0 % of portfolio
# NFLX 1000 usd/euro 10.0 % of portfolio
# GMCR 1000 usd/euro 10.0 % of portfolio
# VaR: @ 99.0% confidence: [[ 366.11836467]] euro/usd
# VaR: [[ 3.66118365]]% of portfolio value.
# 
# Portfolio composition and expected returns (daily):
# ABBV expected return: 0.29866450623 % weight 10.0 %
# TSLA expected return: 0.263525046606 % weight 10.0 %
# NTRI expected return: 0.236777417156 % weight 10.0 %
# MNST expected return: 0.227881414233 % weight 10.0 %
# PCLN expected return: 0.20846570118 % weight 10.0 %
# ECYT expected return: 0.20556515452 % weight 10.0 %
# PETS expected return: 0.199334672597 % weight 10.0 %
# LIFE expected return: 0.197835842242 % weight 10.0 %
# NFLX expected return: 0.197414443762 % weight 10.0 %
# GMCR expected return: 0.189683647114 % weight 10.0 %
# Portfolio percentage weighted return: 0.222514784564 %
# Portfolio return risk weighted: [[ 0.06077673]] %
# 
# 
# ##########################################################
# OPTIMISING FOR RETURN/RISK
# Avg return to stdv ratios (return for unit of risk):
# DLPH 0.11303676191
# PSX 0.0731996638171
# KRFT 0.0731795847888
# TSLA 0.0721904812827
# LYB 0.0704532407386
# MNST 0.0691306364895
# MA 0.0676123468044
# MJN 0.0673849545213
# AAPL 0.0655578125275
# DG 0.0626210193236
# 
# Portfolio total value:  10000
# DLPH 1000 usd/euro 10.0 % of portfolio
# PSX 1000 usd/euro 10.0 % of portfolio
# KRFT 1000 usd/euro 10.0 % of portfolio
# TSLA 1000 usd/euro 10.0 % of portfolio
# LYB 1000 usd/euro 10.0 % of portfolio
# MNST 1000 usd/euro 10.0 % of portfolio
# MA 1000 usd/euro 10.0 % of portfolio
# MJN 1000 usd/euro 10.0 % of portfolio
# AAPL 1000 usd/euro 10.0 % of portfolio
# DG 1000 usd/euro 10.0 % of portfolio
# VaR: @ 99.0% confidence: [[ 186.59653898]] euro/usd
# VaR: [[ 1.86596539]]% of portfolio value.
# 
# Portfolio composition and expected returns (daily):
# DLPH expected return: 0.173393787383 % weight 10.0 %
# PSX expected return: 0.134631079096 % weight 10.0 %
# KRFT expected return: 0.0798929650121 % weight 10.0 %
# TSLA expected return: 0.263525046606 % weight 10.0 %
# LYB expected return: 0.162308154081 % weight 10.0 %
# MNST expected return: 0.227881414233 % weight 10.0 %
# MA expected return: 0.165804553103 % weight 10.0 %
# MJN expected return: 0.110886753605 % weight 10.0 %
# AAPL expected return: 0.163040987239 % weight 10.0 %
# DG expected return: 0.101437112162 % weight 10.0 %
# Portfolio percentage weighted return: 0.158280185252 %
# Portfolio return risk weighted: [[ 0.08482482]] %
# >>> 
'''


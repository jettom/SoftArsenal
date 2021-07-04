'''
pip install pytrends
pip install apscheduler
'''

import os
import logging
import pandas as pd
import time
from function import *
from datetime import datetime, date, timedelta
from apscheduler.schedulers.blocking import BlockingScheduler
from pytrends.request import TrendReq

def google_trends():
    # ===获取目录
    root_path = os.path.abspath(os.path.dirname(__file__))
    # ===获取参数
    symbol_df = pd.read_csv(f'{root_path}/google_trends_keywords.csv')
    # ===获取实例
    pytrend = TrendReq(timeout=(10, 25), retries=10, backoff_factor=0.1)  # hl='en-US', tz=-480,
    for index, row in symbol_df.iterrows():
        symbol = row['symbol']
        keywords1 = row['keywords1']
        keywords2 = row['keywords2']
        kw = keywords1
        pytrend.build_payload([kw], timeframe='now 7-d')
        df = pytrend.interest_over_time()
        num = df[df[kw] > 50].count()
        if df.iloc[-2, 0] == 100:
            print(f'GoogleTrends100：{symbol} {kw} 大于50次数{num[kw]} {time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())}')
            send_dingding_msg(f'GoogleTrends100：{symbol} {kw} 大于50次数{num[kw]}')

if __name__ == '__main__':
    logging.basicConfig(filename="error.log", filemod...
from time import time
from datetime import datetime

def now() -> float:
    return time()

def today_start() -> float:
    now = datetime.fromtimestamp(time())
    return datetime(now.year, now.month, now.day).timestamp()

def yesterday_start() -> float:
    return today_start() - 86400
    
#! /usr/bin/env python
import urllib2
import json

COINDESK_API = 'https://api.coindesk.com/v1/bpi/currentprice/USD.json'
BLOCKCHAIN_API = 'https://blockchain.info/ticker'
BITCOINAVG_API = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD'
BITCOINCHARTS_API = 'http://api.bitcoincharts.com/v1/weighted_prices.json'

def coindesk():
    try:
        req = urllib2.Request(COINDESK_API)
        data = json.loads(urllib2.urlopen(req).read())
        price = data['bpi']['USD']['rate_float']
    except urllib2.HTTPError:
        price = -1

    return price, 'CD'

def blockchain():
    try:
        req = urllib2.Request(BLOCKCHAIN_API)
        data = json.loads(urllib2.urlopen(req).read())
        price = data['USD']['15m']
    except urllib2.HTTPError:
        price = -1

    return price, 'BC'

def bitcoin_avg():
    try:
        req = urllib2.Request(BITCOINAVG_API)
        data = json.loads(urllib2.urlopen(req).read())
        price = data['open']['hour']
    except urllib2.HTTPError:
        price = -1

    return price, 'BA'

def bitcoin_charts():
    try:
        req = urllib2.Request(BITCOINCHARTS_API)
        data = json.loads(urllib2.urlopen(req).read())
        price = data['USD']['7d']
    except urllib2.HTTPError:
        price = -1

    return price, 'BCH'

preferred_order = (coindesk, blockchain, bitcoin_avg, bitcoin_charts)

if __name__ == '__main__':
    import sys

    for api_func in preferred_order:
        price, src = api_func()
        if price > -1:
            break

    if len(sys.argv) > 1:
        try:
            value = price * float(sys.argv[1])
        except ValueError:
            sys.exit(1)
    else:
        value = price

    print '{:>8,.2f} {:>3}'.format(value, src)

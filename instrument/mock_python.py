#! /usr/bin/env python
import argparse
import logging
import time
import random
from prometheus_client import start_http_server, Gauge, Counter

parser = argparse.ArgumentParser()
parser.add_argument('-s', '--semester', default='unspecified')
parser.add_argument('-b', '--bind', default='0.0.0.0')
parser.add_argument('-p', '--port', default='9200')
parser.add_argument('-l', '--log', default='info', choices=['debug', 'info', 'warning'])

args = parser.parse_args()

# log config
logging.basicConfig(format='%(asctime)s: %(message)s')
logger = logging.getLogger("ExtractDeviceMetrics")
if args.log == "info":
    logger.setLevel(logging.INFO)
elif args.log == "debug":
    logger.setLevel(logging.DEBUG)
else:
    logger.setLevel(logging.WARNING)

# constants
run_interval = 20.0
label_set = [ "service", "semester" ]

def init_prom_metrics():
    metrics = { "gauges" : {}, "counters" : {}}

    metrics["gauges"]["random_gauge"] = Gauge(
                'opsschool_monitor_mock_random_current_count',
                'Number of current seconds',
                label_set)
    metrics["counters"]["random_counter"] = Counter(
                'opsschool_monitor_mock_random_total_count',
                'Number of total seconds',
                label_set)
    return metrics

# Main program code

# Start metrics exporter web server
logger.info("Exposing metrics on {0}:{1}".format(args.bind, args.port))
start_http_server(int(args.port), addr=args.bind)

# Initialize exported metrics struct
prom_metrics = init_prom_metrics()

while True:
    start_time = time.time()
    logger.debug('Woke up. Current run epoch minute: {0}.'.format(str(start_time // run_interval)))
    random_seconds = random.randint(1, run_interval)
    prom_metrics["gauges"]["random_gauge"].labels(service='opsschool_mock', semester=args.semester).set(random_seconds)
    prom_metrics["counters"]["random_counter"].labels(service='opsschool_mock', semester=args.semester).inc(random_seconds)
    
    # Sleep the for run interval minus how long it took to do calculations (to avoid time drift)
    time.sleep((run_interval) - ((time.time() - start_time) % (run_interval)))

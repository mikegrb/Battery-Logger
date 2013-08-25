Battery-Logger
==============

Inspired by a [blog post](http://www.ifweassume.com/2013/08/the-de-evolution-of-my-laptop-battery.html) and the code that goes with it at [jradavenport/batlog](https://github.com/jradavenport/batlog)

To use the script, add a cron job to your crontab:

    $ crontab -e

and enter this:

    * * * * * /path/to/your/repo/logger.pl /path/to/log/file

What's Logged?
--------------

The data file contains the following values, tab separated:

1. Timestamp, epoch format
1. Current Capacity (Charge)
1. Max Capacity (System Calculated Max Capacity)
1. Pcnt of Max Capacity Remaining (% Charge)
1. Cycle Count
1. Max Capacity / Design Capacity (Battery Health)
1. External Power Connected? (1/0)
1. Charging? (1/0)
1. Fully Charged? (1/0)
1. Internal Battery Temp (C)
1. Individual Cell Voltages (in mV)

What's the data look like?
--------------------------
```
1376806201	8292	8437	98.28	36	99.73	1	0	1	30.31	(4151,4151,4151,0)
1376806260	8292	8437	98.28	36	99.73	1	0	1	30.31	(4151,4151,4151,0)
```

How much space does the log take?
---------------------------------
The entries in the sample above are 67 bytes.  There are ~525,600 minutes in a year.  That's about 35 MB per year.  All entries might not be exactly 61 bytes
and some years have an extra 1,440 minutes so the end of year total will vary
a bit but it should be in that ball park.

Using the Data
--------------
A sample gnuplot script is included for creating graphs.

To create the graph, run the plot.sh script:

    /path/to/repo/plot.sh /path/to/log/file /path/to/graph.png

If your gnuplot isn't in cron's path, you can provide a custom path as the third argument:

    /path/to/repo/plot.sh /path/to/log/file /path/to/graph.png /path/to/gnuplot

Here is a sample produced with it:

![Sample Battery Graph](https://thegrebs.com/~michael/battery_health.png "Sample Battery Graph")


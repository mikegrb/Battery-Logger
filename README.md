Battery-Logger
==============

Inspired by a [blog post](http://www.ifweassume.com/2013/08/the-de-evolution-of-my-laptop-battery.html) and the code that goes with it at [jradavenport/batlog](https://github.com/jradavenport/batlog)

To use the script, edit line 8 specifing where to log the data:

```perl
my $datafile_path = '/Users/mgreb/Documents/data/battery.log';
```

Then add a cron job to your crontab:

    $ crontab -e

and enter this:

    * * * * * /path/to/your/repo/logger.pl

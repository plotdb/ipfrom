# @plotdb/ipfrom

A simple tool to determine if an ip address is from Taiwan.
While this repo is named as `@plotdb/ipfrom`, it only support determining taiwan IPs for now. This naming preserves future extensibility.


## Data Source

 - https://rms.twnic.tw/help_ipv4_assign.php
 - https://rms.twnic.tw/help_ipv6_assign.php

to fetch again, generate `table.ls` by running `tool/fetch` and move generated `table.ls` into `src/` folder.


## License

MIT

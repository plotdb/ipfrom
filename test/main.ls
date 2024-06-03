ipfrom = require '../dist/index.js'

ips = <[
  203.75.167.163
  192.168.1.108
  2001:b400:e294:8396:c59f:3389:fd86:a5ed
  2001:b400:e294:8396:b038:8847:8a7d:d642
  36.226.105.19
  ::ffff:36.226.105.19
  3001:b500:e294:8396:c59f:3389:fd86:a5ed
]>

ips.map (ip) -> console.log ip, ipfrom.taiwan(ip)

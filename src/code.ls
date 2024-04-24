ipfrom =
  taiwan: (ip = "") ->
    if typeof(ip) != \string => return false
    ip = ip.replace(/^::ffff:/, '')
    if /\d+\./.exec(ip) =>
      vs = ip.split('.')
      if o = iptable.ipv4.b[vs.0] =>
        if o.0 <= +vs.1 and o.1 >= +vs.1 => return true
      if o = (iptable.ipv4.c[vs.0] or {})[vs.1] =>
        if o.0 <= +vs.2 and o.1 >= +vs.2 => true else false
      return false
    ip = ip.split(/:/).filter(->it).map(->it.padStart(4,'0')).join('').toLowerCase!
    src = [parseInt(ip[i],16).toString(2).padStart(4,'0') for i from 0 til ip.length].join('')
    for j from 0 til iptable.ipv6.length =>
      [prefix, range] = iptable.ipv6[j]
      prefix = [parseInt(prefix[i],16).toString(2)padStart(4,'0') for i from 0 til prefix.length].join('')
        .substring(0,range - 1)
      if src.startsWith prefix => return true
    return false

if module? => module.exports = ipfrom
else if window => window.ldcover = ipfrom


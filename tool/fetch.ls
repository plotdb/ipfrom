require! <[jsdom node-fetch]>
fs = require "fs-extra"

lc = {ipv4: {b: {}, c: {}}}
node-fetch "https://rms.twnic.tw/help_ipv4_assign.php", {method: \GET}
  .then -> it.text!
  .then ->
    dom = new jsdom.JSDOM it
    document = dom.window.document
    list = Array.from(document.querySelectorAll "table.table tr")
    list = list
      .map (n) -> Array.from(n.querySelectorAll \td)
      .filter -> it and it.length
      .map (tds) ->
        name = tds.0.textContent
        date = tds.2.textContent
        range = tds.3.textContent.split(/\s*-\s*/)
        {name, date, range}
      .map -> it.range
    hash = lc.ipv4
    list.map (r) ->
      v = [r.0.split('.'), r.1.split('.')]
      if v.0.1 == v.1.1 => hash.c{}[v.0.0][v.0.1] = [+v.0.2, +v.1.2]
      else hash.b[v.0.0] = [+v.0.1, +v.1.1]
  .then -> node-fetch "https://rms.twnic.tw/help_ipv6_assign.php", {method: \GET}
  .then -> it.text!
  .then ->
    dom = new jsdom.JSDOM it
    document = dom.window.document
    list = Array.from(document.querySelectorAll "table.table tr")
    list = list
      .map (n) -> Array.from(n.querySelectorAll \td)
      .filter -> it and it.length
      .map (tds) ->
        name = tds.0.textContent
        date = tds.2.textContent
        range = tds.3.textContent
        bit = +tds.4.textContent
        {name, date, range, bit}
      .map -> [it.range.split(/:/g).filter(->it).map(->it.padStart(4,'0')).join('').toLowerCase!, it.bit]
    lc.ipv6 = list
  .then ->
    fs.write-file-sync "table.ls", """
    # this file is generated automatically by fetch.ls
    iptable = #{JSON.stringify(lc)};
    """


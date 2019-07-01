# 其他文件的引用
require "./part3_2"
require "date"
require "pp"

parrent = ARGV[0]
filename = ARGV[1]
simple_grep(/#{parrent}/, filename)

days = Date.today - Date.new(1993, 2, 24)
puts(days.to_i)

# pp 方法
v = [{
  key00: "key00",
  key01: "key01",
  key02: "key02",
  key03: "key02",
  key04: "key02",
  key05: "key02",
  key06: "key02",
  key07: "key02",
  key08: "key02",
  key09: "key02",
  key10: "key02",
}]

p v
pp v
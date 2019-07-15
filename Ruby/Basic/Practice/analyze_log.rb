# 分析access.log统计出每天, 每小时的访问量

require "date"
require "time"

FILE_NAME = ARGV[0]
ANALYZE_TYPE = ARGV[1]

def analyze_log(date_times)
  p "begin to analyze log"
  dts = []
  date_times.each do |dt|

    case ANALYZE_TYPE
    when "-h"
      dt = dt.strftime('%Y-%m-%d %H').to_s
    when "-d"
      dt = dt.strftime('%Y-%m-%d').to_s
    else
      p "Parameter error"
      exit
    end
    
    dts.push(dt)
  end
  result = count(dts)
  return result
end

def analyze_by_day(date_times)
  p "analyze_by_day"
end

def count(arr)
  hash = Hash.new(0)
  arr.each do |item|
    hash[item] += 1
  end
  return hash                            
end

begin
  start = Time.now.to_i
  io = File.open(FILE_NAME)                   # 打开文件
  ary = io.readlines
  date_times = []                             # 读取文件的每一行
  ary.each do |line|                          # 对 line 进行的操作
    data = line.split
    time = "#{data[3]} #{data[4]}".delete('[]')
    date_times.push(DateTime.strptime(time, "%d/%b/%Y:%H:%M:%S %z"))
  end

  result = analyze_log(date_times)

  result.each do |k, v|
    puts "Date Time: #{k} ---- #{v} times"
  end 

  stop = Time.now.to_i

  p "time cost #{stop - start} s"

rescue Errno::ENOENT, Errno::EACCES
  p "open file #{file} failed"
end
# Session 1 命令行输入数据
puts "The first parameter: #{ARGV[0]}"
puts "The second parameter: #{ARGV[1]}"
puts "The third parameter: #{ARGV[2]}"

# 输入的参数是字符串类型 想， 计算时需要转换成对应的数据类型
num1 = ARGV[0].to_i
num2 = ARGV[1].to_i
puts"#{ARGV[0]} + #{ARGV[1]} = #{num1 + num2}"



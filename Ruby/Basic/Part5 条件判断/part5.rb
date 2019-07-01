# Session 1 什么是条件判断

# Session 2 Ruby 中的条件
# 真      false、nil、以外所有的对象
# 假      true、nil

# Session 3 逻辑运算符
=begin
  1. condition1 && condition2
  2. condition1 || condition2
  3. !condition
=end

# Session 4 if语句
a = 10
b = 20

if a > b
  puts "a > b"
elsif a < b
  puts "a < b"
else
  puts "a = b"
end

# Session 5 unless 语句
unless a > b
  puts "a < b"
else
  puts "a > b"
end

# Session 6 case 语句
score = ARGV[0].to_i
case score
when score >= 60 && score <= 70
  puts "中"
when score > 70 && score <= 80
  puts "良"
when score > 80 && score <= 100
  puts "优"
else
  puts "差"
end

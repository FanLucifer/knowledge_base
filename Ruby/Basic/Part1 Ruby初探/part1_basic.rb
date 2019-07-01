# print
# 输出字符串
print("Hello Ruby.\n")
# \ 转义字符串
print("Hello \"Ruby\".\n")
# 单引号直接输出字符串内容
print('Hello \n"Ruby\".\n')

# print 的 () 可以省略
print 'a'

# 输出多个值用 "," 分割
print 'a', ' b',' c'

# puts
puts "Hello, Ruby."
# puts 方法会在字符串尾部自动加换行
puts "Hello,", " Ruby."
puts "100", 100

# p
# p 方法可以区别输出的是字符串还是数字
p "100", 100
# p 方法中输出 \n 等特殊字符时不会被转义
p 'hello\n'

# 输出中文时最好指定编码
p '鸟枪等我去东北'

# 输出一个变量
# 必须使用双引号
name = 'faye'
puts "my name is #{name}\n"

# 注释
# 单行注释
=begin

多行注释

=end

# 条件判断
# then 可以省略
num = 8
if  num >= 10 then
  print "bigger\n"
end

if num < 9 then
  puts "smaller\n"
end

if  num >= 10 then
  print "bigger\n"
else
  puts "smaller\n"
end

# 循环
while num <= 10
  p num
  num = num + 1
end

5.times do
  p 'a'
end

# Session 1 循环的基础

# Session 2 循环注意事项

# Session 3 实现循环的方法
=begin
    1. 使用循环语句
    2. 使用方法循环(6种)
        a. times 方法       qu
        b. each 方法
        c. loop 方法
        d. while 语句
        e. for 语句
        f. until 语句
=end

# Session 4 times 方法
5.times do |i|
    puts "第 #{i} 次循环"
end

# Session 5 for 语句
from = 1
to = 5
for j in from..to do
    puts "第 #{j} 次循环"
end

# Session 6 普通 for 语句
names = ['tom', 'jerry', 'amy']
for name in names
    puts name
end

# Session 7 while 语句
t = 0
while t <= names.size do
    puts t
    t = t + 1
end

# Session 8 until 语句
sum = 0
k = 1
until sum >= 50
    sum += k
    k += 1
end
puts sum

# Session 9 each 方法
add = 0
(1..5).each do |item|
add = add + item
end
puts add

# Session 10 loop 方法
# loop 方法没有终止循环条件需要跳出循环时要使用break

# loop do
#     print 'ruby'
# end

# Session 11 循环控制
=begin
    break       终止程序，跳出循环
    next        跳到下一次循环
    redo        在相同条件下重复循环
=end


a = 0
b = 0
c = 0
langs = ['Perl', 'Python', 'Ruby', 'Java']

puts "break\n"

# break
langs.each do |lang|
    a += 1
    if a == 3
        break
    end
    p [a, lang]
end

puts "next\n"

# next
langs.each do |lang|
    b += 1
    if b == 3
        next
    end
    p [b, lang]
end

puts "redo\n"

# redo
langs.each do |lang|
    c += 1
    if c == 3
        redo
    end
    p [c, lang]
end

# 补充
# do~end 与 {~}
#   循环的内容有多行时 使用 do~end
#   循环内容只有一行时使用 {~}

5.times{|x| puts x}
5.times do |y| puts y end
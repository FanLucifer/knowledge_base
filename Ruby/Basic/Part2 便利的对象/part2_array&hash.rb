# Session 1 Array
names = ['tom', 'jerry', 'amy']
puts "This first name is #{names[0]}\n"

names[3] = 'faye'
p names

# array.size 获取数组长度
puts "The length of array is #{names.size}\n"

# 数组的循环
names.each do |item|
  puts item
end


# Session 2 Hash
# 符号(symbol)
sym1 = :abc
sym2 = :"abc"
p sym1, sym2

# 字符串与符号转换
p sym1.to_s
p "test".to_sym

# 散列的创建
person = {
  :name => 'faye',
  :age => '24',
  :gender => 'female'
}

p person
p person[:name]
person[:tel] = "18621630019"
p person

# 循环
person.each do |key, value|
  puts "#{key}: #{value}"
end

# Session 3 Pattern
p /Ruby/ =~ "Ruby"
p /Ruby/ =~ "RUBY"
p /Ruby/i =~ "RUBY"

names.each do |name|
  if /amy/ =~ name
    puts name
  else
    puts 'pass'
  end
end
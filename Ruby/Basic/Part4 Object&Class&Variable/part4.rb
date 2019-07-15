# Session 1 Object

# Session 2 Class

# Session 3 Variable
=begin
  1.local variable
    e.g:
      name = 'faye'
      _num = 10
  2.global variable
    e.g:
      $global = 'faye'
  3.instance variable
    e.g:
      @instance
  4.class variable
    e.g:
      @@class
  5.pseudo variable(伪变量)
    伪变量是Ruby预先定义好的代表特定某值的变量即使在程序里给伪变量赋值，它们的值也不会改变
    e.g:
      nil, true, false, self
  6.Pre-define variable
    http://outofmemory.cn/code-snippet/39503/Predefined-Variables-list
=end

# Session 4 Const
=begin
对已经赋值常亮再次赋值时 Ruby 会做出警告
=end

TEST = 'test'
TEST = 'test again'

# Session 5 保留字
# https://ruby-china.org/topics/25613

# Session 6 多重赋值

a, b, c = 1, 2, 3 # a = 1, b = 2, c = 3
p "a=#{a}, b=#{b}, c=#{c}"

# 变量多于值，多余的变量值为nil
d, e, f, g = 4, 5 # d = 4, e = 5, f,g = nil
p "d=#{d}, e=#{e}, f=#{f}, g=#{g}"

# 变量少于值，多余的值被忽略
x, y = 1, 2, 3
p "x=#{x}, y=#{y}"

# 变量前加*， Ruby会将未分配的值封装为数组赋值给该变量
i, j, *k = 1, 2, 3, 4, 5
p "i=#{i}, j=#{j}, k=#{k}"

# 获取数组元素赋值
array = [1, [2, 3, 4], 5]
o, p, q = array
p "o=#{o}, p=#{p}, q=#{q}"

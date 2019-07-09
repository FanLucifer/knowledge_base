# Session 1 类是什么

array = [1, 2, 3]
str_abc = "abc"

# class 方法 获取对象属于哪个类
p array.class
p str_abc.class

# instance_of? 方法 判断对象是否属于目标类
p "array.instance_of?(Array): #{array.instance_of?(Array)}"
p "str_abc.instance_of?(String): #{str_abc.instance_of?(String)}"
p "array.instance_of?(String): #{array.instance_of?(String)}"

# 继承
=begin
  常见类的继承关系
  BasicObject
    |---Object
          |---Array
          |---string
          |---Hash
          |---Regexp
          |---IO
          |     |---Filr
          |
          |---Dir
          |---Numberic
          |     |---Integer
          |     |     |---Fixnum
          |     |     |---Bignum
          |     |---Float
          |     |---Complex
          |     |---Rational
          |---Exception
          |---Time
=end

# is_a? 方法 根据继承对象反向检查对象是否属于某个类
p "str_abc.is_a?(String): #{str_abc.is_a?(String)}"
p "str_abc.is_a?(Object): #{str_abc.is_a?(Object)}"
p "str_abc.instance_of?(Object): #{str_abc.is_a?(Object)}"

# Session 2 类的创建

class Person                          # class 关键字
  attr_accessor :name
  attr_accessor :age

  Version = "1.0"
  @@count = 0

  def initialize(myname = "Ruby", myage=18)     # init 方法
    @name = myname
    @age = myage
  end

  def say_hello                       # 实例方法
    @@count += 1
    puts "Hello world I am #{@name}"
  end

  def say_age
    year = self.age > 1 ? "years" : "year"
    puts "I am #{self.age} #{year} old"
  end

  def Person.get_count
    @@count
  end
end

faye = Person.new("Faye")
alice = Person.new("Alice", 10)
ruby = Person.new

faye.say_hello
alice.say_hello
ruby.say_hello

p faye.name
faye.name = 'Faye Fan'
p faye.name

# 存取器的定义
=begin
  以实例变量 @name 为例
  attr_reader :name               只读(定义了 name )
  attr_writer :name               只写(定义了name=方法)
  attr_accessor :name             读写(定义了以上两个方法)
=end

# 特殊变量self
alice.say_age
alice.age = 1
alice.say_age

# 常量
p Person::Version

# 类变量 @@变量名
p Person.get_count

# 限制方法的调用
=begin
  public              以实例方法的形式向外部公开的方法
  private             在指定接收者的情况下不能调用该方法
                      (只能使用缺省接收者的方式调用该方法， 无法从实例的外部访问)
  protected           在同一个类中时可将该方法作为实例方法调用
=end
class AccTest
  def pub
    puts "pub is a public method"
  end
  public :pub # 把pub 方法设定为public（可省略）

  def priv
    puts "priv is a private method"
  end
  private :priv # 把priv 方法设定为private
end

# 希望统一定义多个方法的访问级别时，可以使用下面的语法 :
class AccTest

  # 不指定参数时，
  # 以下的方法都被定义为public
  public
  def pub
    puts "pub is a public method."
  end

  # 以下的方法都被定义为 private
  private
  def priv
    puts "priv is a private method."
  end
end

# Session 3 扩展类

# 在原有类基础上添加方法
# Ruby 允许我们在已经定义好的类中添加方法。
# 下面，我们来试试给 String 类添加一个计算字符串单词数的实例方法 count_word

class String
  def count_word
    ary = self.split(/\s+/)     # 用空格分割接收者
    return ary.size             # 返回分割后的数组元素总数
  end
end

str = "Just Another Ruby Newbie"
p "str.count_word -> #{str.count_word}"

# 继承
=begin
我们可以在不对已有的类进行修改的前提下，通过增加新功能或重定义已有功能等手段来创建新的类。
定义继承时，在使用 class 关键字指定类名的同时指定父类名。
  class 类名< 父类名
    类定义
  end
创建一个继承了 Array 类的 RingArray 类。
RingArray 类只是重定义了读取数组内容时使用的 [] 运算符。
该程序通过 super 关键字调 用父类中同名的方法（在本例中也就是 Array#[]）。
=end

class RingArray < Array       # 创建 RingArray 继承 Array
  def [](i)                   # 重新定义运算符 []
    idx = i % size            # 计算新的索引值
    super(idx)                # 调用父类中的同名方法
  end
end

r_wday = RingArray["日", "月", "火", "水", "木", "金", "土"]
wday = Array["日", "月", "火", "水", "木", "金", "土"]

# 对 RingArray 类指定了超过数组长度的索引时，结果就会从溢出部分的开头开始重新计算索
p wday[6]                     #=> "土"
p r_wday[6]                   #=> "土"

p wday[11]                    #=> "nil"
p r_wday[11]                  #=> "木"

p wday[15]                    #=> "nil"
p r_wday[15]                  #=> "月"

p wday[-1]                    #=> "土"
p r_wday[-1]                  #=> "土"

# alias

=begin
  有时我们会希望给已经存在的方法设置别名。
  这种情况下就需要使用 alias 方法。
  alias 方法的参数为方法名或者符号名

    alias 别名 原名 # 直接使用方法名
    alias : 别名 : 原名 # 使用符号名

  像 Array#size 与 Array#length 这样，为同一种功能设置多个名称时，我们会使用到 alias。
  另外，除了为方法设置别名外，在重定义已经存在的方法时，为了能用别名调用原来的方法，
  我们也需要用到 alias。

  下面的例子中定义了类 C1 及其子类 C2。在类 C2 中，
  对 hello 方法设置别名 old_hello 后，重定义了 hello 方法。
=end

class C1
  def hello
    "Hello"
  end
end

class C2 < C1
  alias old_hello hello
    def hello
    "#{old_hello}, again"
  end
end

c2 = C2.new

p c2.hello
p c2.old_hello

# undef
=begin
  undef 用于删除已有方法的定义。与 alias 一样，参数可以指定方法名或者符号名。

    undef 方法名 # 直接使用方法名
    undef : 方法名 # 使用符号名

  例如，在子类中希望删除父类定义的方法时可以使用 undef。
=end

# Session 5 模块

# 创建模块
module HelloModule

  VERSION = 1.0

  def hello(name)
    p "hello, #{name}"
  end

  module_function :hello
end

p HelloModule::VERSION
HelloModule.hello('faye')

include HelloModule
p VERSION
hello('faye')


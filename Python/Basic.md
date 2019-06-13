# Python Basic knowledge

- 简介:

  **Python**是一种广泛使用的[高级编程语言](https://zh.wikipedia.org/wiki/%E9%AB%98%E7%BA%A7%E8%AF%AD%E8%A8%80 "高级语言")，属于[通用型编程语言](https://zh.wikipedia.org/wiki/%E9%80%9A%E7%94%A8%E7%BC%96%E7%A8%8B%E8%AF%AD%E8%A8%80 "通用编程语言")，由[吉多·范罗苏姆](https://zh.wikipedia.org/wiki/%E5%90%89%E5%A4%9A%C2%B7%E8%8C%83%E7%BD%97%E8%8B%8F%E5%A7%86 "吉多·范罗苏姆")创造，第一版发布于1991年。可以视之为一种改良（加入一些其他编程语言的优点，如面向对象）的[LISP](https://zh.wikipedia.org/wiki/LISP "LISP")。作为一种[解释型语言](https://zh.wikipedia.org/wiki/%E7%9B%B4%E8%AD%AF%E8%AA%9E%E8%A8%80)，Python的设计哲学强调代码的[可读性](https://zh.wikipedia.org/wiki/%E5%8F%AF%E8%AF%BB%E6%80%A7 "可读性")和简洁的语法（尤其是使用[空格缩进](https://zh.wikipedia.org/wiki/%E8%B6%8A%E4%BD%8D%E8%A7%84%E5%88%99 "越位规则")划分代码块，而非使用大括号或者关键词）。相比于C++或Java，Python让开发者能够用更少的代码表达想法。不管是小型还是大型程序，该语言都试图让程序的结构清晰明了。

  与[Scheme](https://zh.wikipedia.org/wiki/Scheme "Scheme")、[Ruby](https://zh.wikipedia.org/wiki/Ruby "Ruby")、[Perl](https://zh.wikipedia.org/wiki/Perl "Perl")、[Tcl](https://zh.wikipedia.org/wiki/Tcl "Tcl")等动态类型编程语言一样，Python拥有[动态类型系统](https://zh.wikipedia.org/wiki/%E9%A1%9E%E5%9E%8B%E7%B3%BB%E7%B5%B1 "类型系统")和[垃圾回收](https://zh.wikipedia.org/wiki/%E5%9E%83%E5%9C%BE%E5%9B%9E%E6%94%B6_(%E8%A8%88%E7%AE%97%E6%A9%9F%E7%A7%91%E5%AD%B8) "垃圾回收 (计算机科学)")功能，能够自动管理内存使用，并且支持多种编程范式，包括面向对象、命令式、函数式和过程式编程。其本身拥有一个巨大而广泛的标准库。

- 数据类型:

  - Python3 中有六个标准的数据类型:
    - Number（数字）
      Python3 支持 int  float  bool  complex（复数）

      ```python
      a = 20            #int
      b = 5.5           #float
      c = True          #bool
      d = 4+3j          #complex
      ```

     1. 在 Python2 中是没有布尔型的，它用数字 0 表示 False，用 1 表示 True。到 Python3 中，把 True 和False 定义成关键字了，但它们的值还是 1 和 0，它们可以和数字相加。

     2. Python可以同时为多个变量赋值，如a, b = 1, 2

     3. 一个变量可以通过赋值指向不同类型的对象。

     4. 数值的除法包含两个运算符：/返回一个浮点数，//返回一个整数。

     5. 在混合计算时，Python会把整型转换成为浮点数。

    - String（字符串）

      Python中的字符串用单引号'或双引号"括起来，同时使用反斜杠\转义特殊字符。

      ```python
      str = 'Runoob'
      # 加号 + 是字符串的连接符， 星号 * 表示复制当前字符串，紧跟的数字为复制的次数。

      print (str)          # 输出字符串
      print (str[0:-1])    # 输出第一个到倒数第二个的所有字符
      print (str[0])       # 输出字符串第一个字符
      print (str[2:5])     # 输出从第三个开始到第五个的字符
      print (str[2:])      # 输出从第三个开始的后的所有字符
      print (str * 2)      # 输出字符串两次
      print (str + "TEST") # 连接字符串
      ```

     1. 字符串的截取的语法格式如下:

        > 变量[头下标:尾下标]

        ![字符串的截取](http://www.runoob.com/wp-content/uploads/2013/11/o99aU.png)

        Python中的字符串有两种索引方式，从左往右以0开始，从右往左以-1开始。

     2. Python 使用反斜杠(\)转义特殊字符，不让反斜杠发生转义，可以在字符串前面添加一个 r，表示原始字符串

    - List（列表）

      List（列表） 是 Python 中使用最频繁的数据类型。列表可以完成大多数集合类的数据结构实现。列表中元素的类型可以不相同，它支持数字，字符也包含列表（嵌套）。

      列表是写在方括号[ ]之间、用逗号分隔开的元素列表。

      ```python
      list = [ 'abcd', 786 , 2.23, 'runoob', 70.2 ]
      tinylist = [123, 'runoob']

      print (list)            # 输出完整列表    ['abcd', 786, 2.23, 'runoob', 70.2]
      print (list[0])         # 输出列表第一个元素    'abcd'

      print (list[1:3])       # 从第二个开始输出到第三个元素    [786, 2.23]
      print (list[2:])        # 输出从第三个元素开始的所有元素    [ 2.23, 'runoob', 70.2 ]

      print (tinylist * 2)    # 输出两次列表    [123, 'runoob', 123, 'runoob']
      print (list + tinylist) # 连接列表    ['abcd', 786, 2.23, 'runoob', 70.2, 123,'runoob']

      # 与Python字符串不一样的是，列表中的元素是可以改变的：
      a = [1, 2, 3, 4, 5, 6]

      a[0] = 9                    # [9, 2, 3, 4, 5, 6]

      a[2:5] = [13, 14, 15]       # [9, 2, 13, 14, 15, 6]

      a[2:5] = []                 # 将对应的元素值设置为 [] [9, 2, 6]
      ```

    1. 和字符串一样，列表同样可以被索引和截取，列表被截取后返回一个包含所需元素的新列表。

         列表截取的语法格式如下：

        >变量[头下标:尾下标]

          索引值以 0 为开始值，-1 为从末尾的开始位置。

          ![列表截取](http://www.runoob.com/wp-content/uploads/2013/11/list_slicing1.png)

    2. 加号+是列表连接运算符，星号*是重复操作

    3. Python 列表截取可以接收第三个参数，参数作用是截取的步长，以下实例在索引 1 到索引 4 的位置并设置为步长为 2（间隔一个位置）来截取字符串：

          ![列表截取](http://www.runoob.com/wp-content/uploads/2013/11/python_list_slice_2.png)

    - Tuple（元组）

      元组的元素不能修改。元组写在小括号()里，元素之间用逗号隔开。元组中的元素类型可以不相同

      ```python

      tuple = ('abcd', 786 , 2.23, 'runoob', 70.2 )

      tinytuple = (123, 'runoob')

      print (tuple)             # 输出完整元组 ('abcd', 786 , 2.23, 'runoob', 70.2)

      print (tuple[0])          # 输出元组的第一个元素 'abcd'

      print (tuple[1:3])        # 输出从第二个元素开始到第三个元素 (786 , 2.23)

      print (tuple[2:])         # 输出从第三个元素开始的所有元素 (2.23, 'runoob', 70.2)

      print (tinytuple * 2)     # 输出两次元组 (123, 'runoob',123, 'runoob')

      print (tuple + tinytuple) # 连接元组 ('abcd', 786, 2.23, 'runoob', 70.2, 123, 'runoob')

      tup = (1, 2, 3, 4, 5, 6)

      tup[0])          # 1

      tup[1:5]         # (2, 3, 4, 5)

      tup[0] = 11      # 修改元组元素的操作是非法的

      # TypeError: 'tuple' object does not support item assignment

      # 构造包含 0 个或 1 个元素的元组比较特殊

      tup1 = ()        # 空元组
      tup2 = (20,)     # 一个元素，需要在元素后添加逗号
      ```

    1. 元组可以被索引且下标索引从0开始，-1 为从末尾开始的位置，也可以进行截取。可以把字符串看作一种特殊的元组。

    2. string、list 和 tuple 都属于 sequence（序列）

    3. 元组中的元素值是不允许删除的，但可以使用del语句删除整个元组

        ```python
        tup = ('Google', 'Runoob', 1997, 2000)

        print (tup)
        del tup;
        ```

    - Set（集合）

      集合（set）是由一个或数个形态各异的大小整体组成的，构成集合的事物或对象称作元素或是成员。基本功能是进行成员关系测试和删除重复元素。可以使用大括号{ }或者set()函数创建集合

      ```python

      # 创建集合

      parame = {value01,value02,...}

      set(value)

      # 基本操作

      student = {'Tom', 'Jim', 'Mary', 'Tom', 'Jack', 'Rose'}

      print(student)   # 输出集合，重复的元素被自动去掉

      # 成员测试
      if 'Rose' in student :
          print('Rose 在集合中')
      else :
          print('Rose 不在集合中')

      # 进行集合运算

      a = set('abracadabra')
      b = set('alacazam')

      print(a)         # 输出集合a        {'b', 'a', 'c', 'r', 'd'}

      print(a - b)     # a 和 b 的差集    {'b', 'd', 'r'}

      print(a | b)     # a 和 b 的并集    {'l', 'r', 'a', 'c', 'z', 'm', 'b', 'd'}
      print(a & b)     # a 和 b 的交集    {'a', 'c'}

      print(a ^ b)     # a 和 b 中不同时存在的元素    {'l', 'r', 'z', 'm', 'b', 'd'}
      ```

      创建一个空集合必须用set()而不是{ }，{} 是用来创建一个空字典

    - Dictionary（字典）

      字典是一种映射类型，字典用{ }标识，它是一个无序的**键(key) : 值(value)**的集合。键(key)必须使用**不可变**类型。在同一个字典中，键(key)必须是**唯一**的。

      ```python
      dict = {}
      dict['one'] = "test1"

      dict[2]     = "test2"


      tinydict = {'name': 'runoob','code':1, 'site': 'www.runoob.com'}

      print (dict['one'])       # 输出键为 'one' 的值   test1

      print (dict[2])           # 输出键为 2 的值    test2

      print (tinydict)          # 输出完整的字典
                                # {'name': 'runoob', 'code': 1, 'site': 'www.runoob.com'}
      print (tinydict.keys())   # 输出所有键    dict_keys(['name', 'code', 'site'])

      print (tinydict.values()) # 输出所有值    dict_values(['runoob', 1, 'www.runoob.com'])

      # 构造函数 dict() 可以直接从键值对序列中构建字典如下：

      dict([('Runoob', 1), ('Google', 2), ('Taobao', 3)])
      # {'Taobao': 3, 'Runoob': 1, 'Google': 2}

      dict{x: x**2 for x in (2, 4, 6)}
      # {2: 4, 4: 16, 6: 36}

      dict(Runoob=1, Google=2, Taobao=3)
      {'Runoob': 1, 'Google': 2, 'Taobao': 3}
      ```

    1. 字典的关键字必须为不可变类型，且不能重复
    2. 创建空字典使用 { }

- Python数据类型转换:

  | 函数                                                                              | 描述                              |
  | ------------------------------------------------------------------------------- | ------------------------------- |
  | [int(x [,base])](http://www.runoob.com/python3/python-func-int.html)            | 将x转换为一个整数                       |
  | [float(x)](http://www.runoob.com/python3/python-func-float.html)                | 将x转换到一个浮点数                      |
  | [complex(real [,imag])](http://www.runoob.com/python3/python-func-complex.html) | 创建一个复数                          |
  | [str(x)](http://www.runoob.com/python3/python-func-str.html)                    | 将对象 x 转换为字符串                    |
  | [repr(x)](http://www.runoob.com/python3/python-func-repr.html)                  | 将对象 x 转换为表达式字符串                 |
  | [eval(str)](http://www.runoob.com/python3/python-func-eval.html)                | 用来计算在字符串中的有效Python表达式,并返回一个对象   |
  | [tuple(s)](http://www.runoob.com/python3/python3-func-tuple.html)               | 将序列 s 转换为一个元组                   |
  | [list(s)](http://www.runoob.com/python3/python3-att-list-list.html)             | 将序列 s 转换为一个列表                   |
  | [set(s)](http://www.runoob.com/python3/python-func-set.html)                    | 转换为可变集合                         |
  | [dict(d)](http://www.runoob.com/python3/python-func-dict.html)                  | 创建一个字典。d 必须是一个序列 (key,value)元组。 |
  | [frozenset(s)](http://www.runoob.com/python3/python-func-frozenset.html)        | 转换为不可变集合                        |
  | [chr(x)](http://www.runoob.com/python3/python-func-chr.html)                    | 将一个整数转换为一个字符                    |
  | [ord(x)](http://www.runoob.com/python3/python-func-ord.html)                    | 将一个字符转换为它的整数值                   |
  | [hex(x)](http://www.runoob.com/python3/python-func-hex.html)                    | 将一个整数转换为一个十六进制字符串               |
  | [oct(x)](http://www.runoob.com/python3/python-func-oct.html)                    | 将一个整数转换为一个八进制字符串                |

- Python3 的六个标准数据类型中:

  - 不可变数据: Number String Tuple

  - 可变数据: List Dictionary Set

- 判断变量类型的两种方式isinstance 和 type

  isinstance 和 type 的区别在于:

  - type()不会认为子类是一种父类类型。

  - isinstance()会认为子类是一种父类类型。

  - type 是用于求一个未知数据类型对象，而 isinstance 是用于判断一个对象是否是已知类型

- 流程控制:

  在 Python 中有三种控制流语句: `if` `for`和`while`

  - 条件控制:

    `if`语句用以检查条件：如果条件为真（True），将运行一块语句（称作if-block或if 块），否则将运行另一块语句（称作else-block或else 块）。其中else从句是可选的。

    ```python
    if condition_1:
        statement_block_1
    elif condition_2:
        statement_block_2
    else:
        statement_block_3
    ```

  1. Python 中不存在`switch`语句。但可以通过使用`if..elif..else`语句来实现同样的事情（在某些情况下，使用字典能够更快速地完成）。

  2. python中没有其他语言中的三元表达式，但是有类似的实现方法

     ```python
        x = 值1 if 条件 else 值2
        #如果条件成立，把值1赋值给x,如果条件不成立，就把值2赋值给x
        ```

  - 循环语句:
    - `while`语句

      `while`能够让你在条件为真的前提下重复执行某块语句。`while`语句是循环（Looping）语句的一种。`while`语句同样可以拥有`else`子句作为可选选项。

      ```python
      # 猜数
      number = 23
      running = True

      while running:
          guess = int(input('Enter an integer : '))
          if guess == number:
              print('Congratulations, you guessed it.')
              running = False    # 猜中终止 while 循环
          elif guess < number:
              print('No, it is a little higher than that.')
          else:
              print('No, it is a little lower than that.')
      else:
          print('The while loop is over.')
      ```

    - `for`循环

      `for...in`语句是另一种循环语句，其特点是会在一系列对象上进行迭代（Iterates），即它会遍历序列中的每一个元素

      ```python
      # 输出数字1-5
      for i in range(1, 5):
          print(i)
      else:
          print('The for loop is over')
      ```

    - `break`语句

      `break`语句用以中断（Break）循环语句，也就是中止循环语句的执行，即使循环条件没有变更为`False`或者迭代尚未完成。

      有一点需要尤其注意，如果中断了一个`for`或`while`循环，任何相应循环中的`else`块都不会执行。

      ```python
      while True:
         s = input('Enter something : ')
         if s == 'quit':
             break
         print('Length of the string is', len(s))
      print('Done')
      ```

    - `continue`语句

      `continue`语句用以告诉 Python 跳过当前循环中的剩余语句，直接进行该循环的下一次迭代。

      ```python
      while True:
          s = input('Enter something : ')
          if s == 'quit':
              break
          if len(s) < 3:
              print('Too small')
              continue
          print('Input is of sufficient length')
      ```

- 函数:

  函数是组织好的，可重复使用的，用来实现单一，或相关联功能的代码段。函数能提高应用的模块性，和代码的重复利用率。

  - 定义一个函数

    ```python
    # 打印两个数中较大的
    def print_max(a, b):
       if a > b:
           print(a, 'is maximum')
       elif a == b:
           print(a, 'is equal to', b)
       else:
           print(b, 'is maximum')
    ```

    > 1. 函数代码块以**def**关键词开头，后接函数标识符名称和圆括号**()**。
    >
    > 2. 任何传入参数和自变量必须放在圆括号中间，圆括号之间可以用于定义参数。
    >
    > 3. 函数的第一行语句可以选择性地使用文档字符串—用于存放函数说明。
    >
    > 4. 函数内容以冒号起始，并且缩进。
    >
    > 5. return**表达式结束函数，选择性地返回一个值给调用方。不带表达式的return相当于返回 None。

  - 参数

    函数可以获取参数，这个参数的值调用时传入，函数便可以利用这些值来做一些事情。这些参数与变量类似，这些变量的值在调用函数时已被定义，且在函数运行时赋值。

    函数中的参数通过将其放置在用以定义函数的一对圆括号中指定，并通过逗号予以分隔。调用函数时，以同样的形式提供需要的值。在定义函数时给定的名称称作“形参”（Parameters），在调用函数时你所提供给函数的值称作“实参”（Arguments）。

    - 必需参数

      必需参数须以正确的顺序传入函数。调用时的数量必须和声明时的一样。

    - 关键字参数

      如果有一个具有许多参数的函数，而又希望只对其中的一些进行指定，可以通过命名它们来给这些参数赋值—这就是关键字参数（Keyword Arguments),我们使用命名关键字而非位置来指定函数中的参数。

      ```python
      def func(a, b=5, c=10):
      print('a is', a, 'and b is', b, 'and c is', c)
      func(3, 7)
      func(25, c=24)
      func(c=50, a=100)
      ```

      这样做有两大优点:
      1. 不需要考虑参数的顺序，函数的使用将更加容易。
      2. 可以只对那些希望赋予的参数以赋值，只要其它的参数都具有默认参数值。

    - 默认参数

      默认参数为一些参数提供可选并使用默认的值，以避免用户不想为他们提供值的情况，在函数定义时通过附加一个赋值运算符（`=`）来为参数指定默认参数值。默认参数值应该是常数。更确切地说，默认参数值应该是不可变的

      ```python
      def say(message, times=1):
         print(message * times)
      say('Hello')
      say('World', 5)
      ```

       只有那些位于参数列表末尾的参数才能被赋予默认参数值，即在函数的参数列表中拥有默认参数值的

      参数不能位于没有默认参数值的参数之前。
      这是因为值是按参数所处的位置依次分配的。

      举例来说，`def func(a, b=5)`是有效的，但`def func(a=5, b)`是*无效的*。

    - 不定长参数

      定义的函数里面能够有*任意*数量的变量，也就是参数数量是可变的，这可以通过使用星号来实现

      ```python
      def total(a=5, *numbers, **phonebook):
         print('a', a)

         #遍历元组中的所有项目
         for single_item in numbers:
             print('single_item', single_item)

         #遍历字典中的所有项目
         for first_part, second_part in phonebook.items():
             print(first_part,second_part)

      print(total(10,1,2,3,Jack=1123,John=2231,Inge=1560))
      ```

     1. 加了星号*的参数会以**元组(tuple**)的形式导入，存放所有未命名的变量参数。

     2. 加了两个星号\**的参数会以**字典**的形式导入。

     3. 声明函数时，参数中星号\*可以单独出现，如果单独出现星号*后的参数必须用关键字传入,例如:

          ```python
          def f(a,b,*,c):
              return a+b+c

          f(1,2,3)
          # 报错 TypeError: f() takes 2 positional arguments but 3 were given

          f(1,2,c=3) # 正
          ```

    - 匿名函数

      python 使用 lambda 来创建匿名函数。

      所谓匿名，意即不再使用 def 语句这样标准的形式定义一个函数。

      ```python
      lambda [arg1 [,arg2,.....argn]]:expression

      # 可写函数说明
      sum = lambda arg1, arg2: arg1 + arg2

      # 调用sum函数
      print ("相加后的值为 : ", sum( 10, 20 ))
      print ("相加后的值为 : ", sum( 20, 20 ))
      ```

     1. lambda 只是一个表达式，函数体比 def 简单很多。

     2. lambda的主体是一个表达式，而不是一个代码块。仅仅能在lambda表达式中封装有限的逻辑进去。

     3. lambda 函数拥有自己的命名空间，且不能访问自己参数列表之外或全局命名空间里的参数。

     4. 虽然lambda函数看起来只能写一行，却不等同于C或C++的内联函数，后者的目的是调用小函数时不占用栈内存从而增加运行效率。

- [文件操作](https://docs.python.org/zh-cn/3/tutorial/inputoutput.html#reading-and-writing-files)

- 错误和异常:

  - 语法错误

    Python 的语法错误或者称之为解析错，初学者最容易遇到的错误

    ```python
    while True print('Hello world')

      File "<stdin>", line 1, in ?
        while True print('Hello world')
                       ^
    SyntaxError: invalid syntax
    ```

     这个例子中，函数 print() 被检查到有错误，是它前面缺少了一个冒号（:）。

     语法分析器指出了出错的一行，并且在最先找到的错误的位置标记了一个小小的箭头。

  - 异常

    即便Python程序的语法是正确的，在运行它的时候，也有可能发生错误。运行期检测到的错误被称为异常。

    大多数的异常都不会被程序处理，此时会显示如下所示的错误信息:

    ```python
    >>> 10 * (1/0)
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    ZeroDivisionError: division by zero
    >>> 4 + spam*3
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    NameError: name 'spam' is not defined
    >>> '2' + 2
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: Can't convert 'int' object to str implicitly
    ```

     异常以不同的类型出现，这些类型都作为信息的一部分打印出来: 例子中的类型有 ZeroDivisionError，NameError 和 TypeError。

     错误信息的前面部分显示了异常发生的上下文，并以调用栈的形式显示具体信息

  - 异常处理

    可以编写处理所选异常的程序。请看下面的例子，它会要求用户一直输入，直到输入的是一个有效的整数，但允许用户中断程序(使用 Control-C 或操作系统支持的其他操作),用户引起的中断可以通过引发 KeyboardInterrupt 异常来指示。

    ```python
    >>>

    >>> while True:
    ...     try:
    ...         x = int(input("Please enter a number: "))
    ...         break
    ...     except ValueError:
    ...         print("Oops!  That was no valid number.  Try again...")
    ...
    ```

     1. 先执行 try 子句 （try 和 except 关键字之间的语句）

     2. 如果没有异常发生，则跳过 except 子句 并完成 try 语句的执行。

     3. 如果在执行try 子句时发生了异常，则跳过该子句中剩下的部分。如果异常的类型和 except 关键字后面的异常匹配，则执行 except 子句 ，然后继续执行 try 语句之后的代码。

     4. 如果发生的异常和 except 子句中指定的异常不匹配，则将其传递到外部的 try 语句中；如果没有找到处理程序，则它是一个 未处理异常，执行将停止并显示如上所示的消息。

     5. 一个try语句可能有多个 except 子句，以指定不同异常的处理程序。 最多会执行一个处理程序。 处理程序只处理相应的 try 子句中发生的异常，而不处理同一try语句内其他处理程序中的异常。 一个 except 子句可以将多个异常命名为带括号的元组

        ```python
        except (RuntimeError, TypeError, NameError):
            pass
        ```

     6. try...except语句有一个可选的else 子句，在使用时必须放在所有的 except 子句后面。对于在try 子句不引发异常时必须执行的代码来说很有用。

        ```python
        for arg in sys.argv[1:]:
            try:
                f = open(arg, 'r')
            except OSError:
                print('cannot open', arg)
            else:
                print(arg, 'has', len(f.readlines()), 'lines')
                f.close()
        ```

        使用else子句比向try子句添加额外的代码要好，因为它避免了意外捕获由try...except语句保护的代码未引发的异常。

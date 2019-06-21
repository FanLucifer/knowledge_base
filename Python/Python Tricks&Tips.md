#

参考资料

- [PEP 263](https://www.python.org/dev/peps/pep-0263/)
- [Python Tricks](https://www.freecodecamp.org/news/an-a-z-of-useful-python-tricks-b467524ee747/)
- [Python 技巧](https://www.cnblogs.com/Lands-ljk/p/5746837.html)
- [The Meaning of Underscores in Python](https://dbader.org/blog/meaning-of-underscores-in-python)

## 1. 指定脚本解释器

  > `#!/usr/bin/python`

  这是脚本语言共同遵守的规则：

  第一行注释为 `#!/path/to/script/interprete`，告诉Linux/OS X系统, 用什么解释器运行脚本以及解释器所在的位置, Windows系统会忽略这个注释.

  注意：

  1. 必须是文件的第一行
  2. 必须以`#!`开头
  3. `/path/to/script/interpreter`是脚本解释器的全路径名。

  例如：

- `#!/bin/sh`           shell脚本
- `#!/usr/bin/perl`     perl脚本
- `#!/usr/bin/python3`  python3脚本
- `#!/usr/bin/python2`  python2脚本

## 2. 指定脚本编码

> `# -*- coding: <encoding name> -*-`

或者

> `# coding=<encoding name>`

或者

>`# vim: set fileencoding=<encoding name> :`

更准确地说，是必须匹配以下正则表达式:

> `^[ \t\f]*#.*?coding[:=][ \t]*([-_.a-zA-Z0-9]+)`

第二行注释是为了告诉Python解释器，按照何种编码读取源代码，否则，在源代码中写的中文输出可能会有乱码, 没有编码注释，Python的解析器将为假设ASCII文本。

## 3. Python 技巧和提示

- `all` 和 `any`

  ```python
  x = [True, True, False]
  if any(x):
      print("At least one True")
  if all(x):
      print("Not one False")
  if any(x) and not all(x):
      print("At least one True and one False")
  ```

- `bashplotlib`

  > `pip install bashplotlib`

  使用`bashplotlib`可以帮助你在控制台输出图形

- `collections`

  `Python` 默认数据类型不能满足需求时可以使用 `Python` 标准库提供的`collection`模块。它可以提供更多的数据类型。

  ```python
  from collections import OrderedDict, Counter
  # Remembers the order the keys are added!
  x = OrderedDict(a=1, b=2, c=3)
  # Counts the frequency of each character
  y = Counter("Hello World!")
  ```

- `dir`
  查看Python对象的属性

  ```python

  # 声明一个Question类
  class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('发布日期')

  >>> q1 = Question.objects.get(id=1)
  >>> q1

  # 直接输 q1 只能看到对象类型
  <Question: Question object (1)>

  # 使用 dir()输出 q1 获得 q1 的属性列表
  >>> dir(q1)

  [
    ...
    'id',
    'objects',
    'pk',
    'prepare_database_save',
    'pub_date',
    'question_text'
    ...
    ]
  ```

  想要直接获得 q1 对象的属性和值, 更推荐重写 `__str__` 方法

  将 Question 类改写：

  ```python
  class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('发布日期')

    def __str__(self):
        question = {
            'id': self.id,
            'text': self.question_text,
            'date': self.pub_date.strftime("%Y-%m-%d")
        }

        return str(question)

  >>> from polls.models import Question
  >>> q1 = Question.objects.get(id=1)
  >>> q1
  <Question: {'id': 1, 'text': "What's new?", 'date': '2019-04-11'}>
  ```

- `emoji`
  >`pip install emoji`

  `emoji` 的 `Python` 包。除了系列别名之外，还支持由unicode联盟定义的整套表情符号代码。 默认情况下，仅启用正式列表，执行`emoji.emojize(use_aliases = True)`可启用完整列表和别名

  ```python
  >> import emoji
  >> print(emoji.emojize('Python is :thumbs_up:'))
  Python is 👍
  >> print(emoji.emojize('Python is :thumbsup:', use_aliases=True))
  Python is 👍
  >> print(emoji.demojize('Python is 👍'))
  Python is :thumbs_up:
  ```

- `from __future__ import`

  `Python` 的版本更新非常快，新的版本往往会有很多新特性。如果不更新，就无法使用。

  但是 `__future__` 模块可以让导入未来版本的功能。

  ```python
  from __future__ import print_function
  print("Hello World!")
  ```

  另外多个版本 `Python` 共存推荐使用 `Pyenv` 或者 `Anaconda` 进行管理

  - [Python多版本共存工具](https://michael728.github.io/2015/11/26/python-pyenv-anaconda/)

- `geopy`

  > `pip install geopy`

  [官方文档](https://geopy.readthedocs.io/en/latest/)

  `geopy` 使 `Python` 开发人员能够使用第三方地理编码器和其他数据源轻松定位全球各地的地址、城市、国家和地标的坐标。

  ```python
  # 查询定位到地址和坐标的步骤

  >>> from geopy.geocoders import Nominatim
  >>> geolocator = Nominatim(user_agent="specify_your_app_name_here")
  >>> location = geolocator.geocode("175 5th Avenue NYC")
  >>> print(location.address)
  Flatiron Building, 175, 5th Avenue, Flatiron, New York, NYC, New York, ...
  >>> print((location.latitude, location.longitude))
  (40.7410861, -73.9896297241625)
  >>> print(location.raw)
  {'place_id': '9167009604', 'type': 'attraction', ...}
  #
  ```

- `howdoi`
  >`pip install howdoi`

  有时候你碰到了一个编程问题，觉得自己之前明明见过它的解决方法，但是却记不起来具体是怎么样的了。于是你想要去StackOverflow上找，但又不想离开这个终端。这个时候，你需要下面这个工具——`howdoi`

  `$ howdoi vertical align css`

  `$ howdoi for loop in java`

  `$ howdoi undo commits in git`

  需要注意的是它只从StackOverflow最顶端的答案中抓取代码。所以它给你返回的不总是最有用的信息

- `**kwargs`

  双星 `**` 放在字典的前面可以让你将字典的内容作为命名参数传递给函数。字典的键是参数的名字，键的值作为参数的值传递给函数。如下所示:

  ```python
  dictionary = {"a": 1, "b": 2}
  def someFunction(a, b):
      print(a + b)
      return

  # 下面两种做法效果相同
  someFunction(**dictionary)
  someFunction(a=1, b=2)
  ```

- `list comprehensions` (列表推导)

  列表推导是一些编程语言中可用的句法结构，用于基于现有列表创建列表。

  ```python
  numbers = [1,2,3,4,5,6,7]
  evens = [x for x in numbers if x % 2 is 0]
  odds = [y for y in numbers if y not in evens]
  ```

- `map()`

  Python有许多非常有用的内置函数。其中一个就是map()——特别是和lambda函数相结合的时候

  ```python
  x = [1, 2, 3]
  y = map(lambda x : x + 1 , x)
  # prints out [2,3,4]
  print(list(y))
  ```

  在这个例子中，`map()` 对`x` 中的每一个元素都应用了一个简单的 `lambda` 函数。它会返回一个 `map` 对象，这个对象可以被转化成可迭代对象，如列表或者元组。

- `Operator overloading`（操作符重载）

  Python支持操作符重载。你可以定义使用Python标准操作符符号的对象，这可以让你在特定的环境中使用特定的对象。

  ```python
  class Thing:
    def __init__(self, value):
        self.__value = value
    def __gt__(self, other):
        return self.__value > other.__value
    def __lt__(self, other):
        return self.__value < other.__value

  something = Thing(100)
  nothing = Thing(0)

  # True
  something > nothing
  # False
  something < nothing
  # Error
  something + nothing
  ```

- `pprint`

  `Python的` 默认 `print()` 函数可以满足日常的输出任务，但如果要打印更大的、嵌套式的对象，那么使用默认的 `print()` 函数打印出来的内容会很丑陋。

  这个时候我们就需要`pprint`了，它可以让复杂的结构型对象以可读性更强的格式显示。

  ```python
  person = {
    'name': 'faye',
    'age': 24,
    'id': 'YT00782',
    'company': {
        'name': 'Agumentum',
        'office': {
            'position': 'Shanghai',
            'room': {
                'flour': '2nd',
                'number': 17205
            }
        },
    }
  }

  # print() 函数打印效果
  >>> print(person)
  {'name': 'faye', 'age': 24, 'id': 'YT00782', 'company': {'name': 'Agumentum', 'office': {'position': 'Shanghai', 'room': {'flour': '2nd', 'number': 17205}}}}

  import pprint
  # pprint() 函数打印效果
  >>> pprint.pprint(person)
  {'age': 24,
  'company': {'name': 'Agumentum',
              'office': {'position': 'Shanghai',
                          'room': {'flour': '2nd', 'number': 17205}}},
  'id': 'YT00782',
  'name': 'faye'}
  ```

- `sh`

  sh库让你像调用方法那样调用系统中的命令。

  ```python
  from sh import *
  sh.pwd()
  sh.mkdir('new_folder')
  sh.touch('new_file.txt')
  sh.whoami()
  sh.echo('This is great!')
  ```

- `uuid`

  通过Python标准库中的uuid模块，可以快速并简单地生成统一的唯一ID（又称UUID）

  ```python
  import uuid
  user_id = uuid.uuid4()
  print(user_id)
  ```

- 强大的 `zip()`

  `zip()` 是Python的内置函数，`zip`函数接受任意多个（包括0个和1个）序列作为参数，返回一个包含`tuple`的`list`。zip()函数可以在很多场景简化代码。

  矩阵的行列互换

  ```python
  # Bad
  a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

  re_a = [[row[col] for row in a] for col in range(len(a))]

  >>> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]

  # Good
  a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

  re_a = list(zip(*a))

  >>> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]

  ```

  交换dict的值

  ```python
  # Bad
  a = {'a': 1, 'b': 2, 'c': 3, 'd': 4}

  def reverse_dict(a):
      new_dict = {}
      for k,v in m.items():
          new_dict[v] = k
      return new_dict

  # Good
  a = {'a': 1, 'b': 2, 'c': 3, 'd': 4}

  def reverse_dict(a):
      k = a.keys()
      v = a.values()
      new_dict = dict(zip(v, k))
      return new_dict
  ```

  合并list相邻项

  ```python
  a = [1, 2, 3, 4, 5, 6]

  list(zip( a[::2], a[1::2] ))
  >>> [(1, 2), (3, 4), (5, 6)]
  ```

- 合并字符串

  这是一个老生常谈的问题，当我们需要将数个字符串合并的时候，习惯性的使用"+"作为连接字符串的手段。

  然而，由于不可变对象在内存中生成后无法修改，合并后的字符串会重新开辟出一块内存空间来存储。这样像滚雪球一样，将内存快速消耗殆尽。

  ```python
  # Bad
  string = ['a','b','c','d','e','f','g','h']

  def fun(string):
      all_string = ''
      for i in string:
          all_string += i
      return all_string


  # Good
  string = ['a','b','c','d','e','f','g,'h']

  def fun(string):
      all_string = ''.join(string)
      return all_string
    ```

- 变量值交换

  ```python
  # Bad
  tmp = a
  a = b
  b = tmp

  #Good
  a, b = b, a
  ```

- 在循环中获取索引(数组下标)

  ```python
  a = [8, 23, 45, 12, 78]
  for index, value in enumerate(a):
  print(index , value)
  ```

- 在一行捕获多个异常

  ```python
  try:
    pass
  except (ExceptionA,ExceptionB,.....) as e:
      pass
  ```

- 把列表分割成同样大小的块

  ```python
  a = [1, 2, 3, 4, 5, 6]

  list(zip( *[iter(a)]*2 ))
  >>> [(1, 2), (3, 4), (5, 6)]
  ```

- 查找列表中某个元素的下标

  ```python
  a = ['a', 'b', 'c', 'd', 'e', 'f']

  a_i = a.index(a)
  >>> 0
  ```

- 快速反转字符串

  ```python
  #Bad
  a = 'Python is a powerful languange.'

  list_a = list(a)
  list_a.reverse()
  re_a = ''.join(list_a)

  #Good
  a = 'Python is a powerful languange.'
  re_a = a[::-1]
  ```

- 数值比较

  ```python
  x = 2
  if 1< x <3:
      print(x)
  >>> 2
  if 1< x >0:
      print(x)
  >>> 2
  ```

- 优雅的打开文件

  平时在使用类似文件的流对象时，使用完毕后要调用`close`方法关闭。`with…as`语句提供了一个非常方便的替代方法：`open`打开文件后将返回的文件流对象赋值给`f`，然后在`with`语句块中使用。`with`语句块完毕之后，会隐藏地自动关闭文件。

  ```python
  with open('nothing.txt','r') as f:
    f.read()
  ```

- 三元表达式（三目运算符）
  Python中没有其他语言中的三元表达式，不过有类似的实现方法

  ```python
  a = 1
  b = 2
  h = ""

  h = "变量1" if a>b else "变量2"

  print(h)
  ```

## 4. Python中下划线的意义

本文介绍了Python中单下划线和双下划线（"dunder"）的各种含义和命名约定，名称修饰（name mangling）的工作原理，以及它如何影响Python类。

单下划线和双下划线在Python变量和方法名称中都各有其含义。有一些含义仅仅是依照约定，被视作是对程序员的提示, 而有一些含义是由Python解释器严格执行的。

- 单前导下划线：`_var`
- 单末尾下划线：`var_`
- 双前导下划线：`__var`
- 双前导和末尾下划线：`__var__`
- 单下划线：`_`

在本文中，我将讨论以上五种下划线模式和命名约定，以及它们如何影响Python程序的行为：

1. 单前导下划线 `_var`

    当涉及到变量和方法名称时，单个下划线前缀有一个约定俗成的含义。 它是对程序员的一个提示——意味着Python社区一致认为它应该是什么意思，但程序的行为不受影响。

    下划线前缀的含义是告知其他程序员：以单个下划线开头的变量或方法仅供内部使用。 该约定在`PEP 8`中有定义。

    这不是Python强制规定的。 Python不像Java那样在“私有”和“公共”变量之间有很强的区别

    例子：

    ```python
    class Test:
      def __init__(self):
          self.foo = 11
          self._bar = 23
    ```

    如果你实例化此类，并尝试访问在`__init__`构造函数中定义的`foo`和`_bar`属性，会发生什么情况？

    ```python
    >>> t = Test()
    >>> t.foo
    11
    >>> t._bar
    23
    ```

    你会看到_bar中的单个下划线并没有阻止我们“进入”类并访问该变量的值。

    这是因为Python中的单个下划线前缀仅仅是一个约定——至少相对于变量和方法名而言。

    但是，前导下划线的确会影响从模块中导入名称的方式。

    假设你在一个名为my_module的模块中有以下代码：

    ```python
    # my_module.py:

    def external_func():
      return 23

    def _internal_func():
      return 42
    ```

    现在，如果使用通配符从模块中导入所有名称，则Python不会导入带有前导下划线的名称（除非模块定义了覆盖此行为的__all__列表）：

    ```python
    >>> from my_module import *
    >>> external_func()
    23
    >>> _internal_func()
    NameError: "name '_internal_func' is not defined"
    ```

    >BTW：
    >
    >应该避免通配符导入，因为它们使名称空间中存在哪些名称不清楚。 为了清楚起见，坚持常规导入更好。

    与通配符导入不同，常规导入不受前导单个下划线命名约定的影响：

    ```python
    >>> import my_module
    >>> my_module.external_func()
    23
    >>> my_module._internal_func()
    42
    ```

    一点可能有点令人困惑。 如果你遵循`PEP 8`，避免通配符导入，那么你真正需要记住的只有这个：

    单个下划线是一个Python命名约定，表示这个名称是供内部使用的。 它通常不由Python解释器强制执行，仅仅作为一种对程序员的提示。

2. 单末尾下划线 `var_`

    有时候，一个变量的最合适的名称已经被一个关键字所占用。 因此，像class或def这样的名称不能用作Python中的变量名称。 在这种情况下，你可以附加一个下划线来解决命名冲突：

    ```python
    >>> def make_object(name, class):
    SyntaxError: "invalid syntax"

    >>> def make_object(name, class_):
    ...    pass
    ```

    总之，单个末尾（后缀）下划线是一个约定，用来避免与Python关键字产生命名冲突。 `PEP 8`解释了这个约定。

3. 双前导下划线 `__var`

    到目前为止，我们所涉及的所有命名模式的含义，来自于已达成共识的约定。 而对于以双下划线开头的Python类的属性（包括变量和方法），情况就有点不同了。

    双下划线前缀会导致Python解释器重写属性名称，以避免子类中的命名冲突。

    这也叫做名称修饰(name mangling)——解释器更改变量的名称，以便在类被扩展的时候不容易产生冲突。

    这听起来很抽象。 因此，我组合了一个小小的代码示例来予以说明：

    ```python
    class Test:
      def __init__(self):
          self.foo = 11
          self._bar = 23
          self.__baz = 23
    ```

    让我们用内置的dir()函数来看看这个对象的属性：

    ```python
    >>> t = Test()
    >>> dir(t)
    ['_Test__baz', '__class__', '__delattr__', '__dict__', '__dir__',
    '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__',
    '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__module__',
    '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__',
    '__setattr__', '__sizeof__', '__str__', '__subclasshook__',
    '__weakref__', '_bar', 'foo']
    ```

    以上是这个对象属性的列表。 让我们来看看这个列表，并寻找我们的原始变量名称foo，_bar和__baz——我保证你会注意到一些有趣的变化。

    - `self.foo`变量在属性列表中显示为未修改为`foo`。

    - `self._bar`的行为方式相同——它以`_bar`的形式显示在类上。 就像我之前说过的，在这种情况下，前导下划线仅仅是一个约定。 给程序员一个提示而已。

    - 对于`self.__baz`而言，情况看起来有点不同。 当你在该列表中搜索__baz时，你会看不到有这个名字的变量。

    `__baz`出什么情况了？

    如果你仔细观察，你会看到此对象上有一个名为`_Test__baz`的属性。 这就是Python解释器所做的名称修饰。 它这样做是为了防止变量在子类中被重写。

    让我们创建另一个扩展`Test`类的类，并尝试重写构造函数中添加的现有属性：

    ```python
    class ExtendedTest(Test):
      def __init__(self):
          super().__init__()
          self.foo = 'overridden'
          self._bar = 'overridden'
          self.__baz = 'overridden'
    ```

    现在，你认为foo，_bar和__baz的值会出现在这个ExtendedTest类的实例上吗？ 我们来看一看：

    ```python
    >>> t2 = ExtendedTest()
    >>> t2.foo
    'overridden'
    >>> t2._bar
    'overridden'
    >>> t2.__baz
    AttributeError: "'ExtendedTest' object has no attribute '__baz'"
    ```

    等一下，当我们尝试查看`t2 .__ baz`的值时，为什么我们会得到`AttributeError`? 名称修饰被再次触发了！ 事实证明，这个对象甚至没有`__baz`属性：

    ```python
    >>> dir(t2)
    ['_ExtendedTest__baz', '_Test__baz', '__class__', '__delattr__',
    '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__',
    '__getattribute__', '__gt__', '__hash__', '__init__', '__le__',
    '__lt__', '__module__', '__ne__', '__new__', '__reduce__',
    '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__',
    '__subclasshook__', '__weakref__', '_bar', 'foo', 'get_vars']
    ```

    正如你可以看到__baz变成_ExtendedTest__baz以防止意外修改：

    ```python
    >>> t2._ExtendedTest__baz
    'overridden'
    ```

    但原来的_Test__baz还在：

    ```python
    >>> t2._Test__baz
    42
    ```

    双下划线名称修饰对程序员是完全透明的。 下面的例子证实了这一点：

    ```python
    class ManglingTest:
      def __init__(self):
          self.__mangled = 'hello'

      def get_mangled(self):
          return self.__mangled

    >>> ManglingTest().get_mangled()
    'hello'
    >>> ManglingTest().__mangled
    AttributeError: "'ManglingTest' object has no attribute '__mangled'"
    ```

    名称修饰是否也适用于方法名称？ 是的，也适用。名称修饰会影响在一个类的上下文中，以两个下划线字符（"dunders"）开头的所有名称：

    ```python
    class MangledMethod:
      def __method(self):
          return 42

      def call_it(self):
          return self.__method()

    >>> MangledMethod().__method()
    AttributeError: "'MangledMethod' object has no attribute '__method'"
    >>> MangledMethod().call_it()
    42
    ```

    这是另一个也许令人惊讶的运用名称修饰的例子：

    ```python
    _MangledGlobal__mangled = 23

    class MangledGlobal:
      def test(self):
          return __mangled

    >>> MangledGlobal().test()
    23
    ```

    在这个例子中，我声明了一个名为`_MangledGlobal__mangled`的全局变量。然后我在名为`MangledGlobal`的类的上下文中访问变量。由于名称修饰，我能够在类的`test()`方法内，以`__mangled`来引用`_MangledGlobal__mangled`全局变量。

    Python解释器自动将名称`__mangled`扩展为`_MangledGlobal__mangled`，因为它以两个下划线字符开头。这表明名称修饰不是专门与类属性关联的。它适用于在类上下文中使用的两个下划线字符开头的任何名称。

    老实说，这些例子和解释不是从我脑子里蹦出来的。我作了一些研究和加工才弄出来。我一直使用Python，有很多年了，但是像这样的规则和特殊情况并不总是浮现在脑海里。

    有时候程序员最重要的技能是“模式识别”，而且知道在哪里查阅信息。如果您在这一点上感到有点不知所措，请不要担心。慢慢来，试试这篇文章中的一些例子。

    让这些概念完全沉浸下来，以便你能够理解名称修饰的总体思路，以及我向您展示的一些其他的行为。如果有一天你和它们不期而遇，你会知道在文档中按什么来查。

4. 双前导和双末尾下划线 `_var_`

    也许令人惊讶的是，如果一个名字同时以双下划线开始和结束，则不会应用名称修饰。 由双下划线前缀和后缀包围的变量不会被Python解释器修改：

    ```python
    class PrefixPostfixTest:
      def __init__(self):
          self.__bam__ = 42

    >>> PrefixPostfixTest().__bam__
    42
    ```

    但是，Python保留了有双前导和双末尾下划线的名称，用于特殊用途。 这样的例子有，`__init__`对象构造函数，或`__call__`——它使得一个对象可以被调用。

    这些`dunder methods`通常被称为`magic methods`——但Python社区中的许多人（包括我自己）都不喜欢这种方法。

    最好避免在自己的程序中使用以双下划线（“dunders”）开头和结尾的名称，以避免与将来Python语言的变化产生冲突。

5. 单下划线 _

    按照习惯，有时候单个独立下划线是用作一个名字，来表示某个变量是临时的或无关紧要的。

    例如，在下面的循环中，我们不需要访问正在运行的索引，我们可以使用“_”来表示它只是一个临时值：

    ```python
    >>> for _ in range(32):
    ...    print('Hello, World.')
    ```

    你也可以在拆分(unpacking)表达式中将单个下划线用作“不关心的”变量，以忽略特定的值。 同样，这个含义只是“依照约定”，并不会在Python解释器中触发特殊的行为。 单个下划线仅仅是一个有效的变量名称，会有这个用途而已。

    在下面的代码示例中，我将汽车元组拆分为单独的变量，但我只对颜色和里程值感兴趣。 但是，为了使拆分表达式成功运行，我需要将包含在元组中的所有值分配给变量。 在这种情况下，“_”作为占位符变量可以派上用场：

    ```python
    >>> car = ('red', 'auto', 12, 3812.4)
    >>> color, _, _, mileage = car

    >>> color
    'red'
    >>> mileage
    3812.4
    >>> _
    12
    ```

    除了用作临时变量之外，“_”是大多数`Python REPL`中的一个特殊变量，它表示由解释器评估的最近一个表达式的结果。

    这样就很方便了，比如你可以在一个解释器会话中访问先前计算的结果，或者，你是在动态构建多个对象并与它们交互，无需事先给这些对象分配名字：

    ```python
    >>> 20 + 3
    23
    >>> _
    23
    >>> print(_)
    23

    >>> list()
    []
    >>> _.append(1)
    >>> _.append(2)
    >>> _.append(3)
    >>> _
    [1, 2, 3]
    ```

Python下划线命名模式 - 小结
以下是一个简短的小结，即“速查表”，罗列了我在本文中谈到的五种Python下划线模式的含义：
  ![Python下划线命名模式](https://pic3.zhimg.com/80/v2-cbc5c6037101c7d33cf0acd9f00a8cfa_hd.jpg)

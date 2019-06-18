# Django Summary

- 安装

  [安装教程](http://www.runoob.com/django/django-install.html)

- 配置文件

  [官方文档](https://docs.djangoproject.com/zh-hans/2.2/ref/settings)

  Django项目中，在根模块中都包含一个`settings.py`配置文件，这个配置文件用于配置和管理Django项目

  - BASE_DIR

    BASE_DIR 表示当前项目文件目录的绝对路径

    > 默认值:
    >
    > `BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(\__file__)))`

  - SECRET_KEY

    SECRET_KEY是特定Django安装的密钥。这用于提供[加密签名](https://docs.djangoproject.com/en/2.1/topics/signing/)，并应设置为唯一的、不可预测的值。

    > 默认值: `""` (空字符串)
    >
    > [django-adminstartproject](https://docs.djangoproject.com/en/2.1/ref/django-admin/#django-admin-startproject)自动向每个新项目添加随机生成的`SECRET_KEY`
    >
    > 如果未设置[`SECRET_KEY`](https://docs.djangoproject.com/en/2.1/ref/settings/#std:setting-SECRET_KEY)，Django将拒绝启动。

  - DEBUG

    DEBUG配置为True的时候会暴露出一些出错信息或者配置信息以方便调试.但是在上线的时候应该将其关掉，防止配置信息或者敏感出错信息泄露

    > 默认值: `False`

  - ALLOWED_HOSTS

    Django网站可以提供的主机/域名的字符串列表

    > 默认值: `[]`
    >
    > 当DEBUG设置为False的时候必须配置这个配置，否则会抛出异常。

  - INSTALLED_APPS

    该 Django 项目中安装的所有应用

    > 默认值: `[]`
    >
    > 新建的app都要在settings中添加

  - MIDDLEWARE

    web应用中需要加载的一些中间件列表

    > 默认值: `[]`

  - ROOT_URLCONF

    > 表示根路由的模块名

  - TEMPLATES

    > 包含要与Django一起使用的所有模板引擎的设置的列表。列表中的每一项都是一个字典，其中包含单个引擎的选项。

  - WSGI_APPLICATION

    > Django的内置服务器(例如runserver)将使用WSGI应用程序对象的完整Python路径

  - DATABASES

    Django 将使用的所有数据库的设置

    > 默认值: `{}`
    >
    > 必须配置`default`数据库,还可以指定任何数量的附加数据库

  - AUTH_PASSWORD_VALIDATORS

    > 用于检查用户密码强度的验证器列表

  - LANGUAGE_CODE

    表示Django项目语言代码的字符串

    > 默认值: `en-us`
    >
    > USE_I18N必须处于开启状态，该设置才能生效。

  - USE_I18N

    表示Django的翻译系统是否被启用

    > 默认值: `True`

  - USE_L10N
    > 默认值: False
    >
    > 表示Django是否启用数据的本地化格式，如果开启Django将使用当前地区的格式显示数字和日期

  - USE_TZ

    >用来指定是否使用指定的时区(TIME_ZONE)的时间.若为`True`, 则Django 会使用内建的时区的时间否则, Django 将会使用本地的时间

  - TIME_ZONE

    表示存储在此数据库中的日期时间的时区

    > 默认值: `None`
    >
    >  当USE_TZ为True并且数据库不支持时区（例如SQLite，MySQL，Oracle）时，Django会根据此选项在本地时间读取和写入日期时间（如果已设置），如果不是则以UTC格式读取。
    >
    >  当USE_TZ为True且数据库支持时区（例如PostgreSQL）时，设置此选项是错误的。
    >
    >  当USE_TZ为False时，设置此选项是错误的。

  - LOGGING

    > 默认值: 包含日志配置信息的字典
    >
    > 包含配置信息的数据结构。这个数据结构的内容将作为参数传递给[日志配置](https://docs.djangoproject.com/en/2.1/ref/settings/#std:setting-LOGGING_CONFIG)中描述的配置方法。

  - LOGGING_CONFIG

    一个可调用的路径，该路径将用于配置Django项目中的日志记录。默认情况下指向Python的dictConfig配置方法的实例。

    > 默认值: `logging.config.dictConfig`
    >
    > 如果将LOGGING_CONFIG设置为`None`，将跳过日志配置过程。

- 模型层

  [官方文档](https://docs.djangoproject.com/zh-hans/2.1/topics/db/models/)

    模型是数据唯一而且准确的信息来源。它包含正在储存的数据的重要字段和行为。一般来说，每一个模型都映射一个数据库表。

    ```python
    from django.db import models

    class Person(models.Model):

        first_name = models.CharField(max_length=30)

        last_name = models.CharField(max_length=30)
    ```

    > 每个模型都是一个 Python 的类，这些类继承 [`django.db.models.Model`](https://docs.djangoproject.com/zh-hans/2.1/ref/models/instances/#django.db.models.Model "django.db.models.Model")
    >
    > 模型类的每个属性都相当于一个数据库的字段。

    `first_name`和`last_name`是[模型的字段](https://docs.djangoproject.com/zh-hans/2.1/topics/db/models/#fields)。每个字段都被指定为一个类属性，并且每个属性映射为一个数据库列。

    上面的`Person`模型会创建一个如下的数据库表：

    ```sql
    CREATE TABLE myapp_person (

        "id" serial NOT NULL PRIMARY KEY,

        "first_name" varchar(30) NOT NULL,

        "last_name" varchar(30) NOT NULL

    );
    ```

    >  该表的名称 “myapp_person” 是自动从某些模型元数据中派生出来，但可以被改写
    >
    >  一个`id`字段会被自动添加，但是这种行为可以被改写。
    >
    >  示例中的CREATE TABLE SQL使用PostgreSQL语法进行格式化，但值得注意的是Django使用针对[设置文件](https://docs.djangoproject.com/zh-hans/2.1/topics/settings/)中指定的数据库后端定制的SQL

  - [字段](https://docs.djangoproject.com/zh-hans/2.2/ref/models/fields/)

    - 常用字段类型

      | 字段类型                          | 描述                                                                                                                                           |
      |:----------------------------- |:-------------------------------------------------------------------------------------------------------------------------------------------- |
      | **AutoField**                 | 如果没有指明主键，就会产生一个自增的主键                                                                                                                         |
      | **BigIntegerField**           | 64位的整型数值，从 -2^63 到 2^63-1。                                                                                                                   |
      | **BinaryField**               | 存储二进制码的Field. 只支持bytes 赋值。                                                                                                                   |
      | **BooleanField**              | 该字段的默认表单控件是CheckboxInput，如果你需要设置null 值，则使用NullBooleanField 来代替BooleanField。                                                                  |
      | **CharField**                 | 用来存储字符串                                                                                                                                      |
      | **DateField**                 | 这是一个使用Python的datetime.date实例表示的日期                                                                                                            |
      | **DateTimeField**             | 它是通过Python datetime.datetime实例表示的日期和时间.                                                                                                      |
      | **DecimalField**              | 用python中 Decimal 的一个实例来表示十进制浮点数                                                                                                              |
      | **DurationField**             | 用作存储一段时间的字段类型.                                                                                                                               |
      | **EmailField**                | 使用EmailValidator检查值是否是有效的电子邮件地址的CharField。                                                                                                   |
      | **FileField**                 | 文件字段，不支持primary_key参数，如果使用将引发错误。                                                                                                             |
      | **FilePathField**             | 一个 CharField ，内容只限于文件系统内特定目录下的文件名。                                                                                                           |
      | **FloatField**                | 浮点数字段，用来存放Python中的float实例                                                                                                                    |
      | **ImageField**                | 继承FileField的所有属性和方法，但还对上传的对象进行校验，确保它是个有效的图片。                                                                                                 |
      | **IntegerField**              | 整数字段。 从-2147483648到2147483647的值在Django支持的所有数据库中都是安全的                                                                                         |
      | **GenericIPAddressField**     | 一个 IPv4 或 IPv6 地址, 字符串格式 (例如 192.0.2.30 或 2a02:42fe::4)                                                                                      |
      | **PositiveIntegerField**      | 和IntegerField一样，但必须是正数或零（0）                                                                                                                  |
      | **PositiveSmallIntegerField** | 该模型字段类似 PositiveIntegerField, 但是只允许小于某一特定值（依据数据库类型而定）                                                                                        |
      | **SlugField**                 | slug是短标题，只包含字母、数字、下划线或连字符。通常用于url。                                                                                                           |
      | **SmallIntegerField**         | 类似于IntegerField，但只允许特定(依赖于数据库)点下的值。在Django支持的所有数据库中，-32768到32767之间的值都是安全的                                                                    |
      | **TimeField**                 | s时间字段，用来存放Python中的datetime.time实例。和DateField一样支持自动填充                                                                                         |
      | **URLField**                  | 用于存储通用唯一标识符的字段。 使用Python的UUID类。 在PostgreSQL上使用时，它以uuid数据类型存储，否则存储在char（32）中。与所有CharField子类一样，URLField接受可选的max length参数。如果没有指定最大长度，则使用默认值200。 |
      | **UUIDField**                 | 用于存储通用唯一标识符的字段。 使用Python的UUID类。 在PostgreSQL上使用时，它以uuid数据类型存储，否则存储在char（32）中。可用来替代AutoField生成唯一主键                                             |

    - 字段选项

      | 字段选项                       | 描述                                                                      |
      |:-------------------------- | ----------------------------------------------------------------------- |
      | **Field.null**             | 如果为True，Django将在数据库中将空值存储为NULL。默认是False                                 |
      | **Field.blank**            | 如果为True，则允许该字段为空。默认的是False                                              |
      | **Field.choices**          | 它是一个可迭代的结构(比如，列表或是元组)，由可迭代的二元组组成(比如\[(A, B), (A, B) ...])，用来给这个字段提供选择项。 |
      | **Field.db_column**        | 要用于此字段的数据库列的名称。如果没有给出，Django将使用字段的名称。                                   |
      | **Field.db_index**         | 如果为True，将为该字段创建一个数据库索引                                                  |
      | **Field.db_tablespace**    | 如果该字段被索引，则为该字段的索引使用的数据库表空间的名称                                           |
      | **Field.default**          | 字段的默认值。这可以是一个值，也可以是一个回调函数。如果是回调函数，每次在调用时都会产生新的对象。                       |
      | **Field.editable**         | 如果为False，则该字段不会显示在admin或任何其他ModelForm中。在模型验证期间也会跳过它们。默认是True。           |
      | **Field.error_messages**   | error messages参数允许覆盖字段将引发的默认消息。传入一个字典，其中的键与要覆盖的错误消息匹配。                  |
      | **Field.help_text**        | 在form表单上显示额外的帮助文本。它对文档很有用，即使你的字段没有用在表单上                                 |
      | **Field.primary_key**      | 如果为True，则此字段是模型的主键                                                      |
      | **Field.unique**           | 如果为True，则此字段在整个表中必须是惟一的。                                                |
      | **Field.unique_for_date**  | 将其设置为DateField或DateTimeField的名称，以要求此字段对于日期字段的值是唯一的。                     |
      | **Field.unique_for_month** | 和unique_for_date类似，但是要求字段对于月份是惟一的                                       |
      | **Field.unique_for_year**  | 和unique_for_date类似，但是要求字段对于年份是惟一的                                       |
      | **Field.verbose_name**     | 字段的可读名称。如果没有给出详细的名称，Django将使用字段的属性名自动创建它，将下划线转换为空格                      |
      | **Field.validators**       | 要为此字段执行的验证列表                                                            |

  - 数据库操作

    为了在Python对象中表示数据库表数据，Django使用了一个直观的系统:一个模型类表示一个数据库表

    一旦你建立好[数据模型](https://docs.djangoproject.com/zh-hans/2.2/topics/db/models/)，Django会自动为你生成一套数据库抽象的API，可以让你创建、检索、更新和删除对象。这篇文档阐述如何使用这些API。关于模型查询所有选项的完整细节，请见[数据模型](https://docs.djangoproject.com/zh-hans/2.2/ref/models/)。

    - 插入

      - [save()](https://docs.djangoproject.com/zh-hans/2.2/ref/models/instances/#django.db.models.Model.save "django.db.models.Model.save")

        若要创建对象，先使用模型类的关键字参数实例化它，然后调用save()将其保存到数据库中。

        ```python
        >>> from blog.models import Blog
        >>> b = Blog(name='Beatles Blog', tagline='All the latest Beatles news.')
        >>> b.save()
        ```

        >  上面的代码在背后执行了SQL 的`INSERT`语句。在你显式调用[`save()`](https://yiyibooks.cn/__trs__/xx/Django_1.11.6/ref/models/instances.html#django.db.models.Model.save "django.db.models.Model.save")之前，Django 不会访问数据库。
        >
        >  `save()`方法没有返回值

      - [create()](https://docs.djangoproject.com/zh-hans/2.2/ref/models/querysets/#django.db.models.query.QuerySet.create "django.db.models.query.QuerySet.create")

        只用一条语句创建并保存一个对象

        ```python
        >>> from blog.models import Blog
        >>> b = Person.objects.create(name='Beatles Blog', tagline='All the latest Beatles news.')
        ```

      - [bulk-create()](https://docs.djangoproject.com/zh-hans/2.2/ref/models/querysets/#bulk-create)

        批量创建，将提供的对象列表插入数据库(通常只有一个查询，不管有多少对象)

        ```python
        from itertools import islice

        batch_size = 100
        objs = (Entry(headline='Test %s' % i) for i in range(1000))
        while True:
            batch = list(islice(objs, batch_size))
            if not batch:
                break
            Entry.objects.bulk_create(batch, batch_size)
        ```

        > 模型的`save()`方法不会被调用, 并且`pre_save`和`post_save`信号也不会发送.
        >
        > 不适用于多表继承情况中的子模型
        >
        > 如果模型的主键是[`AutoField`](https://docs.djangoproject.com/zh-hans/2.2/ref/models/fields/#django.db.models.AutoField "django.db.models.AutoField")，它不会像save()那样检索和设置主键属性，除非数据库后端支持它
        >
        > 不适用于多对多关系

    - 删除

      - delete()

        该方法立即删除对象，并返回一个字典，该字典包含着删除的对象数量和每个对象类型的删除次数

        ```python
        >>> b = Blog.objects.get(pk=1)

        # Delete all the entries belonging to this Blog.
        >>> Entry.objects.filter(blog=b).delete()
        (4, {'weblog.Entry': 2, 'weblog.Entry_authors': 2})

        >>> blogs = Blog.objects.all()

        # This will delete all Blogs and all of their Entry objects.
        >>> blogs.delete()
        (5, {'weblog.Blog': 1, 'weblog.Entry': 2, 'weblog.Entry_authors': 2})
        ```

        > 当Django 删除一个对象时，它默认使用 `ONDELETECASCADE` 约束 ，任何有外键指向要删除对象的对象将一起删除。
        >
        > [`delete()`](https://yiyibooks.cn/__trs__/xx/Django_1.11.6/ref/models/querysets.html#django.db.models.query.QuerySet.delete "django.db.models.query.QuerySet.delete")是唯一没有在[`Manager`](https://yiyibooks.cn/__trs__/xx/Django_1.11.6/topics/db/managers.html#django.db.models.Manager "django.db.models.Manager")上暴露出来的[`QuerySet`](https://docs.djangoproject.com/zh-hans/2.2/ref/models/querysets/#django.db.models.query.QuerySet)方法。如果想删除所有的对象，必须明确地请求一个完全的查询集

    - 更新

      - save()

        > Django如何知道是UPDATE还是INSERT
        >
        > Django 数据库对象使用同一个`save()`方法来创建和更新对象。Django 对 `INSERT` 和`UPDATE` SQL 语句的使用进行抽象。当你调用`save()` 时，Django 使用下面的算法：
        >
        > - 如果对象的主键属性为一个求值为`True`的值（例如，非`None`值或非空字符串），Django将执行`UPDATE`。
        >
        > - 如果对象的主键属性*没有*设置或者`UPDATE`没有更新任何记录，Django将执行`INSERT`。
        >
        > 所以当保存一个新的对象时，如果不能保证主键的值没有使用，应该不要显式指定主键值

      - update()

        `update()`方法会立即应用，并返回查询匹配的行数

        ```python
        >>> b = Blog.objects.get(pk=1)

        # Change every Entry so that it belongs to this Blog.
        >>> Entry.objects.all().update(blog=b)
        ```

    - 查询

      通过模型中的 [Manager](https://docs.djangoproject.com/zh-hans/2.2/topics/db/managers/#django.db.models.Manager) 构造一个 [QuerySet](https://docs.djangoproject.com/zh-hans/2.2/ref/models/querysets/#django.db.models.query.QuerySet) ，来从数据库中获取对象。

      [QuerySet](https://docs.djangoproject.com/zh-hans/2.2/ref/models/querysets/#django.db.models.query.QuerySet) 表示从数据库中取出来的对象的集合。它可以含有零个、一个或者多个过滤器。过滤器基于所给的参数限制查询的结果。从SQL 的角度来看，[QuerySet](https://docs.djangoproject.com/zh-hans/2.2/ref/models/querysets/#django.db.models.query.QuerySet) 和`SELECT` 语句等价，过滤器是像 `WHERE` 和`LIMIT` 一样的限制子句。

      - 简单查询

        ```python
        # 返回一个QuerySet集合对象, 内容是UserInfo表中的所有结果
        # SELECT * from userinfo
        models.UserInfo.objects.all()

        # 指定返回id为1的对象,
        # SELECT * FROM userinfo WHERE id = 1
        models.UserInfo.objects.get(id=1)

        # 返回一个QuerySet集合对象，内容是id大于等于3的username
        # SELECT username FROM userinfo WHERE id >= 3
        models.UserInfo.objects.filter(id_gte=3).values('username')

        # 对指定字段进行排序(升序)
        # SELECT * FROM userinfo ORDER BY id ASC
        models.UserInfo.objects.all().order_by('id')

        # 对指定字段进行排序(降序)
        # SELECT * FROM userinfo ORDER BY id DESC
        models.UserInfo.objects.all().order_by('-id')

        # 对查询结果去重
        # SELECT distinct(username) FROM userinfo
        models.UserInfo.objects.values('username').distinct()

        ```

    - 常用QuerySet方法

      | 方法名                 | 描述                                                                           | 示例                                                                                                                                                                                                                         |
      |:------------------- | ---------------------------------------------------------------------------- |:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
      | filter()            | 返回所有满足查询参数的QuerySet，多个参数之间是和AND的关系                                           | 查询学生表中年龄小于10岁的女生`Student.objects.filter(age__lt=10, gerder='female')`                                                                                                                                                   |
      | exclude()           | 返回所有不满足查询参数的QuerySet，多个参数之间是和AND的关系                                          | 查询学生表中年龄小于等于20岁且名字不为lin的学生`Student.objects.exclude(age__gt=20, name='lin')`                                                                                                                                             |
      | order_by()          | 根据模型的Meta类中的ordering属性对QuerySet中的对象进行排序                                      | 按照age降序排序，然后再按照name升序排序。"-age"前面的负号表示降序顺序。 升序是默认的。 `Student.objects.filter(school="阳关小学").order_by('-age', 'name')`| 使用"?"进行随机排序| `Student.objects.order_by('?')`                                                  |
      | reverse()           | 反向排序QuerySet中返回的元素。 第二次调用reverse()将恢复到原有的排序                                  |                                                                                                                                                                                                                            |
      | distinct()          | 去除查询结果中重复的行                                                                  | `models.UserInfo.objects.values('username').distinct()`                                                                                                                                                                      |
      | values()            | 返回一个包含数据的字典的queryset，而不是模型实例，每个字典表示一个对象，键对应于模型对象的属性名称                        | `Student.objects.filter(name__startswith='Lin').values()`                                                                                                                                                                    |
      | values_list()       | 与values()类似，只是在迭代时返回的是元组而不是字典。                                               |                                                                                                                                                                                                                            |
      | dates()             | 根据日期获取查询集                                                                    |                                                                                                                                                                                                                            |
      | datetimes()         | 根据时间获取查询集                                                                    |                                                                                                                                                                                                                            |
      | none()              | 创建空的查询集                                                                      |                                                                                                                                                                                                                            |
      | all()               | 获取所有的对象                                                                      |                                                                                                                                                                                                                            |
      | union()             | 并集                                                                           |                                                                                                                                                                                                                            |
      | intersection()      | 交集                                                                           |                                                                                                                                                                                                                            |
      | difference()        | 差集                                                                           |                                                                                                                                                                                                                            |
      | select_related()    | 附带查询关联对象                                                                     |                                                                                                                                                                                                                            |
      | prefetch_related()  | 预先查询                                                                         |                                                                                                                                                                                                                            |
      | extra()             | 附加SQL查询                                                                      |                                                                                                                                                                                                                            |
      | defer()             | 不加载指定字段                                                                      |                                                                                                                                                                                                                            |
      | only()              | 只加载指定的字段                                                                     |                                                                                                                                                                                                                            |
      | using()             | 选择数据库                                                                        |                                                                                                                                                                                                                            |
      | select_for_update() | 锁住选择的对象，直到事务结束                                                               |                                                                                                                                                                                                                            |
      | raw()               | 接收一个原始的SQL查询                                                                 |                                                                                                                                                                                                                            |
      | annotate()          | 使用聚合函数通过对QuerySet进行计算，返回一个聚合值的字典。aggregate()中每一个参数都指定一个包含在字典中返回值。即在查询集合上生成聚合 | `models.Book.objects.all().aggregate(Avg('price'))` #求平均值`models.Book.objects.all().aggregate(Min('price'))` #求最小值`models.Book.objects.all().aggregate(Sum('price'))` #求和`models.Book.objects.all().aggregate(Max('price'))` #求最大值 |
      | annotate()          | 可以通过计算查询结果中的每一个对象所关联的对象集合，从而得出总计值（也可以是平均值或总和），即为查询集的每一项生成聚合                  | #根据puter表中的name字段分组 并计算price的和models.Book.objects.values('puter__name').annotate(Sum('price'))                                                                                                                        |

    - 查询的关键字参数

      | 参数           | 描述          |
      | ------------- | -------------- |
      | __gt          | 大于           |
      | __gte         | 大于等于        |
      | __lt          | 小于          |
      | __lte         | 小于等于        |
      | __exact       | 精确等于        |
      | __iexact      | 精确等于(忽略大小写) |
      | __contains    | 包含          |
      | __icontains   | 包含(忽略大小写)   |
      | __in          | 指定查询范围      |
      | __isnull      | 是否为空        |
      | __startswith  | 以…开头        |
      | __istartswith | 以…开头 忽略大小写  |
      | __endswith    | 以…结尾        |
      | __iendswith   | 以…结尾忽略大小写   |
      | __range       | 在…范围内       |
      | __year        | 日期字段的年份     |
      | __month       | 日期字段的月份     |
      | __day         | 日期字段的日      |

    - 数据迁移

      [官方文档](https://docs.djangoproject.com/zh-hans/2.2/topics/migrations/)

      Django数据迁移是指同步对模型所做的更改（添加字段，删除模型等）到数据库模式的方式。

      Django 数据迁移命令：

      1. migrate 应用和取消应用迁移。

      2. makemigrations 基于修改的模型创建一个新的迁移

      3. sqlmigrate 显示示迁移的sql语句

      4. showmigrations 列出项目的迁移及其状态。

- 视图层

  [官方文档](https://docs.djangoproject.com/en/2.2/#the-view-layer)

  Django用“视图”这个概念封装处理用户请求并返回响应的逻辑

  - 路由配置系统URLconf

    每一个视图函数都会对应一个URL，当一个用户请求访问Django站点的一个页面时，Django路由系统（URL配置文件）去决定要执行哪个视图函数这个路由系统也称之为url控制器，一般是项目目录和应用目录里的urls.py文件。

    当用户从Django支持的站点请求页面时，系统将遵循以下算法来确定要执行的python代码：

      1. Django 决定要使用的根URLconf 模块。 通常，这是`ROOT_URLCONF`设置的值，但是如果传入的`HttpRequest`对象具有`urlconf`属性（由中间件设置），则其值将被用于代替`ROOT_URLCONF`设置。
      2. Django 加载该模块并寻找可用的urlpatterns。 它是`django.conf.urls.url()` 实例的一个Python 列表。
      3. Django按顺序遍历每个URL模式，并在匹配请求的URL的第一个模式停止。
      4. 一旦其中一个URL模式匹配，Django就导入并调用给定的视图，这是一个简单的python函数（或基于类的视图）。该视图将传递以下参数：
         - 一个 `HttpRequest` 实例。
         - 如果匹配的URL模式未返回任何命名组，则正则表达式中的匹配将作为位置参数提供。。
         - 关键字参数由正则表达式匹配的命名组组成，但是可以被django.conf.urls.url()的可选参数kwargs覆盖。
      5. 如果没有匹配到正则表达式，或者如果过程中抛出一个异常，Django 将调用一个适当的错误处理视图。

    一般情况下，一个URL，我们是这样写的：

      ```python
      urlpatterns = [
          path(正则表达式, views视图函数，参数，别名),
      ]
      ```

      参数说明：
      1. 一个正则表达式字符串
      2. 一个可调用对象，通常为一个视图函数或一个指定视图函数路径的字符串
      3. 可选的要传递给视图函数的默认参数（字典形式）
      4. 一个可选的name参数(别名)

      举例：

      ```python
      from django.urls import path
      from . import views
      urlpatterns = [
          path('articles/2003/', views.special_case_2003),
          path('articles/<int:year>/', views.year_archive),
          path('articles/<int:year>/<int:month>/', views.month_archive),
          path('articles/<int:year>/<int:month>/<slug:slug>/', views.article_detail),
          ]
      ```

      > 注意：
      >
      > 1. 要捕获一段url中的值，需要使用尖括号，而不是之前的圆括号；
      >
      > 2. 可以转换捕获到的值为指定类型，比如例子中的 `<int:name>`。默认情况下，捕获到的结果保存为字符串类型，不包含/这个特殊字符；
      >
      >3. 规则的前面不需要添加/，因为默认情况下，每个url都带一个最前面的/。比如：articles, 不能写成 /articles。
      >
      > 匹配例子：
      >
      >1. /articles/2005/03/ 将匹配第三条，并调用`views.month_archive(request, year=2005, month=3)`
      >
      >2. /articles/2003/匹配第一条，并调用`views.special_case_2003(request)`
      >3. /articles/2003将一条都匹配不上，因为它最后少了一个斜杠，而列表中的所有模式中都以斜杠结尾；
      >4. /articles/2003/03/building-a-django-site/ 将匹配最后一个，并调用`views.article_detail(request, year=2003, month=3, slug="building-a-django-site`

    路径转换器

    以下路径转换器默认可用：

    - str - 匹配除了路径分隔符'/'的任非空字符串。 如果表达式中没有包含转器，那么这将是默认行为。
    - int - 匹配0或任意正整数。 并作为int 返回。
    - slug - 匹配任意的黏接字符串(slugstring)，这些黏接字符串是ASCII的字或数字，词与词之间由连字符或下划线接组成。 例如,building-your-1st-django-site。
    - uuid - 匹配一个格式化的 UUID. 了防止多个URL映射到同一页面，必须包多个破折号（dash），同时字母必须写。 例如,075194d3-6885-417e-a8a8-6c931e27200. 返回一个 UUID 实例。
    - path - 匹配包含路径分隔符 '/'在的任意非空字符串。 相对于str，这允你匹配一个完整的URL路径，而不仅仅URL路径的一部分。

    注册自定义路径转换器

    对于更复杂的匹配需求，您可以定义自己的路径转换器。自定义，就是单独写一个类，它包含下面的内容：
    - 类属性regex：一个字符串形式的正则表达式属性；
    - to_python(self, value) 方法：一个用来将匹配到的字符串转换为你想要的那个数据类型，并传递给视图函数。如果不能转换给定的值，则会引发ValueError。
    - to_url(self, value)方法：将Python数据类型转换为一段url的方法，上面方法的反向操作。

    例如：

    ```python
    class FourDigitYearConverter:
        regex = '[0-9]{4}'
        def to_python(self, value):
            return int(value)
        def to_url(self, value):
            return '%04d' % value
    ```

    在URLconf中注册自定义转换器类，并使用它:

    ```python
    from django.urls import path, register_converter
    from . import converters,
    viewsregister_converter(converters.FourDigitYearConverter, 'yyyy')
    urlpatterns = [
        path('articles/2003/', views.special_case_2003),
        path('articles/<yyyy:year>/', views.year_archive),
        ...
        ]
    ```

    使用正则表达式

    如果路径和转换器语法不足以定义URL模式，也可以使用正则表达式。这时我们就需要使用re_path()而不是path()。

    在Python正则表达式中，命名正则表达式组的语法是 `(?P<name>pattern)`，其中`name`是组的名称，`pattern`是需要匹配的规则。

    前面的URLconf示例，如果使用正则表达式重写，是这样子的:

    ```python
    from django.urls import path, re_path
    from . import views
    urlpatterns = [
        path('articles/2003/', views.special_case_2003),
        #表示articles/2003/这个路径映射views模块的special_case_2003函数
        re_path(r'^articles/(?P<year>[0-9]{4})/$', views.year_archive),
        #表示匹配4个0-9的任意数字
        re_path(r'^articles/(?P<year>[0-9]{4})/(?P<month>[0-9]{2})/$', views.month_archive),
        re_path(r'^articles/(?P<year>[0-9]{4})/(?P<month>[0-9]{2})/(?P<slug>[\w-]+)/$', views.article_detail),
        ]
    #注意:上面匹配都加了小括号，这些括号里面的值会当作参数传递到后面的视图函数中
    ```

    `re_path`与`path()`不同的主要在于两点：
    1. year中匹配不到10000等非四位数字，这是正则表达式决定的
    2. 传递给视图的所有参数都是字符串类型。而不像path()方法中可以指定转换成某种类型。

    指定视图参数的默认值

    有一个方便的小技巧是指定视图参数的默认值。 下面是一个URLconf 和视图的示例：

    ```python
    # URLconf
    from django.urls import path
    from . import views
    urlpatterns = [
        path('blog/', views.page),
        path('blog/page<int:num>/', views.page),
        ]

    # View (in blog/views.py)
    def page(request, num=1):
    # Output the appropriate page of blog entries, according to num.
    ```

    在上面的例子中，两个`URL`模式指向同一个视图`views.page` —— 但是第一个模式不会从`URL` 中捕获任何值。如果第一个模式匹配，`page()`函数将使用`num`参数的默认值"1"。如果第二个模式匹配，`page()` 将使用正则表达式捕获的 `num` 值。

    URLconf匹配请求URL中的哪些部分

    请求的URL被看做是一个普通的Python字符串，URLconf在其上查找并匹配。进行匹配时将不包括`GET`或`POST`请求方式的参数以及域名。

    例如，在`https://www.example.com/myapp/`的请求中，`URLconf`将查找`myapp/`。
    在`https://www.example.com/myapp/?page=3`的请求中，`URLconf`也将查找`myapp/`。
    URLconf不检查使用何种HTTP请求方法，所有请求方法`POST`、`GET`、`HEAD`等都将路由到同一个URL的同一个视图。在视图中，才根据具体请求方法的不同，进行不同的处理。

    错误页面处理

    当Django找不到与请求匹配的URL时，或者当抛出一个异常时，将调用一个错误处理视图。错误视图包括400、403、404和500，分别表示请求错误、拒绝服务、页面不存在和服务器错误。它们分别位于：

    >handler400 —— django.conf.urls.handler400。
    >
    >handler403 —— django.conf.urls.handler403。
    >
    >handler404 —— django.conf.urls.handler404。
    >
    >handler500 —— django.conf.urls.handler500。

    这些值可以在根URLconf中设置。在其它app中的二级URLconf中设置这些变量无效。

    Django有内置的HTML模版，用于返回错误页面给用户，但是这些403，404页面往往不能满足我们的需求，通常我们都自定义错误页面。

    1. 在根URLconf中额外增加下面的条目：

        ```python
        # urls.py
        from django.conf.urls import url
        from . import views
        urlpatterns = [
            url(r'^blog/$', views.page),
            url(r'^blog/page(?P<num>[0-9]+)/$', views.page),
        ]
        # 增加的条目
        handler400 = views.bad_request
        handler403 = views.permission_denied
        handler404 = views.page_not_found
        handler500 = views.page_error
        ```

    2. 在views.py文件中增加四个处理视图：

        ```python
        def page_not_found(request):
        return render(request, '404.html')

        def page_error(request):
            return render(request, '500.html')

        def permission_denied(request):
            return render(request, '403.html')

        def bad_request(request):
            return render(request, '400.html')
        ```

    3. 根据需求，创建404.html、400.html等四个页面文件，就可以了。

      urls分层模块化（路由分发）

      通常，我们会在每个app里，各自创建一个urls.py路由模块，然后从根路由出发，将app所属的url请求，全部转发到相应的urls.py模块中。

      例如，下面是Django网站本身的URLconf节选。 它包含许多其它URLconf：

      ```python
      from django.urls import include, path
      urlpatterns = [
          # ... snip ...
          path('community/', include('aggregator.urls')),
          path('contact/', include('contact.urls')),
          # ... snip ...
      ]
      ```

      路由转发使用的是`include()`方法，需要提前导入，它的参数是转发目的地路径的字符串，路径以圆点分割。

      注意，这个例子中的正则表达式没有包含$（字符串结束匹配符），但是包含一个末尾的斜杠。 每当`Django` 遇到`include()`（来自`django.conf.urls.include()`）时，它会去掉`URL`中匹配的部分并将剩下的字符串发送给`include`的`URLconf`做进一步处理，也就是转发到二级路由去。

      另外一种转发其它URL模式的方式是使用一个`url()`实例的列表。 例如，下面的`URLconf`：

      ```python
      from django.urls import include, path
      from apps.main import views as main_views
      from credit import views as credit_views
      extra_patterns = [
          path('reports/', credit_views.report),
          path('reports/<int:id>/', credit_views.report),
          path('charge/', credit_views.charge),
      ]
      urlpatterns = [
          path('', main_views.homepage),
          path('help/', include('apps.help.urls')),
          path('credit/', include(extra_patterns)),
      ]
      ```

      在这个例子中， `/credit/reports/` URL将被 `credit.views.report()   这个Django 视图处理。
      上面这种方法可以用来去除URLconf 中的冗余，其中某个模式前缀被重复使用。例如，下面这个例子:

      ```python
      from django.urls import path
      from . import views
      urlpatterns = [
          path('<page_slug>-<page_id>/history/', views.history),
          path('<page_slug>-<page_id>/edit/', views.edit),
          path('<page_slug>-<page_id>/discuss/', views.discuss),
          path('<page_slug>-<page_id>/permissions/', views.permissions),
      ]
      ```

      我们可以改进它，通过只声明共同的路径前缀一次并将后面的部分分组转发:

      ```python
      from django.urls import include, path
      from . import views
      urlpatterns = [
          path('<page_slug>-<page_id>/', include([
              path('history/', views.history),
              path('edit/', views.edit),
              path('discuss/', views.discuss),
              path('permissions/', views.permissions),
          ])),
      ]
      ```

    捕获参数

    被转发的URLconf会收到来自父URLconf捕获的所有参数，看下面的例子：

    ```python
    # In settings/urls/main.py
    from django.urls import include, path
    urlpatterns = [
        path('<username>/blog/', include('foo.urls.blog')),
    ]
    # In foo/urls/blog.py
    from django.urls import path
    from . import views
    urlpatterns = [
        path('', views.blog.index),
        path('archive/', views.blog.archive),
    ]
    ```

    在上面的例子中，捕获的`username`变量将被传递给`include()`指向的`URLconf`，再进一步传递给对应的视图。

    嵌套参数

    正则表达式允许嵌套参数，Django将解析它们并传递给视图。当反查时，Django将尝试填满所有外围捕获的参数，并忽略嵌套捕获的参数。 考虑下面的URL模式，它带有一个可选的page参数：

    ```python
    from django.urls import re_path
    urlpatterns = [
        # bad
        re_path(r'^blog/(page-(\d+)/)?$', blog_articles),
        # good
        re_path(r'^comments/(?:page-(?P<page_number>\d+)/)?$', comments),
    ]
    ```

    两个模式都使用嵌套的参数，其解析方式是：例如`blog/page-2/`将匹配`page-2/`并带有两个位置参数`blog_articles`和`2`。第二个`comments`的模式将匹配`page_number`并带有一个值为`2`的关键字参数`comments/page-2/`。这个例子中外围参数是一个不捕获的参数(?:...)。

    `blog_articles`视图需要最外层捕获的参数来反查，在这个例子中是`comments`或者没有参数，而`page-2/`可以不带参数或者用一个`page_number`值来反查。

    向视图传递额外的参数

    URLconfs具有一个钩子（hook），允许你传递一个Python字典作为额外的关键字参数给视图函数。

    ```python

    from django.urls import path
    from . import views
    urlpatterns = [
        path('blog/<int:year>/', views.year_archive, {'foo': 'bar'}),
    ]
    ```

    在上面的例子中，对于`/blog/2005/`请求，Django将调用`views.year_archive(request, year='2005', foo='bar')`。理论上，你可以在这个字典里传递任何你想要的传递的东西。但是要注意，URL模式捕获的命名关键字参数和在字典中传递的额外参数有可能具有相同的名称，这会发生**冲突**，要避免。

    传递额外的参数给include()

    类似上面，也可以传递额外的参数给include()。参数会传递给include指向的urlconf中的每一行。

    例如，下面两种URLconf配置方式在功能上完全相同：

    配置一：

    ```python
    # main.py
    from django.urls import include, path
    urlpatterns = [
        path('blog/', include('inner'), {'blog_id': 3}),
    ]
    # inner.py
    from django.urls import path
    from mysite import views
    urlpatterns = [
        path('archive/', views.archive),
        path('about/', views.about),
    ]
    ```

    配置二：

    ```python
    # main.py
    from django.urls import include, path
    from mysite import views
    urlpatterns = [
        path('blog/', include('inner')),
    ]
    # inner.py
    from django.urls import path
    urlpatterns = [
        path('archive/', views.archive, {'blog_id': 3}),
        path('about/', views.about, {'blog_id': 3}),
    ]
    ```

    **注意**:只有当你确定被`include`的URLconf中的每个视图都接收你传递给它们的额外的参数时才有意义，否则其中一个以上视图不接收该参数都将导致错误异常。

    url的反向解析

    在实际的Django项目中，经常需要获取某条URL，为生成的内容配置URL链接。

    比如，要在页面上展示一列文章列表，每个条目都是个超级链接，点击就进入该文章的详细页面。

    现在的urlconf是这么配置的：`^post/(?P<id>\d+)`。

    在前端中，这就需要为`HTML`的`<a>`标签的`href`属性提供一个诸如`http://www.xxx.com/post/3`的值。其中的域名部分，Django会帮你自动添加无须关心，我们关注的是`post/3`。

    此时，一定不能硬编码URL为`post/3`，那样费时、不可伸缩，而且容易出错。试想，如果哪天，因为某种原因，需要将urlconf中的正则改成`^entry/(?P<id>\d+)`，为了让链接正常工作，必须修改对应的`herf`属性值，于是你去项目里将所有的`post/3`都改成`entry/3`吗？显然这是不行的！

    我们需要一种安全、可靠、自适应的机制，当修改URLconf中的代码后，无需在项目源码中大范围搜索、替换失效的硬编码URL。

    为了解决这个问题，Django提供了一种解决方案，只需在URL中提供一个`name`参数，并赋值一个你自定义的、好记的、直观的字符串。

    通过这个`name`参数，可以反向解析URL、反向URL匹配、反向URL查询或者简单的URL反查。

    在需要解析URL的地方，对于不同层级，Django提供了不同的工具用于URL反查：

    在模板语言中：使用url模板标签。(也就是写前端网页时）

    在Python代码中：使用`reverse()`函数。（也就是写视图函数等情况时）

    在更高层的与处理Django模型实例相关的代码中：使用`get_absolute_url(`)方法。(也就是在模型model中)

    示例：

    ```python
    from django.urls import path
    from . import views
    urlpatterns = [
        #...
        path('articles/<int:year>/', views.year_archive, name='news-year-archive'),
        #...
    ]
    ```

    某一年nnnn对应的归档的URL是`/articles/nnnn/`。

    可以在模板的代码中使用下面的方法获得它们：

    ```html
    <a href="{% url 'news-year-archive' 2012 %}">2012 Archive</a>
    {# Or with the year in a template context variable: #}
    <ul>
    {% for yearvar in year_list %}
    <li><a href="{% url 'news-year-archive' yearvar %}">{{ yearvar }} Archive</a></li>
    {% endfor %}
    </ul>

    ```

    在Python代码中，这样使用：

    ```python
    from django.http import HttpResponseRedirect
    from django.urls import reverse
    def redirect_to_year(request):
        # ...
        year = 2006
        # ...
        return HttpResponseRedirect(reverse('news-year-archive', args=(year,)))
    ```

    其中，起到核心作用的是我们通过`name='news-year-archive'`为那条`url`起了一个可以被引用的名称。

    `URL`名称`name`使用的字符串可以包含任何你喜欢的字符，但是过度的放纵有可能带来重名的冲突，比如两个不同的`app`，在各自的`urlconf`中为某一条`url`取了相同的`name`，这就会带来麻烦。为了解决这个问题，又引出了下面命名的URL模式。

    命名的URL模式（URL别名）

    `URL`别名可以保证反查到唯一的`URL`，即使不同的`app`使用相同的`URL`名称。

    第三方应用始终使用带命名空间的`UR`L是一个很好的做法。

    类似地，它还允许你在一个应用有多个实例部署的情况下反查`URL`。 换句话讲，因为一个应用的多个实例共享相同的命名`URL`，命名空间提供了一种区分这些命名`URL` 的方法。

    实现命名空间的做法很简单，在`urlconf`文件中添加`app_name = 'polls'`和`namespace='author-polls'`这种类似的定义。

    范例：

    以两个实例为例子：`'publisher-polls'` 和`'author-polls'`。

    假设我们已经在创建和显示投票时考虑了实例命名空间的问题，代码如下：

    ```python
    # urls.py

    from django.urls import include, path
    urlpatterns = [
        path('author-polls/', include('polls.urls', namespace='author-polls')),
        path('publisher-polls/', include('polls.urls', namespace='publisher-polls')),
    ]


    # polls/urls.py

    from django.urls import path
    from . import views
    app_name = 'polls'
    urlpatterns = [
        path('', views.IndexView.as_view(), name='index'),
        path('<int:pk>/', views.DetailView.as_view(), name='detail'),
        ...
    ]
    ```

    如果当前的app实例是其中的一个，例如我们正在渲染实例`'author-polls'`中的`detail`视图，`'polls:index'`将解析到`'author-polls'`实例的index视图。

    根据以上设置，可以使用下面的查询：

    在基于类的视图的方法中：

    >`reverse('polls:index', current_app=self.request.resolver_match.namespace)`

    和在模板中：

    >`{% url 'polls:index' %}`

    如果没有当前`app`实例，例如如果我们在站点的其它地方渲染一个页面，`'polls:index'`将解析到`polls`注册的最后一个`app`实例空间。 因为没有默认的实例（命名空间为`'polls'`的实例），将使用注册的`polls` 的最后一个实例。 这将是`'publisher-polls'`，因为它是在`urlpatterns`中最后一个声明的。

    `URL`命名空间和`include`的`URLconf`

    可以通过两种方式指定`include`的`URLconf`的应用名称空间。

    第一种

    在`include的URLconf`模块中设置与`urlpatterns`属性相同级别的`app_name`属性。必须将实际模块或模块的字符串引用传递到`include()`，而不是`urlpatterns`本身的列表。

    ```python
    # polls/urls.py
    from django.urls import path
    from . import views
    app_name = 'polls'
    urlpatterns = [
        path('', views.IndexView.as_view(), name='index'),
        path('<int:pk>/', views.DetailView.as_view(), name='detail'),
        ...
    ]

    #urls.py
    from django.urls import include, path
    urlpatterns = [
        path('polls/', include('polls.urls')),
    ]
    ```

    此时，`polls.urls`中定义的`URL`将具有应用名称空间`polls`。

    第二种

    `include`一个包含嵌套命名空间数据的对象。如果你`include()`一个`url()`实例的列表，那么该对象中包含的`URL`将添加到全局命名空间。 但是，你也可以`include()`一个2元组，其中包含：

    >`(<list of path()/re_path() instances>, <application namespace>)`

    例如：

    ```python
    rom django.urls import include, path
    from . import views
    polls_patterns = ([
        path('', views.IndexView.as_view(), name='index'),
        path('<int:pk>/', views.DetailView.as_view(), name='detail'),
    ], 'polls')
    urlpatterns = [
        path('polls/', include(polls_patterns)),
    ]
    ```

    这将include指定的URL模式到给定的app命名空间。

    可以使用`include()`的`namespace`参数指定`app`实例命名空间。如果未指定，则`app`实例命名空间默认为`URLconf`的`app`命名空间。

  - 视图函数

    视图函数是一个简单的Python 函数，它接受Web请求并且返回Web响应。响应可以是一张网页的HTML内容，一个重定向，一个404错误，一个XML文档，或者一张图片. . . 是任何东西都可以。无论视图本身包含什么逻辑，都要返回响应。这个视图函数代码一般约定是放置在项目或应用程序目录中的名为views.py的文件中。

      http请求中产生两个核心对象：

    1. http请求---->HttpRequest对象，用户请求相关的所有信息（对象）

    2. http响应---->HttpResponse对象，响应字符串

    例子：

    ```python
    # views1.py
    from django.http import HttpResponse
    def index(request):
        return HttpResponse("你好")

    # 在urls.py中修改配置
    from . import views1
    path('', views1.index, name='index'),
    ```

    例子里，用到的request，就是HttpRequest对象。HttpResponse("你好")，就是HttpResponse对象，它向http请求响应了一段字符串。

    视图函数，就是围绕着HttpRequest和HttpResponse这两个对象进行的。

    一、`HttpRequest`对象，`request`请求信息和属性和方法。

      属性和方法包含下面几个：

      1. `request.path`：这个主要是用来获取访问文件路径

          ```python
          from django.shortcuts import render,HttpResponse
          def index(request):
              print(request.path)
              print(request.get_full_path())
              return render(request,'index.html')
          ```

          如果我们是通过`http://127.0.0.1:8000/post/23?page=1`请求。

          `request.path`的结果为：`/post/23`

          `request.get_full_path()`的结果为：`/post/23?page=1`

      2. `request.method`属性：获取请求中使用的`HTTP`方式（`POST`/`GET`）

          ```python
          from django.shortcuts import render,HttpResponse
          def index(request):
              print(request.method)
              return render(request,'index.html')
          ```

      3. `request.body`属性：含所有请求体信息 是`bytes`类型

      4. `request.GET`，获取`HTTP` `GET`方式请求传参，的参数（字典类型）

          ```python
          from django.shortcuts import render,HttpResponse
          def index(request):
              print(request.GET)
              return render(request,'index.html')
          ```

          如果我们通过`http://127.0.0.1:8000/post/?fenlei=123 & page=3` 请求。

          获取到：`<QueryDict: {' page': ['456'], 'fenlei': ['123 ']}>`

      5. `request.POST`，获取`POS`T请求的数据(类字典对象) 请求体里拿值。服务器收到空的`POST`请求的情况也是可能发生的，也就是说，表单`form`通过服务器收到空的`POST`请求的情况也是可能发生的，也就是说，表单`form`通过`if request.POST`来判断是否使用了`HTTP POST` 方法；应该使用  `if request.method=="POST"`。

      6. `request.COOKIES`，包含所有`cookies`的标准`Python`字典对象；`keys`和`values`都是字符串。

      7. `request.FILES`，包含所有上传文件的类字典对象；`FILES`中的每一个Key都是`<input type="file" name="" />`标签中`name`属性的值，`FILES`中的每一个`value`同时也是一个标准的`python`字典对象，包含下面三个key:
         - `filename:` 上传文件名
         - `content_type:` 上传文件的 `Content Type`
         - `content:` 上传文件的原始内容。
      8. `request.user`，是一个`django.contrib.auth.models.User`对象，代表当前登陆的用户。如果访问用户当前没有登陆，`user`将被初始化为`django.contrib.auth.models.AnonymousUser`的实例。可以通过user的is_authenticated()方法来辨别用户是否登陆：if request.user.is_authenticated();只有激活Django中的AuthenticationMiddleware时该属性才可用。

      9. `request.session`，唯一可读写的属性，代表当前会话的字典对象；自己有激活`Django`中的`session`支持时该属性才可用

      10. `request.GET.get('name')`，获取`GET`请求里`name`的值，如果某个键对应有多个值，则不能直接用`get`取值，需要用`getlist`，如：`request.POST.getlist("hobby")`。

    二、`HttpResponse`响应对象方法和属性。

      对于`HttpRequest`请求对象来说，是由`Django`自动创建的，但是，`HttpResponse`响应对象就必须我们自己创建。每个`view`请求处理方法必须返回一个`HttpResponse`响应对象。`HttpResponse`类在`django.http.HttpResponse`。

    HttpResponse对象的常用方法：

    1. render函数。将指定页面渲染后返回给浏览器。

        >`render(request, template_name[, context]）`

        结合一个给定的模板和一个给定的上下文字典，并返回一个渲染后的HttpResponse对象。

        ```python
        def index(request):
            blog_index = models.Article.objects.all().order_by('-id')
            print(request.body)
            context = {
                'blog_index':blog_index,
            }
            return render(request, 'index.html',context)
        ```

        参数：

        `request`： 用于生成响应的请求对象。

        `template_name`：要使用的模板的完整名称，可选的参数
        `context`：添加到模板上下文的一个字典。默认是一个空字典。如果字典中的某个值是可调用的，视图将在渲染模板之前调用它。

        `content_type`：生成的文档要使用的MIME类型。默认为DEFAULT_CONTENT_TYPE 设置的值。

        `status`：响应的状态码。默认为200。

        `render`方法主要是将从服务器提取的数据，填充到模板中，然后将渲染后的html静态文件返回给浏览器。这里一定要注意：render渲染的是模板。

        举例：

        ```python
        # index.html
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <title>博客首页</title>
        </head>
        <body>
        <div style="margin: 0 auto">
            <ul>
            <h3>最新文章</h3>
                {% for x in blog_index %}
                <li>{{ x.title }}</li>
                {% endfor %}
            </ul>
        </div>
        </body>
        </html>
        ```

        上面 `{% for x in blog_index %}`到`{% endfor %}`之间包括的就是我们要从数据库取出的数据，进行填充。对于这样一个没有填充数据的`html`文件，浏览器是不能进行渲染的，所以，对于上述`{% for x in blog_index %}`到`{% endfor %}`之间的内容先要被`render`进行渲染之后，才能发送给浏览器。

        ```python
        # views.py
        def index(request):
            blog_index = models.Article.objects.all().order_by('-id')#从数据库中取出文章数据
            print(request.body)
            context = {
                'blog_index':blog_index,#将数据保存在blog_index
            }
            return render(request, 'index.html',context)#通过render进行模板渲染
        ```

    2. `redirect`函数，多用于页面跳转。

        redirect的参数可以是：

        一个模型：将调用模型的`get_absolute_url()` 函数

        一个视图，可以带有参数：将使用`urlresolvers.reverse` 来反向解析名称

        一个绝对的或相对的`URL`，将原封不动的作为重定向的位置。
        默认返回一个临时的重定向；传递`permanent=True` 可以返回一个永久的重定向。

        示例：

        传递一个对象，将调用get_absolute_url() 方法来获取重定向的URL：

        ```python
        from django.shortcuts import redirect
        def my_view(request):
            ...
            object = MyModel.objects.get(...)
            return redirect(object)
        ```

        传递一个视图的名称，可以带有位置参数和关键字参数；将使用reverse() 方法反向解析URL：

        ```python
        def my_view(request):
            ...
            return redirect('some-view-name', foo='bar')
        ```

        传递要重定向的一个硬编码的URL：

        ```python
        def my_view(request):
            ...
            return redirect('/some/url/')
        ```

        也可以是一个完整的URL：

        ```python
        def my_view(request):
            ...
            return redirect('https://www.django.cn/')
        ```

        默认情况下，`redirect()` 返回一个临时重定向。以上所有的形式都接收一个`permanent` 参数；如果设置为`True`，将返回一个永久的重定向：

        ```python
        ef my_view(request):
            ...
            object = MyModel.objects.get(...)
            return redirect(object, permanent=True)　　
        ```

        render和redirect两者区别:

        1. 假如render返回一个登陆成功后的页面，刷新该页面将回复到跳转前页面。而redirect则不会

        2. 如果页面需要模板语言渲染,需要的将数据库的数据加载到html,那么render方法则不会显示这一部分，render返回一个登陆成功页面，不会经过url路由分发系统，也就是说，不会执行跳转后url的视图函数。这样，返回的页面渲染不成功；而redirect是跳转到指定页面，当登陆成功后，会在url路由系统进行匹配，如果有存在的映射函数，就会执行对应的映射函数。

- 模板层

- command
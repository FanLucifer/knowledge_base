# Django REST Framework (DRF) Summary

- 参考链接

  [RESTful API 最佳实践](http://www.ruanyifeng.com/blog/2018/10/restful-api-best-practices.html)

  [RESTful API Design](https://blog.florimond.dev/restful-api-design-13-best-practices-to-make-your-users-happy)

  [Django REST framework](https://www.django-rest-framework.org/)

## 安装

- 要求 (Requirements)

  REST framework 需要以下内容：

  - Python (2.7, 3.4, 3.5, 3.6, 3.7)
  - Django (1.11, 2.0, 2.1)

- 安装 (Installation)

  使用 pip 安装，包括想要的任何可选包

    ```python
    pip install djangorestframework
    pip install markdown       # 对可浏览 API 的 Markdown 支持。
    pip install django-filter  # 过滤支持
    ```

  ...或者从 github 克隆项目。

  >`git clone git@github.com:encode/django-rest-framework.git`

  将 `'rest_framework'` 添加到 `Django` `settings` 文件的`INSTALLED_APPS` 设置中。

    ```python
    INSTALLED_APPS = (
        ...
        'rest_framework',
    )
    ```

    如果你打算使用可浏览的 `API`，您可能还需要添加 `REST framework` 的登录和注销视图。将以下内容添加到根 `urls.py` 文件中。

    ```python
    urlpatterns = [
        ...
        url(r'^api-auth/', include('rest_framework.urls'))
    ]
    ```

    请注意，URL路径可以是您想要的任何内容。

## API

- Requests

  `REST framework` 的 `Request` 类扩展了标准的 `HttpRequest`，增加了对 `REST framework` 灵活的请求解析和请求认证的支持。

  - 请求解析

      `REST framework` 的 `Request` 对象提供了灵活的请求解析，允许您使用 JSON 数据或其他媒体类型像通常处理表单数据相同的方式处理请求。

    - `.data`

      `request.data` 返回请求主体的解析内容。这与标准的 `request.POST` 和 `request.FILES` 属性类似，除了：

      它包括所有解析的内容，包括文件和非文件输入。

      它支持解析 POST 以外的 HTTP 方法的内容，这意味着您可以访问 PUT 和 PATCH 请求的内容。

      它支持 REST framework 的灵活请求解析，而不仅仅是支持表单数据。例如，您可以像处理传入表单数据一样处理传入的 JSON 数据。

    - `.query_params`

      `request.query_params` 是 `request.GET` 更准确的命名同义词。

      为了使代码内部更清晰，我们推荐使用 `request.query_params` 而不是 `Django` 的标准`request.GET`。这样做有助于保持您的代码库更加正确和明显 —— 任何 `HTTP` 方法类型都可能包含查询参数，而不仅仅是 `GET` 请求。

  - Authentication

    `REST framework` 提供灵活的每个请求认证，使您能够：

    1. 为您的 `API` 的不同部分使用不同的身份验证策略。

    2. 支持使用多个身份验证策略。

    3. 提供与传入请求关联的用户和token信息。

    - `.user`

        `request.user` 通常会返回 `django.contrib.auth.models.User` 的一个实例，但其行为取决于正在使用的身份验证策略。

        如果请求未经身份验证，则 `request.user` 的默认值是 `django.contrib.auth.models.AnonymousUser` 的实例。

    - `.auth`

      `request.auth` 返回任何附加的认证上下文。`request.auth` 的确切行为取决于正在使用的身份验证策略，但它通常可能是请求通过身份验证的token实例。

      如果请求未经身份验证，或者没有附加上下文，则 `request.auth` 的默认值为 `None`。

  注意：

  调用 `.user` 或 `.auth` 属性时可能会引发 `WrappedAttributeError` 异常。这些错误源自认证器 `(authenticator)` 作为标准 `AttributeError`，但是为了防止它们被外部属性访问修改，有必要重新设置为不同的异常类型。`Python` 将无法识别来自认证器 `(authenticator)` 的 `AttributeError`，并会立即假定请求对象没有 `.user` 或 `.auth` 属性。认证器 `(authenticator)` 需要修复。

- Responses

    `REST framework` 通过提供一个 `Response` 类来支持 `HTTP` 内容协商，该类允许您根据客户端请求返回可渲染为多种内容类型的内容。

    `Response` 类的子类是 `Django` 的 `SimpleTemplateResponse`。响应对象使用数据进行初始化，数据应由本地 `Python` 基元组成。`REST framework` 然后使用标准的 `HTTP` 内容协商来确定它如何渲染最终响应内容。

    您不需要使用 `Response` 类，如果需要，也可以从视图中返回常规的 `HttpResponse` 或 `StreamingHttpResponse` 对象。使用 `Response` 类只是为返回内容协商的 `Web API` 响应提供更好的接口，这些响应可以渲染为多种格式。

    除非出于某种原因需要大量定制 `REST framework`，否则应始终对返回 `Response` 对象的视图使用 `API​​View` 类或 `@api_view` 函数。这样做可以确保视图执行内容协商，并在视图返回之前为响应选择适当的渲染器。

  - 创建 responses

    语法：

    >`Response(data, status=None, template_name=None, headers=None, content_type=None)`

    与常规 `HttpResponse` 对象不同，您不会使用渲染的内容实例化 `Response` 对象。相反，您传递的是未渲染的数据，可能由任何 `Python` 基元组成。

    由于 `Response` 类使用的渲染器不能处理复杂的数据类型，例如 `Django` 模型实例，所以需要在创建 `Response` 对象之前将数据序列化为基本数据类型。

    您可以使用 `REST framework` 的 `Serializer` 类来执行数据序列化，或者使用您自己的自定义序列化。

    参数：

    - `data` ：响应的序列化数据。
    - `status` ：响应的状态代码。默认为200。另请参阅状态代码。
    - `template_name` ：选择 `HTMLRenderer` 时使用的模板名称。
    - `headers` ：响应中使用的 `HTTP headers` 的字典。
    - `content_type` ：响应的内容类型。通常情况下，渲染器会根据内容协商的结果自动设置，但有些情况下需要明确指定内容类型。
- 标准 HttpResponse 属性

    `Response` 类扩展了 `SimpleTemplateResponse` ，并且响应中也提供了所有常用的属性和方法。例如，您可以用标准方式在响应中设置 `headers：`

    ```python
    response = Response()
    response['Cache-Control'] = 'no-cache'
    ```

- Serializers

  序列化器允许将复杂数据 (如查询集和模型实例) 转换为可以轻松渲染成 `JSON`，`XML` 或其他内容类型的原生 `Python` 数据类型。序列化器还提供反序列化，在验证传入的数据之后允许解析数据转换回复杂类型。

  `REST framework` 中的序列化器与 `Django` 的 `Form` 和 `ModelForm` 类非常相似。我们提供了一个 `Serializer` 类，它为您提供了强大的、通用的方法来控制响应的输出，以及一个 `ModelSerializer` 类，它为创建用于处理模型实例和查询集的序列化器提供了有用的快捷实现方式。

  这里主要介绍 `ModelSerializer` 更多介绍请参阅[官方文档](https://www.django-rest-framework.org/api-guide/serializers/)

  - `ModelSerializer`

    通常，您会希望序列化器类紧密地映射到 `Django` 模型定义上。

    `ModelSerializer` 类提供了一个快捷方式，可以自动创建具有与模型字段对应的字段的 `Serializer` 类。

    `ModelSerializer` 类与常规 `Serializer` 类相同，不同之处在于：

    - 它将根据模型自动为您生成一组字段。
    - 它将自动为序列化器生成验证器，例如 `unique_together` 验证器。
    - 它包含默认简单实现的 `.create()` 和 `.update()` 方法。

    声明 ModelSerializer 如下所示：

    ```python
    class AccountSerializer(serializers.ModelSerializer):
        class Meta:
            model = Account
            fields = ('id', 'account_name', 'users', 'created')
    ```

    默认情况下，类上的所有模型字段都将映射到相应的序列化器字段。

    模型上的任何关系如 (外键) 都将映射到 `PrimaryKeyRelatedField` 。默认情况下不包括反向关系，除非在序列化关系文档中明确包含指定。

  - 检查 ModelSerializer (Inspecting a ModelSerializer)

    序列化器类生成有用的详细表示字符串，允许您全面检查其字段的状态。在使用 `ModelSerializer` 时特别有用，因为您想确定为您自动创建了哪些字段和验证器。

    为此，使用 python manage.py shell 打开 Django shell，然后导入序列化器类，实例化它，并打印对象的表示...

    ```python
    >>> from myapp.serializers import AccountSerializer
    >>> serializer = AccountSerializer()
    >>> print(repr(serializer))
    AccountSerializer():
        id = IntegerField(label='ID', read_only=True)
        name = CharField(allow_blank=True, max_length=100, required=False)
        owner = PrimaryKeyRelatedField(queryset=User.objects.all())
    ```

    指定要包含的字段 (Specifying which fields to include)

    如果您只想在模型序列化器中使用默认字段的子集，则可以使用 `fields` 或 `exclude` 选项，就像使用 `ModelForm` 一样。强烈建议您使用 `fields` 属性显式设置应序列化的所有字段。这将使得在模型更改时不太可能导致无意中暴露数据。

    举个栗子：

    ```python
    class AccountSerializer(serializers.ModelSerializer):
        class Meta:
            model = Account
            fields = ('id', 'account_name', 'users', 'created')
    ```

    你还可以将 fields 属性设置成 `__all__` 来表明使用模型中的所有字段。

    举个栗子：

    ```python
    class AccountSerializer(serializers.ModelSerializer):
        class Meta:
            model = Account
            fields = '__all__'
    ```

    你可以将 `exclude` 属性设置为从序列化器中排除的字段列表。

    举个栗子：

    ```python
    class AccountSerializer(serializers.ModelSerializer):
        class Meta:
            model = Account
            exclude = ('users',)
    ```

    在上面的例子中，如果 `Account` 模型有三个字段 `account_name`，`users` 和 `created` ，那么只有 `account_name` 和 `created` 会被序列化。

    在 `fields` 和 `exclude` 属性中的名称，通常会映射到模型类中的模型字段。

    或者， `fields` 选项中的名称可以映射到不包含模型类中存在的参数的属性或方法。

    从版本 3.3.0 开始，必须提供其中一个属性 `fields` 或 `exclude。`

  - 指定嵌套序列化 (Specifying nested serialization)

    默认的 `ModelSerializer` 使用主键进行关联，但您也可以使用 `depth` 选项轻松的生成嵌套关联：

    ```python
    class AccountSerializer(serializers.ModelSerializer):
        class Meta:
            model = Account
            fields = ('id', 'account_name', 'users', 'created')
            depth = 1
    ```

    `depth` 选项应设置为一个整数值，该值指示在恢复为平面表示之前应该遍历的关系深度。

    如果要自定义序列化的方式，则需要自己定义字段。

- 显式指定字段 (Specifying fields explicitly)

    您可以向 `ModelSerializer` 添加额外字段，或通过在类上声明字段来重写默认字段，就像对 `Serializer` 类一样。

    ```python
    class AccountSerializer(serializers.ModelSerializer):
        url = serializers.CharField(source='get_absolute_url', read_only=True)
        groups = serializers.PrimaryKeyRelatedField(many=True)

        class Meta:
            model = Account
    ```

    额外的字段可以对应模型上任何属性或可调用的 (字段)。

- 指定只读字段 (Specifying read only fields)

    您可能希望将多个字段指定为只读。您可以使用快捷的 `Meta` 选项 `read_only_fields` ，而不是使用 `read_only=True` 属性显式的添加每个字段。

    该选项应该是字段名称的列表或元组，并声明如下：

    ```python
    class AccountSerializer(serializers.ModelSerializer):
        class Meta:
            model = Account
            fields = ('id', 'account_name', 'users', 'created')
            read_only_fields = ('account_name',)
    ```

    模型中已经设置 `editable=False` 的字段和默认就被设置为只读的 `AutoField` 字段都不需要添加到 `read_only_fields` 选项中。

    注意：

    有一种特殊情况，其中只读字段是模型级别 `unique_together` 约束的一部分。在这种情况下，序列化器类需要该字段来验证约束，但也不能由用户编辑。

    处理该问题的正确方法是在序列化器上显式指定该字段，同时提供 `read_only=True` 和 `default=…` 关键字参数。

    其中一个例子是与当前已认证 `User` 的只读关系，它与另一个标识符是 unique_together。在这种情况下，您可以声明用户字段，如下所示：

    ```python
    user = serializers.PrimaryKeyRelatedField(read_only=True, default=serializers.CurrentUserDefault())
    ```

有关 [UniqueTogetherValidator](https://www.django-rest-framework.org/api-guide/validators/#uniquetogethervalidator) 和 [CurrentUserDefault](https://www.django-rest-framework.org/api-guide/validators/#currentuserdefault) 类的详细文档，请查阅[验证器文档](https://www.django-rest-framework.org/api-guide/validators/)。

- 附加关键字参数 (Additional keyword arguments)

  还有一个快捷方式允许您使用 `extra_kwargs` 选项在字段上指定任意附加关键字参数。与 `read_only_fields` 的情况一样，这意味着您不需要在序列化器中显式声明该字段。

  此选项是一个字典，将字段名称映射到关键字参数的字典。例如：

  ```python
  class CreateUserSerializer(serializers.ModelSerializer):
      class Meta:
          model = User
          fields = ('email', 'username', 'password')
          extra_kwargs = {'password': {'write_only': True}}

      def create(self, validated_data):
          user = User(
              email=validated_data['email'],
              username=validated_data['username']
          )
          user.set_password(validated_data['password'])
          user.save()
          return user
  ```

- 关系字段 (Relational fields)

  序列化模型实例时，您可以选择多种不同的方式来表示关联关系。ModelSerializer 的默认表示是使用相关实例的主键。

  替代表示方式包括使用超链接序列化，序列化完整的嵌套表示或者使用自定义表示的序列化。

  有关详细信息，请参阅序列化器关系文档。

- 自定义字段映射 (Customizing field mappings)

  `ModelSerializer` 类还公开了一个可以重写的 `API，以便在实例化序列化器时更改如何自动确定序列化器字段。`

  通常，如果 `ModelSerializer` 默认情况下没有生成你需要的字段，那么您应该将它们显式地添加到类中，或者简单地使用常规的 `Serializer` 类。但是在某些情况下，您可能需要创建一个新的基类，来定义如何为任意给定模型创建序列化字段。

  - `.serializer_field_mapping`

    Django 模型类到 `REST framework` 序列化器类的映射。您可以重写此映射以更改应该用于每个模型类的默认序列化器类。

  - `.serializer_related_field`

    此属性应是序列化器字段类，默认情况下用于关联字段。

    对于 `ModelSerializer` 此属性默认是 `PrimaryKeyRelatedField。`

    对于 `HyperlinkedModelSerializer` 此属性默认是 `serializers.HyperlinkedRelatedField`。

  - `serializer_url_field`

    应该用于序列化器上任何 url 字段的序列化器字段类。

    默认是 `serializers.HyperlinkedIdentityField`

  - `serializer_choice_field`

    应用于序列化器上任何选择字段的序列化器字段类。

    默认是 `serializers.ChoiceField`

- `The field_class` 和 `field_kwargs API`

  调用下面的方法来确定应该自动包含在序列化器中每个字段的类和关键字参数。这些方法都应该返回 (field_class, field_kwargs) 元祖。

  - `.build_standard_field(self, field_name, model_field)`

    调用以生成映射到标准模型字段的序列化器字段。

    默认实现返回基于 `serializer_field_mapping`属性的序列化器类。

  - .build_relational_field(self, field_name, relation_info)

    调用以生成映射到关系模型字段的序列化器字段。

    默认实现返回基于 `serializer_relational_field` 属性的序列化器类。

    `relation_info` 参数是一个命名元祖，包含 `model_field` ，`related_model，to_many` 和 `has_through_model` 属性。

  - `.build_nested_field(self, field_name, relation_info, nested_depth)`

    当设置了 `depth` 选项时，调用以生成映射到关系模型字段的序列化器字段。

    默认实现基于 `ModelSerializer` 或 `HyperlinkedModelSerializer` 动态创建嵌套的序列化器类。

    `nested_depth` 的值是 `depth` 选项的值减 1。

    `relation_info` 参数是一个命名元祖，包含 `model_field` ， `related_model` ， `to_many` 和 `has_through_model` 属性。

  - `.build_property_field(self, field_name, model_class)`

    调用以生成映射到模型类中的属性或零参数方法的序列化器字段。

    默认实现返回 `ReadOnlyField` 类。

  - `.build_url_field(self, field_name, model_class)`

    调用为序列化器自己的 url 字段生成序列化器字段。默认实现返回 HyperlinkedIdentityField 类。

  - .build_unknown_field(self, field_name, model_class)

    当字段名称未映射到任何模型字段或模型属性时调用。默认实现会引发错误，但子类可以自定义此行为。

- [通用视图](http://www.iamnancy.top/djangorestframework/Generic-views/)
- [视图集](http://www.iamnancy.top/djangorestframework/Viewsets/)
- [路由器](http://www.iamnancy.top/djangorestframework/Routers/)

### 附 RESTful API

一. URL 设计

1. 动词 + 宾语

    `RESTful` 的核心思想就是，客户端发出的数据操作指令都是"动词 + 宾语"的结构。比如，`GET /articles`这个命令，`GET`是动词，`/articles`是宾语。

    动词通常就是五种 `HTTP` 方法，对应 `CRUD` 操作。

      - GET：读取（Read）

      - POST：新建（Create）

      - PUT：更新（Update）

      - PATCH：更新（Update），通常是部分更新

      - DELETE：删除（Delete）

        根据 HTTP 规范，动词一律大写。

2. 动词的覆盖

    有些客户端只能使用`GET`和`POST`这两种方法。服务器必须接受`POST`模拟其他三个方法（`PUT`、`PATCH`、`DELETE`）。

    这时，客户端发出的 `HTTP` 请求，要加上`X-HTTP-Method-Override`属性，告诉服务器应该使用哪一个动词，覆盖`POST`方法。

    ```js
    POST /api/Person/4 HTTP/1.1
    X-HTTP-Method-Override: PUT
    ```

    上面代码中，`X-HTTP-Method-Override`指定本次请求的方法是`PUT`，而不是`POST`。

3. 宾语必须是名词

    宾语就是 `API` 的 `URL`，是 `HTTP` 动词作用的对象。它应该是名词，不能是动词。比如，`/articles`这个 `URL` 就是正确的，而下面的 `URL` 不是名词，所以都是错误的。

    - `/getAllCars`
    - `/createNewCar`
    - `/deleteAllRedCars`

4. 复数 `URL`

    既然 `URL` 是名词，那么应该使用复数，还是单数？

    这没有统一的规定，但是常见的操作是读取一个集合，比如`GET /articles`（读取所有文章），这里明显应该是复数。

    为了统一起见，建议都使用复数 `URL`，比如`GET /articles/2`要好于`GET /article/2`。

5. 避免多级 URL

    常见的情况是，资源需要多级分类，因此很容易写出多级的 `URL`，比如获取某个作者的某一类文章。

    >`GET /authors/12/categories/2`

    这种 URL 不利于扩展，语义也不明确，往往要想一会，才能明白含义。

    更好的做法是，除了第一级，其他级别都用查询字符串表达。

    >`GET /authors/12?categories=2`

    下面是另一个例子，查询已发布的文章。你可能会设计成下面的 `URL`。
    >`GET /articles/published`

    查询字符串的写法明显更好。

    >`GET /articles?published=true`

二、状态码

1. 状态码必须精确

    客户端的每一次请求，服务器都必须给出回应。回应包括 HTTP 状态码和数据两部分。

    `HTTP` 状态码就是一个三位数，分成五个类别。

    - 1xx：相关信息
    - 2xx：操作成功
    - 3xx：重定向
    - 4xx：客户端错误
    - 5xx：服务器错误

    这五大类总共包含100多种状态码，覆盖了绝大部分可能遇到的情况。每一种状态码都有标准的（或者约定的）解释，客户端只需查看状态码，就可以判断出发生了什么情况，所以服务器应该返回尽可能精确的状态码。

    API 不需要1xx状态码，下面介绍其他四类状态码的精确含义。

2. 2xx 状态码

    200状态码表示操作成功，但是不同的方法可以返回更精确的状态码。

    - GET: 200 OK
    - POST: 201 Created
    - PUT: 200 OK
    - PATCH: 200 OK
    - DELETE: 204 No Content

    上面代码中，`POST`返回`201`状态码，表示生成了新的资源；`DELETE`返回`204`状态码，表示资源已经不存在。

    此外，`202 Accepted` 状态码表示服务器已经收到请求，但还未进行处理，会在未来再处理，通常用于异步操作。下面是一个例子。

    ```js
    // HTTP/1.1 202 Accepted

    {
      "task": {
        "href": "/api/company/job-management/jobs/2130040",
        "id": "2130040"
      }
    }
    ```

3. 3xx 状态码

    `API` 用不到301状态码（永久重定向）和`302`状态码（暂时重定向，`307`也是这个含义），因为它们可以由应用级别返回，浏览器会直接跳转，`API` 级别可以不考虑这两种情况。

    API 用到的3xx状态码，主要是`303 See Other`，表示参考另一个 URL。它与`302`和`307`的含义一样，也是"暂时重定向"，区别在于`302`和`307`用于`GET`请求，而`303`用于`POST`、`PUT`和`DELETE`请求。收到`303`以后，浏览器不会自动跳转，而会让用户自己决定下一步怎么办。下面是一个例子。

    ```js
    HTTP/1.1 303 See Other
    Location: /api/orders/12345
    ```

4. 4xx 状态码

    4xx状态码表示客户端错误，主要有下面几种。

    - `400 Bad Request`：服务器不理解客户端的请求，未做任何处理。
    - `401 Unauthorized`：用户未提供身份验证凭据，或 者没有通过身份验证。
    - `403 Forbidden`：用户通过了身份验证，但是不具有访问资源所需的权限。
    - `404 Not Found`：所请求的资源不存在，或不可用。
    - `405 Method Not Allowed`：用户已经通过身份验 证，但是所用的 HTTP 方法不在他的权限之内。
    - `410 Gone`：所请求的资源已从这个地址转移，不再可 用。
    - `415 Unsupported Media Type`：客户端要求的返回 格式不支持。比如，`API` 只能返回 `JSON` 格式，但是 客户端要求返回 `XML` 格式。
    - `422 Unprocessable Entity`：客户端上传的附件无法处理，导致请求失败。
    - `429 Too Many Requests`：客户端的请求次数超过限额。

5. 5xx 状态码

    5xx状态码表示服务端错误。一般来说，`API` 不会向用户透露服务器的详细信息，所以只要两个状态码就够了。

    - `500 Internal Server Error`：客户端请求有效，服务器处理时发生了意外。

    - `503 Service Unavailable`：服务器无法处理请求，一般用于网站维护状态。

三、服务器回应

1. 不要返回纯本文

    `API` 返回的数据格式，不应该是纯文本，而应该是一个 `JSON` 对象，因为这样才能返回标准的结构化数据。所以，服务器回应的 `HTTP` 头的`Content-Type`属性要设为`application/json`。

    客户端请求时，也要明确告诉服务器，可以接受 `JSON` 格式，即请求的 `HTTP` 头的`ACCEPT`属性也要设成`application/json`。下面是一个例子。

    ```js
    GET /orders/2 HTTP/1.1
    Accept: application/json
    ```

2. 发生错误时，不要返回 200 状态码

    有一种不恰当的做法是，即使发生错误，也返回200状态码，把错误信息放在数据体里面，就像下面这样。

    ```js
    HTTP/1.1 200 OK
    Content-Type: application/json

    {
      "status": "failure",
      "data": {
        "error": "Expected at least two items in list."
      }
    }
    ```

    上面代码中，解析数据体以后，才能得知操作失败。

    这张做法实际上取消了状态码，这是完全不可取的。正确的做法是，状态码反映发生的错误，具体的错误信息放在数据体里面返回。下面是一个例子。

    ```js
    HTTP/1.1 400 Bad Request
    Content-Type: application/json

    {
      "error": "Invalid payoad.",
      "detail": {
        "surname": "This field is required."
      }
    }
    ```

3. 提供链接

    `API` 的使用者未必知道，`URL` 是怎么设计的。一个解决方法就是，在回应中，给出相关链接，便于下一步操作。这样的话，用户只要记住一个 `URL`，就可以发现其他的 `URL`。这种方法叫做 `HATEOAS`。

    举例来说，`GitHub` 的 `API` 都在 `api.github.com` 这个域名。访问它，就可以得到其他 `URL`。

    ```js
    {
      ...
      "feeds_url": "https://api.github.com/feeds",
      "followers_url": "https://api.github.com/user/followers",
      "following_url": "https://api.github.com/user/following{/target}",
      "gists_url": "https://api.github.com/gists{/gist_id}",
      "hub_url": "https://api.github.com/hub",
      ...
    }
    ```

    上面的回应中，挑一个 `URL` 访问，又可以得到别的 `URL`。对于用户来说，不需要记住 `URL` 设计，只要从 `api.github.com` 一步步查找就可以了。

    `HATEOAS` 的格式没有统一规定，上面例子中，`GitHub` 将它们与其他属性放在一起。更好的做法应该是，将相关链接与其他属性分开。

    ```js
    HTTP/1.1 200 OK
    Content-Type: application/json

    {
      "status": "In progress",
      "links": {[
        { "rel":"cancel", "method": "delete", "href":"/api/status/12345" } ,
        { "rel":"edit", "method": "put", "href":"/api/status/12345" }
      ]}
    }
    ```

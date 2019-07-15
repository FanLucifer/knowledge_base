# Session 1 关于错误处理
=begin
    
    在程序执行的过程中,通常会有以下错误发生:
        数据错误
            在计算家庭收支的时候,若在应该写金额的一栏上填上了商品名,那么就无法计算。此外, HTML 这种格式的数据的情况下,如果存在没有关闭标签等
            语法错误,也会导致无法处理数据。
        系统错误
            硬盘故障等明显的故障,或者没把 CD 插入到驱动器等程序无法恢复的问题。
        程序错误
            因调用了不存在的方法、弄错参数值或算法错误而导致错误结果等,像这样,程序本身的缺陷也可能会导致错误。
        
    对这些错误做相应的处理:
        排除错误的原因
            在文件夹中创建文件时,如果文件夹不存在,则由程序本身创建文件夹。如果程序无法创建文件夹,则需要再考虑其他解决方法。
        忽略错误
            程序有时候也会有一些无伤大雅的错误。例如,假设运行程序时需要读取某个配置文件,如果我们事前已经在程序中准备好了相应配置的默认值,那么
            即使无法读取该设定文件,程序也可以忽略这个错误。
        恢复错误发生前的状态
            向用户提示程序发生错误,指导用户该如何进行下一步处理。
        重试一次
            曾经执行失败的程序,过一段时间后再重新执行可能就会成功。
        终止程序
            只是自己一个人用的小程序,也许本来就没必要做错误处理。
        
    而至于实际应该采取何种处理,则要根据程序代码的规模、应用程序的性质来决定,不能一概而论。但是,对于可预期的错误,我们需要留意以下两点:
        是否破坏了输入的数据,特别是人工制作的数据。
        是否可以对错误的内容及其原因做出相应的提示。
        
    覆盖了原有文件、删除了花费大量时间输入的数据等,像这样的重要数据的丢失、破坏可以说是灾难性的错误。另外,如果错误是由用户造成的,或者程序
    自身不能修复的话,给用户简明易懂的错误提示,会大大提升程序的用户体验。
        
    Ruby 为我们提供了异常处理机制,可以使我们非常方便地应对各种错误。
=end

# Session 2 异常处理
=begin
    在程序执行的过程中,如果程序出现了错误就会发生异常。异常发生后,程序会暂时停止运行,并寻找是否有对应的异常处理程序。如果有则执行,如果没
    有,程序就会显示类似以下信息并终止运行。
 
    文件名 : 行号 :in 方法名 : 错误信息(异常类名)
        from 文件名 : 行号 : in 方法名
        .
        .
        .

    以 from 开头的行表示发生错误的位置。
    没有异常处理的编程语言的情况下,编程时就需要逐个确认每个处理是否已经处理完毕
    在这类编程语言中,大部分程序代码都被花费在错误处理上,因此往往会使程序变得繁杂。

    异常处理有以下优点:
        程序不需要逐个确认处理结果,也能自动检查出程序错误
        会同时报告发生错误的位置,便于排查错误
        正常处理与错误处理的程序可以分开书写,使程序便于阅读
=end

# Session 3 10.3 异常处理的写法
=begin
    Ruby 中使用 begin~ rescue ~ end 语句描述异常处理。
    begin
        可能会发生异常的处理
    rescue
        发生异常时的处理
    end
    
    在 Ruby 中,异常及其相关信息都是被作为对象来处理的。在 rescue 后指定变量名,可以获得异常对象。
    begin
        可能会发生异常的处理
    rescue => 引用异常对象的变量
        发生异常时的处理
    end
    
    即使不指定变量名, Ruby 也会像把异常对象赋值给变量 $! 。不过,把变量名明确地写出来会使程序更加易懂。

    异常发生时被自动赋值的变量
    变量                    意义
    $!                     最后发生的异常(异常对象)
    $@                     最后发生的异常的位置信息

    异常对象的方法
    方法名                  意义
    class                  异常的种类
    message                异常信息
    backtrace              异常发生的位置信息($@ 与 $!.backtrace 是等价的)
=end

# wc.rb
# 结果会输出参数中指定的各文件的行数、单词数、字数(字节数),最后输出全部文件的统计结果。

ltotal=0                                # 行数合计
wtotal=0                                # 单词数合计
ctotal=0                                # 字数合计
ARGV.each do |file|
    begin
        input = File.open(file)         # 打开文件( A )
        l=0                             # file 内的行数
        w=0                             # file 内的单词数
        c=0                             # file 内的字数
        input.each_line do |line|
            l += 1
            c += line.size
            line.sub!(/^\s+/, "")       # 删除行首的空白符
            ary = line.split(/\s+/)     # 用空白符分解
            w += ary.size
        end
        input.close                     # 关闭文件

        printf("%8d %8d %8d %s\n", l, w, c, file) # 整理输出格式
        
        ltotal += l
        wtotal += w
        ctotal += c
    rescue => ex
        print ex.message, "\n"          # 输出异常信息( B )
    end
end

printf("%8d %8d %8d %s\n", ltotal, wtotal, ctotal, "total")

# Session 4 后处理
=begin
    不管是否发生异常都希望执行的处理,在 Ruby 中可以用 ensure 关键字来定义。
    begin
        有可能发生异常的处理
    rescue => 变量
        发生异常后的处理
    ensure
        不管是否发生异常都希望执行的处理
    end
=end

# eg 现在,假设我们要实现一个拷贝文件的方法,如下所示。
# 下面的 copy 方法是把文件从 from 拷贝到 to 。

def copy(from, to)
    src = File.open(from)                       # 打开原文件 from ( A )
    begin
        dst = File.open(to, "w")                # 打开目标文件 to ( B )
        data = src.read
        dst.write(data)
        dst.close
    ensure
        src.close                               # ( C )
    end
end
            
# 在( A )部分,如果程序不能打开原文件,那么就会发生异常并把异常返回给调用者。
# 这时,不管接下来的处理是否能正常执行,src 都必须得关闭。
# 关闭src 的处理在( C )部分执行。ensure 中的处理,在程序跳出 begin ~ end 部分时一定会被执行。
# 即使( B )中的目标文件无法打开,( C )部分的处理也同样会被执行。

# Session 5 重试

=begin
    在 rescue 中使用 retry 后,begin 以下的处理会再重做一遍。
=end

# 在下面的例子中,程序每隔 10 秒执行一次 File.open ,直到能成功打开文件为止,打开文件后再读取其内容。
# 不过需要注意的是,如果指定了无论如何都不能打开的文件,程序就会陷入死循环中。
file = ARGV[0]
begin
    io = File.open(file)
rescue
    sleep 10
retry
end

data = io.read
io.close


# Session 6 rescue 修饰符
=begin
    与 if 修饰符、unless 修饰符一样,rescue 也有对应的修饰符。
    表达式 1 rescue 表达式 2
    如果表达式 1 中发生异常,表达式 2 的值就会成为整体表达式的值。也就是说,上面的式子与下面的写法是等价的:

    begin
        表达式 1
    rescue
        表达式 2
    end
=end

# 我们再来看看下面的例子:
n = Integer(val) rescue 0

# Integer 方法当接收到 "123" 这种数值形式的字符串参数时,会返回该字符串表示的整数值
# 而当接收到 "abc" 这种非数值形式的字符串参数时,则会抛出异常(在判断字符串是否为数值形式时经常用到此方法)。
# 在本例中,如果 val 是不正确的数值格式,就会抛出异常,而 0 则作为 = 右侧整体表达式的返回值。
# 像这样,这个小技巧经常被用在不需要过于复杂的处理,只是希望简单地对变量赋予默认值的时候。

# Session 7 异常处理语法的补充
=begin
    如果异常处理的范围是整个方法体,也就是说整个方法内的程序都用 begin ~ end 包含的话,
    我们就可以省略 begin 以及 end ,直接书写 rescue 与ensure 部分的程序。
    
    def foo
        方法体
    rescue => ex
        异常处理
    ensure
        后处理
    end
    
    同样,我们在类定义中也可以使用 rescue 以及 ensure 。
    但是,如果类定义途中发生异常,那么异常发生部分后的方法定义就不会再执行了,因此一般我们不会在类定义中使用它们。
    
    class Foo
        类定义
    rescue => ex
        异常处理
    ensure
        后处理
    end
=end

# Session 8 指定需要捕捉的异常
=begin
    当存在多个种类的异常,且需要按异常的种类分别进行处理时,我们可以用多个 rescue 来分开处理。
begin
可能发生异常的处理rescue Exception1, Exception2 => 变量
对 Exception1 或者 Exception2 的处理
rescue Exception3 => 变量
对 Exception3 的处理
rescue
对上述异常以外的异常的处理
end
通过直接指定异常类,可以只捕捉我们希望处理的异常。
=end

# 在本例中,程序如果无法打开 file1 就会打开 file2 。
# 程序中捕捉的 Errno::ENOENT 以及 Errno::EACCES ,分别是文件不存在以及没权限打开文件时发生的异常。

file1 = ARGV[0]
file2 = ARGV[1]
begin
    io = File.open(file1)
rescue Errno::ENOENT, Errno::EACCES
    io = File.open(file2)
end

# Session 9 异常类
=begin
    之前我们提到过异常也是对象。 Ruby 中所有的异常都是 Exception 类的子类,并根据程序错误的种类来定义相应的异常。
    Ruby 标准库中的异常类的继承关系。

    Exception
        |----SystemExit
        |----NoMemoryError
        |----SignalException
        |----ScriptError
        |       |----LoadError
        |       |----SyntaxError
        |       |----NotImplementedError
        |----StandarError
                |----RuntimeError
                |----SecurityError
                |----NameError
                |       |----NoMethodError
                |----IOError
                |       |----EOFError
                |----SystemCallError
                |       |---Errno::EPERM
                |       |----Error::ENOENT
                
                ...

=end

# 在 rescue 中指定的异常的种类实际上就是异常类的类名。
# rescue 中不指定异常类时,程序会默认捕捉 StandardError 类及其子类的异常。
# rescue 不只会捕捉指定的异常类,同时还会捕捉其子类。
# 因此,我们在自己定义异常时,一般会先定义继承 StandardError 类的新类,然后再继承这个新类。


MyError = Class.new(StandardError)              # 新的异常类      
MyError1 = Class.new(MyError)
MyError2 = Class.new(MyError)
MyError3 = Class.new(MyError)

# 这样定义后,通过以下方式捕捉异常的话,同时就会捕捉 MyError 类的子类 MyError1 、MyError2 、MyError3 等。

=begin
    begin
    ┊
    rescue MyError
    ┊
    end
=end

# 在本例中,
# MyError = Class.new(StandardError)
# 上述写法的作用是定义一个继承 StandardError 类的新类,并将其赋值给 MyError 常量。
# 这与使用在第 8 章中介绍过的 class 语句定义类的效果是一样的。
#   class MyError < StandardError
#   end
# 使用 class 语句,我们可以进行定义方法等操作,但在本例中,由于我们只需要生成继承 StandardError 类的新类就可以了,
# 所以就向大家介绍了这个只需 1 行代码就能实现类的定义的简洁写法。

# Session 10 主动抛出异常
=begin
    使用 raise 方法,可以使程序主动抛出异常。
    在基于自己判定的条件抛出异常,或者把刚捕捉到的异常再次抛出并通知异常的调用者等情况下,我们会使用raise 方法。
    raise 方法有以下 4 种调用方式:
        raise message
            抛出 RuntimeError 异常,并把字符串作为 message 设置给新生成的异常对象。
        raise 异常类
            抛出指定的异常。
        raise 异常类, message
            抛出指定的异常,并把字符串作为 message 设置给新生成的异常对象。
        raise
            在 rescue 外抛出 RuntimeError 。在 rescue 中调用时,会再次抛出最后一次发生的异常($! )。
=end





# MySql Stored Procedure

- 参考文章：

    [MySQL存储过程的创建及调用](https://www.cnblogs.com/geaozhang/p/6797357.html)

    [mysql存储过程详细教程](http://blog.sina.com.cn/s/blog_86fe5b440100wdyt.html)

    [MySql 存储过程](https://www.runoob.com/w3cnote/mysql-stored-procedure.html)

## 一 MySql 存储过程

1. 简介

    MySQL 5.0 版本开始支持存储过程。

    存储过程（Stored Procedure）是一种在数据库中存储复杂程序，以便外部程序调用的一种数据库对象。

    存储过程是为了完成特定功能的SQL语句集，经编译创建并保存在数据库中，用户可通过指定存储过程的名字并给定参数(需要时)来调用执行。

    存储过程思想上很简单，就是数据库 SQL 语言层面的代码封装与重用。
2. 优点
   - 存储过程可封装，并隐藏复杂的商业逻辑。
   - 存储过程可以回传值，并可以接受参数。
   - 存储过程无法使用 SELECT 指令来运行，-因为它是子程序，与查看表，数据表或用户定义函数不同。
   - 存储过程可以用在数据检验，强制实行商业逻辑等
3. 缺点
   - 存储过程，往往定制化于特定的数据库上，因为支持的编程语言不同。当切换到其他厂商的数据库系统时，需要重写原有的存储过程。
   - 存储过程的性能调校与撰写，受限于各种数据库系统。

## 二 存储过程的创建和调用

存储过程就是具有名字的一段代码，用来完成一个特定的功能。

创建的存储过程保存在数据库的数据字典中。

1. 创建存储过程

    ```sql
    CREATE
        [DEFINER = { user | CURRENT_USER }]
      PROCEDURE sp_name ([proc_parameter[,...]])
        [characteristic ...] routine_body

    proc_parameter:
        [ IN | OUT | INOUT ] param_name type

    characteristic:
        COMMENT 'string'
      | LANGUAGE SQL
      | [NOT] DETERMINISTIC
      | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
      | SQL SECURITY { DEFINER | INVOKER }

    routine_body:
      Valid SQL routine statement

    [begin_label:] BEGIN
      　　[statement_list]
      　　　　……
    [end_label:] END

    ```

    MYSQL 存储过程中的关键语法
      - 声明语句结束符，可以自定义:

        ```sql
        DELIMITER $$
        ```

      - 声明存储过程:

        ```sql
        CREATE PROCEDURE demo_in_parameter(IN p_in int)
        ```

      - 存储过程开始和结束符号:

        ```sql
        BEGIN
          ...
        END
        ```

      - 变量赋值和定义：

        ```sql
        # 变量声明
        DECLARE l_int int unsigned default 400;
        DECLARE s_text text default "";
        DECLARE c_int int;

        # 变量赋值
        SET l_in = 1
        SELECT COUNT(*) INTO c_int FROM `test`
        ```

2. 调用存储过程

    ```sql
    call sp_name[(传参)];
    ```

## 三 存储过程的参数

MySQL存储过程的参数用在存储过程的定义，共有三种参数类型,`IN`,`OUT`,`INOUT`,形式如：

> `CREATEPROCEDURE 存储过程名([[IN |OUT |INOUT ] 参数名 数据类形...])`

- `IN` 输入参数：表示调用者向过程传入值（传入值可以是字面量或变量）
- `OUT` 输出参数：表示过程向调用者传出值(可以返回多个值)（传出值只能是变量）
- `INOUT` 输入输出参数：既表示调用者向过程传入值，又表示过程向调用者传出值（值只能是变量）

1. `in` 输入参数

    ```sql
    mysql> delimiter $$
    mysql> create procedure in_param(in p_in int)
        -> begin
        -> 　　select p_in;
        -> 　　set p_in=2;
        ->    select P_in;
        -> end$$
    mysql> delimiter ;

    mysql> set @p_in=1;

    mysql> call in_param(@p_in);
    +------+
    | p_in |
    +------+
    |    1 |
    +------+

    +------+
    | P_in |
    +------+
    |    2 |
    +------+

    mysql> select @p_in;
    +-------+
    | @p_in |
    +-------+
    |     1 |
    +-------+
    ```

    p_in 在存储过程中被修改，但并不影响 @p_in 的值，因为前者为局部变量、后者为全局变量。

2. `out`输出参数

    ```sql
    mysql> delimiter //
    mysql> create procedure out_param(out p_out int)
        ->   begin
        ->     select p_out;
        ->     set p_out=2;
        ->     select p_out;
        ->   end
        -> //
    mysql> delimiter ;

    mysql> set @p_out=1;

    mysql> call out_param(@p_out);
    +-------+
    | p_out |
    +-------+
    |  NULL |
    +-------+
    # 因为out是向调用者输出参数，不接收输入的参数，所以存储过程里的p_out为null
    +-------+
    | p_out |
    +-------+
    |     2 |
    +-------+

    mysql> select @p_out;
    +--------+
    | @p_out |
    +--------+
    |      2 |
    +--------+
    # 调用了out_param存储过程，输出参数，改变了p_out变量的值
    ```

3. `inout`输入参数

    ```sql
    mysql> delimiter $$
    mysql> create procedure inout_param(inout p_inout int)
        ->   begin
        ->     select p_inout;
        ->     set p_inout=2;
        ->     select p_inout;
        ->   end
        -> $$
    mysql> delimiter ;

    mysql> set @p_inout=1;

    mysql> call inout_param(@p_inout);
    +---------+
    | p_inout |
    +---------+
    |       1 |
    +---------+

    +---------+
    | p_inout |
    +---------+
    |       2 |
    +---------+

    mysql> select @p_inout;
    +----------+
    | @p_inout |
    +----------+
    |        2 |
    +----------+
    # 调用了inout_param存储过程，接受了输入的参数，也输出参数，改变了变量
    ```

    注意：

    - 如果过程没有参数，也必须在过程名后面写上小括号

      例：
      > `CREATE PROCEDURE sp_name ([proc_parameter[,...]]) ...`

    - 确保参数的名字不等于列的名字，否则在过程体中，参数名被当做列名来处理

    建议：

   - 输入值使用in参数。
   - 返回值使用out参数。
   - inout参数尽量少用。

## 四 存储过程的变量

1. 变量定义

    局部变量声明一定要放在存储过程体的开始：

    ```sql
    DECLAREvariable_name [,variable_name...] datatype [DEFAULT value];
    ```

    其中，`datatype` 为 `MySQL` 的数据类型，如: `int`, `float`, `date`, `varchar(length)`

    例如:

    ```sql
    DECLARE l_int int unsigned default 4000000;
    DECLARE l_numeric number(8,2) DEFAULT 9.95;
    DECLARE l_date date DEFAULT '1999-12-31';
    DECLARE l_datetime datetime DEFAULT '1999-12-31 23:59:59';
    DECLARE l_varchar varchar(255) DEFAULT 'This will not be padded';
    ```

2. 变量赋值

    >`SET 变量名 = 表达式值 [,variable_name = expression ...]`

3. 用户变量

    在MySQL客户端使用用户变量:

    ```sql
    mysql > SELECT 'Hello World' into @x;
    mysql > SELECT @x;
    +-------------+
    |   @x        |
    +-------------+
    | Hello World |
    +-------------+
    mysql > SET @y='Goodbye Cruel World';
    mysql > SELECT @y;
    +---------------------+
    |     @y              |
    +---------------------+
    | Goodbye Cruel World |
    +---------------------+

    mysql > SET @z=1+2+3;
    mysql > SELECT @z;
    +------+
    | @z   |
    +------+
    |  6   |
    +------+
    ```

    在存储过程中使用用户变量

    ```sql
    mysql > CREATE PROCEDURE GreetWorld( ) SELECT CONCAT(@greeting,' World');
    mysql > SET @greeting='Hello';
    mysql > CALL GreetWorld( );
    +----------------------------+
    | CONCAT(@greeting,' World') |
    +----------------------------+
    |  Hello World               |
    +----------------------------+
    在存储过程间传递全局范围的用户变量

    mysql> CREATE PROCEDURE p1()   SET @last_procedure='p1';
    mysql> CREATE PROCEDURE p2() SELECT CONCAT('Last procedure was ',@last_procedure);
    mysql> CALL p1( );
    mysql> CALL p2( );
    +-----------------------------------------------+
    | CONCAT('Last procedure was ',@last_proc       |
    +-----------------------------------------------+
    | Last procedure was p1                         |
    +-----------------------------------------------+
    ```

    注意:

    - 用户变量名一般以@开头
    - 滥用用户变量会导致程序难以理解及管理

## 五 存储过程的流程控制语句

1. 变量作用域

    内部的变量在其作用域范围内享有更高的优先权，当执行到 `end`。变量时，内部变量消失，此时已经在其作用域外，变量不再可见了，应为在存储过程外再也不能找到这个申明的变量，但是你可以通过 `out` 参数或者将其值指派给会话变量来保存其值。

    ```sql
    mysql > DELIMITER //
    mysql > CREATE PROCEDURE proc3()
        -> begin
        -> declare x1 varchar(5) default 'outer';
        -> begin
        -> declare x1 varchar(5) default 'inner';
          -> select x1;
          -> end;
          -> select x1;
        -> end;
        -> //
    mysql > DELIMITER ;
    ```

2. 条件语句

    1. if-then-else 语句

        ```sql
        mysql > DELIMITER //
        mysql > CREATE PROCEDURE proc2(IN parameter int)
            -> begin
            -> declare var int;
            -> set var=parameter+1;
            -> if var=0 then
            -> insert into t values(17);
            -> end if;
            -> if parameter=0 then
            -> update t set s1=s1+1;
            -> else
            -> update t set s1=s1+2;
            -> end if;
            -> end;
            -> //
        mysql > DELIMITER ;
        ```

    2. case语句：

        ```sql
        mysql > DELIMITER //
        mysql > CREATE PROCEDURE proc3 (in parameter int)
            -> begin
            -> declare var int;
            -> set var=parameter+1;
            -> case var
            -> when 0 then
            -> insert into t values(17);
            -> when 1 then
            -> insert into t values(18);
            -> else
            -> insert into t values(19);
            -> end case;
            -> end;
            -> //
        mysql > DELIMITER ;
        case
            when var=0 then
                insert into t values(30);
            when var>0 then
            when var<0 then
            else
        end case
        ```

3. 循环语句

    1. `while` ···· `end while`

        ```sql
        mysql > DELIMITER //
        mysql > CREATE PROCEDURE proc4()
            -> begin
            -> declare var int;
            -> set var=0;
            -> while var<6 do
            -> insert into t values(var);
            -> set var=var+1;
            -> end while;
            -> end;
            -> //
        mysql > DELIMITER ;
        while 条件 do
            --循环体
        endwhile
        ```

    2. `repeat`···· `end repeat`

        它在执行操作后检查结果，而 while 则是执行前进行检查。

        ```sql
        mysql > DELIMITER //
        mysql > CREATE PROCEDURE proc5 ()
            -> begin
            -> declare v int;
            -> set v=0;
            -> repeat
            -> insert into t values(v);
            -> set v=v+1;
            -> until v>=5
            -> end repeat;
            -> end;
            -> //
        mysql > DELIMITER ;
        repeat
            --循环体
        until 循环条件
        end repeat;
        ```

    3. `loop` ····· `end loop`

        loop 循环不需要初始条件，这点和 while 循环相似，同时和 repeat 循环一样不需要结束条件, leave 语句的意义是离开循环。

        ```sql
        mysql > DELIMITER //
        mysql > CREATE PROCEDURE proc6 ()
            -> begin
            -> declare v int;
            -> set v=0;
            -> LOOP_LABLE:loop
            -> insert into t values(v);
            -> set v=v+1;
            -> if v >=5 then
            -> leave LOOP_LABLE;
            -> end if;
            -> end loop;
            -> end;
            -> //
        mysql > DELIMITER ;
        ```

    4. `LABLES` 标号：

        标号可以用在 `begin` `repeat` `while` 或者 `loop` 语句前，语句标号只能在合法的语句前面使用。可以跳出循环，使运行指令达到复合语句的最后一步。

4. `ITERATE`迭代

    `ITERATE` 通过引用复合语句的标号,来从新开始复合语句:

    ```sql
    mysql > DELIMITER //
    mysql > CREATE PROCEDURE proc10 ()
        -> begin
        -> declare v int;
        -> set v=0;
        -> LOOP_LABLE:loop
        -> if v=3 then
        -> set v=v+1;
        -> ITERATE LOOP_LABLE;
        -> end if;
        -> insert into t values(v);
        -> set v=v+1;
        -> if v>=5 then
        -> leave LOOP_LABLE;
        -> end if;
        -> end loop;
        -> end;
        -> //
    mysql > DELIMITER ;
    ```

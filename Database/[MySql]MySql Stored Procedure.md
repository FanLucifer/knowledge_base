# MySql Stored Procedure

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

## 四 存储过程的变量

## 五 存储过程的流程控制语句

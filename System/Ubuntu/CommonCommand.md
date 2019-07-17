
# Common Command

参考链接：

- [linux命令分类总结](https://www.jianshu.com/p/ae8c8202d48b)

## Ubuntu System

### Network related

1. ifconfig 查看设置网卡参数

    命令格式：`ifconfig [网络设备] [参数]`
    常用

    ```bash
    ifconfig eth0 up/down   启用或关闭指定网卡
    ifconfig eth0      显示网卡信息
    ```

2. ping 测试网络连通性

    Ping命令通过发送Internet控制消息协议（ICMP）回响请求消息来验证与另一台TCP/IP计算机的IP级连接

    格式： `ping [参数] [主机名或IP地址]`

    参数：

    ```bash
    -d 使用Socket的SO_DEBUG功能。
    -f 极限检测。大量且快速地送网络封包给一台机器，看它的回应。
    -n 只输出数值。
    -q 不显示任何传送封包的信息，只显示最后的结果。
    -r 忽略普通的Routing Table，直接将数据包送到远端主机上。通常是查看本机的网络接口是否有问题。
    -R 记录路由过程。
    -v 详细显示指令的执行过程。
    ```

    常用

    ```bash
    ping www.163.com
    ping -R www.163.com
    ```

3. netstat 查看网络状态

    格式: `netstat [option]`

    参数：

    ```bash
    -a： 显示所有
    -n： 以ip形式显示
    -p： 显示进程
    -r： 显示路由表
    -t： 只显示tcp
    -u： 只显示udp
    -i： 显示网络接口
    ```

    常用：

    ```bash
    1 netstat
    2 netstat -nu 只显示udp / -t只显示tcp
    3 netstat -r  显示路由表，作用同route
    ```

    ps. 查看指定端口，可以结合grep命令：
        `netstat -ap | grep 8080`

4. ss 查看网络状态
    ss与netstat命令作用相同，但比netstat更高效，采用的是tcp协议栈中tcp_diag.

    使用方法参考netstat，且基本参数相同

    常用：

    ```bash
    ss -s  查看当前服务器的网络连接统计
    ss -l   查看所有打开的网络端口
    ss -a   查看这台服务器上所有的socket连接
    ```

5. ip 查看设置网卡参数

6. route 查看路由以及添加路由

    格式: `route [option] [action]`

    参数：

    ```bash
    -n 不解析名字
    -v 显示详细的处理信息
    -f 清除所有网关入口的路由表。
    -p 与 add 命令一起使用时使路由具有永久性。
    add:添加一条新路由。
    del:删除一条路由。
    -net:目标地址是一个网络。
    -host:目标地址是一个主机。
    ```

    常用

    ```bash
    route -n  显示路由表
    route add/del default gw 192.168.120.1  删除和添加设置默认网关
    route add -net 172.25.0.0 netmask 255.255.0.0 dev eth0 添加网关
    ```

7. traceroute 查看路由轨迹

    traceroute追踪网络数据包的路由途径

    格式: `traceroute[参数][主机]`

    参数：

    ```bash
    -I 使用ICMP回应取代UDP资料信息。
    -d 使用Socket层级的排错功能。
    -s 设置本地主机送出数据包的IP地址。
    -n 只显示IP
    ```

    常用

    ```bash
    traceroute www.163.com
    traceroute -n www.163.com  显示IP地址，不查主机名
    ```

8. nslookup，dns查看
    nslookup命令用于查询DNS的记录，查看域名解析是否正常，在网络故障的时候用来诊断网络问题

    格式: `nslookup [-qt=type] domain [dns-server]`

    type为 dns的解析记录

    常用

    ```bash
    nslookup  baidu.com
    nslookup -qt=mx 163.com 8.8.8.8
    ```

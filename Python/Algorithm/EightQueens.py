# !/usr/bin/python
# -*- coding: <utf-8> -*-

"""
    八皇后问题
    八皇后问题是一个古老而著名的问题，是回溯算法的典型案例。
    该问题是国际西洋棋棋手马克斯·贝瑟尔于1848年提出：
        在8×8格的国际象棋上摆放八个皇后，使其不能互相攻击
        即任意两个皇后都不能处于同一行、同一列或同一斜线上
        问有多少种摆法
"""

# 定义一些全局变量

global col
global row
global pos_diag
global nag_diag
global count

def output():
    ''' 输出一种有效结果
    '''
    global count
    print row
    count += 1

def do_queen(i):
    ''' 生成所有正确解
    @param i: 皇后的数目
    '''
    for j in range(0, 8):                   #依次尝试0～7位置
        if col[j] == 1 and pos_diag[i-j+7] == 1 and nag_diag[i+j] == 1:
            #若该行，正对角线，负对角线上都没有皇后，则放入i皇后
            row[i] = j
            col[j] = 0                      #调整各个列表状态
            pos_diag[i-j+7] = 0
            nag_diag[i+j] = 0
            if i < 7:
                do_queen(i+1)               #可递增或递减
            else:
                output()                    #产生一个结果，输出
            col[j] = 1                      #恢复各个列表状态为之前的
            pos_diag[i-j+7] = 1
            nag_diag[i+j] = 1

if __name__ == '__main__':
    col = []                                #矩阵列的列表，存储皇后所在列，若该列没有皇后，则相应置为1，反之则0
    row = []                                #矩阵行的列表，存放每行皇后所在的列位置，随着程序的执行，在不断的变化中，之间输出结果
    pos_diag = []                           #正对角线，i-j恒定，-7~0~7，并且b(i)+7统一到0～14
    nag_diag = []                           #负对角线，i+j恒定，0～14
    count = 0
    for index in range(0, 8):               #一些初始化工作
        col.append(1)
        row.append(0)
    for index in range(0, 15):
        pos_diag.append(1)
        nag_diag.append(1)
    do_queen(0)
    #开始递归，先放一个，依次递增，反过来，从7开始递减也可
    print 'Totally have %d solutions!' % count
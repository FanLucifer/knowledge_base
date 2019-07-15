class Point
    attr_reader :x, :y
    def initialize(x=0, y=0)
        @x, @y = x, y
    end
    
    def inspect # 用于显示
        "(#{x}, #{y})"
    end

    def +@
        dup
    end # 返回自己的副本
        
    def -@
        self.class.new(-x, -y)
    end # 颠倒 x 、 y 各自的正负
        
    def ~@
        self.class.new(-y, x)
    end
    
    def +(other) # x 、 y 分别进行加法运算
        self.class.new(x + other.x, y + other.y)
    end
    
    def -(other) # x 、 y 分别进行减法运算
        self.class.new(x - other.x, y - other.y)
    end

    def [](index)
        case index
        when 0
            x
        when 1
            y
        else
            raise ArgumentError, "out of range `#{index}'"
        end
    end
        
    def []=(index, val)
        puts "=============="
        puts "#{index}, #{val}"
        p self.x
        puts "=============="
        case index
        when 0
            self.x = val
        when 1
            self.y = val
        else
            puts "else"
            raise ArgumentError, "out of range `#{index}'"
        end
    end
end
    
point0 = Point.new(3, 6)
    
point1 = Point.new(1, 8)

point = Point.new(3, 6)

    
p point0                    # (3, 6)
p point1                    # (1, 8)
p point0 + point1           # (4, 14)
p point0 - point1           # (2, -2)
p +point                    # (3, 6)
p -point                    # (-3, -6)
p ~point                    # (-6, 3)
p point[0]                  # 3
p point[1]                  # 6

p point[1] = 2

p point[2] = 1              # ArgumentError


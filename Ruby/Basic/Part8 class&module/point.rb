class Point
  attr_accessor :x, :y      # 定义存取器
  protected :x=, :y=        # 把x= 和y= 设定为protected

  def initialize(x=0.0, y=0.0)
    @x, @y = x, y
  end

  def swap(pointer)           # 交换 x, y 值的方法
    tmp_x, tmp_y = @x, @y
    @x, @y = pointer.x, pointer.y
    pointer.x, pointer.y = tmp_x, tmp_y     # 在同一个类中, 可以被调用

    return self
  end
end

p0 = Point.new
p1 = Point.new(1.5, 3)

puts "=============Before swap================="
puts "p0 -> (#{p0.x}, #{p0.y})"
puts "p1 -> (#{p1.x}, #{p1.y})"

p0.swap(p1)

puts "=============After swap================="
puts "p0 -> (#{p0.x}, #{p0.y})"
puts "p1 -> (#{p1.x}, #{p1.y})"

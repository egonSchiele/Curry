class Proc
  def * g
    if g.arity == 0
      lambda { self.call(g.call) }
    else
      vars = (1..(g.arity)).map{|num| "var_#{num}"}.join(",")
      eval "lambda {|#{vars}| self.call(g.call(#{vars})) }"
    end
  end

  def [](*args)
    diff = self.arity - args.size
    if diff == 0
      self.call(*args)
    else
      vars = (1..diff).map{|num| "var_#{num}"}.join(",")      
      eval "lambda {|#{vars}| self.call(*(args + [#{vars}])) }"
    end
  end
end

foldl = lambda do |func, acc, xs|
  xs.each do |x|
    acc = func.call(acc, x)
  end
  acc
end

foldl1 = lambda do |func, xs|
  acc = xs[0]
  xs[1, xs.size].each do |x|
    acc = func.call(acc, x)
  end
  acc
end

foldr = lambda do |func, acc, xs|
  xs.reverse.each do |x|
    acc = func.call(acc, x)
  end
  acc
end

foldr1 = lambda do |func, xs|
  xs = xs.reverse
  acc = xs[0]
  xs[1, xs.size].each do |x|
    acc = func.call(acc, x)
  end
  acc
end

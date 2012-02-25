
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
    # do this? or throw an error on diff < 0 ?
    if diff <= 0
      self.call(*args)
    else
      vars = (1..diff).map{|num| "var_#{num}"}.join(",")      
      eval "lambda {|#{vars}| self.call(*(args + [#{vars}])) }"
    end
  end

  def <<(*args)
    self.[](*args)
  end
end

module Curry
  extend self

  def foldl
    lambda do |func, acc, xs|
      xs.each do |x|
        acc = func.call(acc, x)
      end
      acc
    end
  end


  def foldl1
    lambda do |func, xs|
      acc = nil
      xs.each do |x|
        next acc = x unless acc
        acc = func.call(acc, x)
      end
      acc
    end
  end

  def foldr
    lambda do |func, acc, xs|
      xs.reverse.each do |x|
        acc = func.call(acc, x)
      end
      acc
    end
  end

  def foldr1
    lambda do |func, xs|
      acc = nil
      xs.reverse_each do |x|
        next acc = x unless acc
        acc = func.call(acc, x)
      end
      acc
    end
  end

  def map; lambda { |func, xs| xs.map(&func) }; end
  def each; lambda { |func, xs| xs.each(&func) }; end
  def fill; lambda { |func, xs| xs.fill(&func) }; end
  def sort; lambda { |func, xs| xs.sort(&func) }; end
  def select; lambda { |func, xs| xs.select(&func) }; end
  def index; lambda { |func, xs| xs.index(&func) }; end
  def reject; lambda { |func, xs| xs.reject(&func) }; end
  def permutation; lambda { |func, xs| xs.permutation(&func) }; end
  def each_index; lambda { |func, xs| xs.each_index(&func) }; end
  def count; lambda { |func, xs| xs.count(&func) }; end
  def cycle; lambda { |func, xs| xs.cycle(&func) }; end
  def cyclen; lambda { |func, n, xs| xs.cycle(n, &func) }; end
  def zip; lambda{ |func, xs, ys| xs.zip(ys, &func) }; end

  def delete_if; lambda { |func, xs| xs.delete(&func) }; end
  def drop_while; lambda { |func, xs| xs.drop_while(&func) }; end
  def take_while; lambda { |func, xs| xs.take_while(&func) }; end

  def fputs; lambda { |x| puts x }; end
  def fp; lambda { |x| p x }; end
  def fprint; lambda { |x| print x }; end

  # synonyms
  def collect; map; end

  def inject; foldl; end
  def reduce; inject; end

  def inject1; foldl1; end
  def reduce1; inject1; end

  def filter; select; end
  def zipWith; zip; end

  def all; lambda { |func, xs| xs.select(&func).size == xs.size }; end
  def any; lambda { |func, xs| xs.select(&func).size > 0 }; end


  # operators
  def add; lambda { |a, b| a + b }; end
  def sub; lambda { |a, b| a - b }; end
  def mul; lambda { |a, b| a * b }; end
  def div; lambda { |a, b| a / b }; end
  def pow; lambda { |a, b| a ** b }; end
  def eql; lambda { |a, b| a == b }; end
  def gt; lambda { |a, b| b > a }; end
  def gte; lambda { |a, b| b >= a }; end
  def lt; lambda { |a, b| b < a }; end
  def lte; lambda { |a, b| b <= a }; end
  def even; lambda { |a| a % 2 == 0 }; end
  def odd; lambda { |a| !even[a] }; end
  def fnot; lambda { |a| !a }; end


  # converting a proc to a method
  def to_m(name, funcname)
    eval("def #{name}(*args); #{funcname}[*args]; end")
  end

=begin

  Example Usage:
    @__map = map[add[10]]
    to_m("adder", "@__map")
    puts adder([1, 2, 3, 4, 5])

=end
end

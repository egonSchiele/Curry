require 'lib/curry'
include Curry

puts (filter << even << (0..10))
puts (0..10).select(&even)

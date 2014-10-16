def super_print(string, options = {})
  default = {
    :times => 1,
    :upcase => false,
    :reverse => false
  }

  options = default.merge(options)

  string = string * options[:times]

  string.upcase! if options[:upcase]
  string.reverse! if options[:reverse]

  string
end
#
# p super_print("Hello")
# p super_print("Hello")
# p super_print("Hello", :times => 3)
# p super_print("Hello", :upcase => true)
# p super_print("Hello", :upcase => true, :reverse => true)

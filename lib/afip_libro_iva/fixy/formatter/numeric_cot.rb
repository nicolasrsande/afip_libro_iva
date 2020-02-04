module Fixy
  module Formatter
    module NumericCot
      def format_numeric_cot(input, length)
        input = format('%.6f', input).to_s.delete('.')
        raise ArgumentError, "Invalid Input (only digits are accepted)" unless input =~ /^\d+$/
        raise ArgumentError, "Not enough length (input: #{input}, length: #{length})" if input.length > length
        input.rjust(length, '0')
      end
    end
  end
end
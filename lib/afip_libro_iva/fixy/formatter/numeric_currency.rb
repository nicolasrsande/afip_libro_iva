module Fixy
  module Formatter
    module NumericCurrency
      def format_numeric_currency(input, length)
        input = format('%.2f', input).to_s.delete('.')
        raise ArgumentError, "Invalid Input (only digits are accepted)" unless input =~ /^\d+$/
        raise ArgumentError, "Not enough length (input: #{input}, length: #{length})" if input.length > length
        input.rjust(length, '0')
      end
    end
  end
end
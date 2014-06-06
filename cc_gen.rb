class CCNGenerator

  def generate prefix, suffix, size
    number = prefix + "1"*(size-prefix.size-suffix.size) + suffix

    range = (prefix.size..number.size-suffix.size-1)

    normalize(number, range) until verify(number)

    number
  end

  def verify number
    (calculate_sum(number) % 10) == 0
  end

  private

  def calculate_sum number
    parity = number.size % 2

    sum = 0
    index = 0
    number.each_char do |char|
      sum = sum + digit(char.to_i, index, parity)
      index = index + 1
    end

    sum
  end

  def digit digit, index, parity
    digit = digit * 2 if index % 2 == parity
    digit = digit - 9 if digit > 9

    digit
  end

  def normalize number, range
    parity = number.size % 2
    sum = calculate_sum number
    diff = sum % 10

    range.each do |index|
      if index % 2 != parity && diff > 0
        number[index] = digit((number[index, 1].to_i + 1), index, parity).to_s
        diff = diff - 1
      end
    end
  end
end

gen = CCNGenerator.new

cc_number = gen.generate "6334", "0000", 16

p "Credit Card Number: #{cc_number}"

p "Verify: #{gen.verify(cc_number) ? 'OK' : "Fail"}"

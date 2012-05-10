
def generate_credit_card_number prefix, size     
  number = prefix + "1"*(size-prefix.size)
       
  sum = calculate_sum number
        
  while (sum % 10) > 0 do
    normalize number, prefix, (sum % 10)
    
    sum = calculate_sum number
  end

  number
end

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

def normalize number, prefix, diff
  parity = number.size % 2
   
  (prefix.size..(number.size-1)).each do |index|
    if index % 2 != parity && diff > 0
      number[index] = digit((number[index, 1].to_i + 1), index, parity).to_s
      diff = diff - 1
    end
  end
end
  
cc_number = generate_credit_card_number "6334", 16

p cc_number


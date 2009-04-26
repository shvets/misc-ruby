#$KCODE='a'

text =' Ά£¤¥¦§¨©ª«¬­®―ΰαβγδεζηθιμνξο' 
#'€‚ƒ„…†‡‰‹‘’“”•–—™'
# Ά£¤¥¦§¨©ª«¬­®―ΰαβγδεζηθιμνξο'

text.each_char do |ch|
  
  puts "#{ch} -- #{ch[0]}"

end



€ -- 128
 -- 129
‚ -- 130
ƒ -- 131
„ -- 132
… -- 133
† -- 134
‡ -- 135
 -- 136
‰ -- 137
 -- 138
‹ -- 139
 -- 140
 -- 141
 -- 142
 -- 143

 -- 144
‘ -- 145
’ -- 146
“ -- 147
” -- 148
• -- 149
– -- 150
— -- 151
 -- 152
™ -- 153
 -- 156
 -- 157
 -- 158
 -- 159


  -- 160
Ά -- 162
£ -- 163
¤ -- 164
¥ -- 165
¦ -- 166
§ -- 167
¨ -- 168
© -- 169
ª -- 170
« -- 171
¬ -- 172
­ -- 173
® -- 174
― -- 175

ΰ -- 224
α -- 225
β -- 226
γ -- 227
δ -- 228
ε -- 229
ζ -- 230
η -- 231
θ -- 232
ι -- 233

μ -- 236
ν -- 237
ξ -- 238
ο -- 239


      title.chars.each_with_index do |ch, index|
        puts "#{ch} -- #{ch[0]}"


        title[index] = (ch[0] - 33).chr if (193..193).include? ch[0]
        title[index] = (ch[0] - 32).chr if (196..197).include? ch[0]
        title[index] = (ch[0] - 36).chr if (199..199).include? ch[0]

        title[index] = (ch[0] + 29).chr if (200..200).include? ch[0]
        title[index] = (ch[0] - 33).chr if (201..208).include? ch[0]
        title[index] = (ch[0] + 30).chr if (209..209).include? ch[0]

        title[index] = (ch[0] + 14).chr if (211..213).include? ch[0]
        title[index] = (ch[0] - 48).chr if (214..214).include? ch[0]
        title[index] = (ch[0] - 53).chr if (215..215).include? ch[0]
        title[index] = (ch[0] + 20).chr if (216..216).include? ch[0]
        title[index] = (ch[0] - 51).chr if (218..218).include? ch[0]
        title[index] = (ch[0] + 13).chr if (219..219).include? ch[0]

        title[index] = (ch[0] + 9).chr if (222..222).include? ch[0]
        title[index] = (ch[0] - 97).chr if (225..225).include? ch[0]
        title[index] = (ch[0] + 14).chr if (226..227).include? ch[0]
        title[index] = (ch[0] - 96).chr if (229..229).include? ch[0]
        title[index] = (ch[0] - 100).chr if (231..231).include? ch[0]
        title[index] = (ch[0] - 65).chr if (235..235).include? ch[0]
        title[index] = (ch[0] - 97).chr if (240..240).include? ch[0]

        title[index] = (ch[0] - 82).chr if (241..241).include? ch[0]
        title[index] = (ch[0] - 98).chr if (244..244).include? ch[0]

        title[index] = (ch[0] - 115).chr if (250..250).include? ch[0]
      end

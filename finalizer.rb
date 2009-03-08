require 'fileutils'

class Bar
        def initialize(file_name)
                @file_name = file_name.dup # запоминаем имя файла
                FileUtils.touch(@file_name) # создаем файл
                ObjectSpace.define_finalizer(self, Bar.finilazer(@file_name))
        end     

        def Bar.finilazer(file_name)
                lambda {
                        puts "Remove file '#{file_name}'"
                        FileUtils.rm(file_name) # удалим файл
                }
        end
end

b = Bar.new('temp.txt')


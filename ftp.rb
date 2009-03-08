require 'net/ftp'

# Устанавливаес соединение с FTP сервером
session = Net::FTP.new( ftp_server, ftp_login, ftp_password )

# Указываем, что файлы надо воспринимать как бинарные
session.binary = true

# Переводим клиента в пассивный режим
session.passive = true

# Перемещаемся в заданный каталог на FTP сервере
files = session.chdir( 'ruby ftp example' )

# Отправляем файл на сервер
session.putbinaryfile('file_name')

# Закрываем соединение
session.close

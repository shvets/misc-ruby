require 'win32/registry'

def getServicePackString
    Win32::Registry::HKEY_LOCAL_MACHINE.open('SOFTWARE\Microsoft\Windows NT\CurrentVersion') do |reg|
        reg_typ, reg_val = reg.read('CSDVersion')
        return reg_val
    end
end

puts getServicePackString #=> Service Pack 2

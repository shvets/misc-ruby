# see http://rubylearning.com/blog/2010/09/29/an-introduction-to-desktop-apps-with-ruby/

require 'tray_application'; require 'screenshot'

app = TrayApplication.new("Deskshot")
app.icon_filename = 'screenshot.png'
app.item('Take Screenshot')  {Screenshot.capture}
app.item('Exit')              {java.lang.System::exit(0)}
app.run

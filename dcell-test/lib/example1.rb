require 'dcell'

require_relative 'time_service'
require_relative 'my_service'

class File
  def length
    size
  end
end

# DCell.start :id => "node42", :addr => "tcp://127.0.0.1:2042",
#   :registry => {
#     :adapter => 'redis',
#     :host    => 'mycluster.example.org',
#     :port    => 6379,
#     :password => ""
#   }
# 

# TimeService.supervise_as :time_service
# #MyService.supervise_as :my_service
# DCell::InfoService.supervise_as :info_service
  
DCell.start :id => "node1", :addr => "tcp://127.0.0.1:7777"

# DCell.start :id => "node2", :addr => "tcp://127.0.0.1:7778",
#             :directory => {
#               :id => 'node1', 
#               :addr => 'tcp://127.0.0.1:7777'
#             }

# current node
# puts DCell.me.id

p DCell::Node.all

class MyGroup < Celluloid::Group
  # supervise MyActor, :as => :my_actor
  # supervise AnotherActor, :as => :another_actor, :args => [{:start_working_right_now => true}]
  
  supervise TimeService, :as => :time_service
  supervise MyService, :as => :my_service, :args => ["my_name"]
end

MyGroup.run!

time_service = Celluloid::Actor[:time_service]

p "The time is: #{time_service.time}."

my_service = Celluloid::Actor[:my_service]
my_service.set_status("OK")
p Celluloid::Actor[:my_service].report

my_service.set_status("Fail")
future_report = my_service.future :report
p future_report.value


node1 = DCell::Node["node1"]
p node1.all

info_service = node1[:info]

p info_service.to_hash


# node2 = DCell::Node["node2"]
# p node2.all

require 'dcell/explorer'

DCell::Explorer.new("localhost", 8000)


#sleep




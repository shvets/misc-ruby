class MyService
  include Celluloid

  def initialize(name)
    @name = name
  end

  def set_status(status)
    @status = status
  end

  def report
    "Status for #{@name} is #{@status}."
  end
end
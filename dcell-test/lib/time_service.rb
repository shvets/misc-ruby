class TimeService
  include Celluloid

  def time
    Time.now
  end
end
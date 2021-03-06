
class Oystercard
  attr_reader :balance, :entry_station, :history, :exit_station

  MAX_MONEY = 90
  MIN_MONEY = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @history = []
  end

  def topup(value)
    fail "Your balance cannot go over £#{Oystercard::MAX_MONEY}." if @balance + value > MAX_MONEY
    @balance += value
  end

  def touch_in(station)
    fail "min. balance of £#{Oystercard::MIN_MONEY} not reached" if @balance <= MIN_MONEY
    @entry_station = station
  end

  def touch_out(station)
    @exit_station = station
    deduct(MINIMUM_FARE)
    @history << {
      :entry_station => @entry_station,
      :exit_station => @exit_station
      }
    @entry_station = nil
  end

  def on_journey?
    !!entry_station
  end

  private
  def deduct(fare)
    @balance -= fare
  end

end

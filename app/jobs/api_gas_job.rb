class ApiGasJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    def calculate

      base = 1,30 + (rand(0..10)/10)

      if @event_time.hour  >=  6 and @event_time.hour  <  7 and @event_time.min <= 30
        return base * 1,5
      elsif @event_time.hour  >= 6 and @event_time.min > 30 and @event_time.hour  <= 8 and  @event_time.min <= 30
        return base * 2
      elsif @event_time.hour  >= 8 and @event_time.min > 30 and @event_time.hour  <= 9 and  @event_time.min <= 00
        return base * 1
      elsif @event_time.hour  >= 9 and @event_time.min > 00 and @event_time.hour  <= 9 and  @event_time.min <= 59
        return base * 1,2
      elsif @event_time.hour  >= 10 and @event_time.min > 00 and @event_time.hour  <= 10 and  @event_time.min <= 30
        return base * 1,5
      elsif @event_time.hour  >= 11 and @event_time.min > 00 and @event_time.hour  <= 17 and  @event_time.min <= 30
        return base * 1
      elsif @event_time.hour  >= 17 and @event_time.min > 30 and @event_time.hour  <= 18 and  @event_time.min <= 00
        return base * 1,5
      elsif @event_time.hour  >= 18 and @event_time.min > 00 and @event_time.hour  <= 22 and  @event_time.min <= 30
        return base * 2
      else
        return base * 1
      end

    end


    #  uncomment when ready start_time = Time.now - ((60 * 60 * 24)* 10)



    start_time = Consumption.last.stamp + 300

    # create gas datas
    gas_temp_night = 16
    gas_temp_present = 20
    gas_temp_day = 18


    # create gas datas

    @event_time = start_time
    p "start"

    loop do

      Consumption.create( energy: 'gas', stamp:@event_time, value: 10 , alwayson: 12)

      p @event_time

      p "done"
      @event_time = @event_time + (60 *5) + rand(0..30).to_i

      break if @event_time > Time.now
    end

  end
end




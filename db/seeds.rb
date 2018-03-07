# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_base

  Type.delete_all
  Action.delete_all

  Brand.delete_all
  House.delete_all


  puts "starting House seed"

  House.delete_all

  House.create( name: 'Home sweet home')

  puts "House seed completed"

  puts "starting brand seed"



  Brand.create( name: 'Google Nest')
  Brand.create( name: 'Philips Hue')

  puts "brand seed completed"

  puts "starting object type seed"




  # creation thermostat

  puts "creation type thermostat"
  puts "enter user"
  user = "toto"
  puts "enter password"
  pwd = "password"
  Type.create( name: 'Thermostat', method:'nest_thermostat', key_user: user, key_password: pwd, brand_id: Brand.first[:id])

# creation camera

  puts "creation type camera"
  puts "enter user"
  user = "toto"
  puts "enter password"
  pwd = "password"

  Type.create( name: 'Camera', method:'nest_camera', key_user: user, key_password: pwd, brand_id: Brand.first[:id])

# creation lampes

  puts "creation type lampes"
  puts "enter user"
  user = "toto"
  puts "enter password"
  pwd = "password"
  Type.create( name: 'Lampes', method:'philips_lampes', key_user: user, key_password: pwd, brand_id: Brand.last[:id])


  puts "type  seed completed"


  puts "starting action seed"



  puts "create action on nest thermostat"

  Action.create( name: 'Augmenter température', api_param: 'puts nest.temperature           # => 99.00', type_id:  Type.where("types.name = 'Thermostat'").first.brand_id)
  Action.create( name: 'Baisser température', api_param: 'puts nest.temperature           # => 00.00', type_id: Type.where("types.name = 'Thermostat'").first.brand_id)

  puts "create action on nest camera"

  Action.create( name: 'Afficher Camera', api_param: 'je sais pas encore' , type_id: Type.where("types.name = 'Camera'").first.brand_id)
  Action.create( name: 'Effacer Camera', api_param: 'je sais pas encore' , type_id: Type.where("types.name = 'Camera'").first.brand_id)

  puts "create action on philipshue"

  Action.create( name: 'off', api_param: '  {"on":false}' , type_id: Type.where("types.name = 'Lampes'").first.brand_id)
  Action.create( name: 'on', api_param: ' {"on":true}' , type_id: Type.where("types.name = 'Lampes'").first.brand_id)


puts "action seed completed"



end


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



  create_base


  Consumption.delete_all

#  uncomment when ready start_time = Time.now - ((60 * 60 * 24)* 10)
start_time = Time.now - (36000)

# create gas datas
gas_temp_night = 16
gas_temp_present = 20
gas_temp_day = 18


# create gas datas

@event_time = start_time
p "start"

loop do

  Consumption.create( energy: 'gas', stamp:@event_time, value: 10 , alwayson: 12)

  p "done"
  @event_time = @event_time + (60 *5) + rand(0..30).to_i

  break if @event_time > Time.now
end











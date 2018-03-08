# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_base

  Device.delete_all
  Action.delete_all
  Type.delete_all

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

puts "starting devices seed"

Device.create( name: 'Thermostat Nest', type_id: Type.where("types.name = 'Thermostat'").first.id, house_id: House.first[:id])
Device.create( name: 'Camera Nest', type_id: Type.where("types.name = 'Thermostat'").first.id, house_id: House.first[:id])

Device.create( name: 'Cuisine', type_id: Type.where("types.name = 'Lampes'").first.id, house_id: House.first[:id])
Device.create( name: 'Salon', type_id: Type.where("types.name = 'Lampes'").first.id, house_id: House.first[:id])

puts "devices seed completed"


User.update(:house_id => House.first.id)


end


def calculate_week



  if @event_time.hour  >=  6 && @event_time.hour  <  7

    return @base * 2  unless   @event_time.min > 30
    return @base * 1.5

  end

  if @event_time.hour  >=  7 && @event_time.hour  <  8
    return @base * 1.5

  end

  if @event_time.hour  >=  8 && @event_time.hour  <  9

    return @base * 1.5  unless   @event_time.min > 30
    return @base * 1

  end

  if @event_time.hour  >=  9 && @event_time.hour  <  10

    return @base * 1  unless   @event_time.min > 30
    return @base * 1.5
  end

  if @event_time.hour  >=  10 && @event_time.hour  <  17

     return @base * 1
  end
  if @event_time.hour  >=  17 && @event_time.hour  <  18

    return @base * 2  unless   @event_time.min > 30
    return @base * 1

  end
  if @event_time.hour  >=  18 && @event_time.hour  <  22

    return @base * 2

  end

  if @event_time.hour  >=  22 && @event_time.hour  <  23

    return @base * 1  unless   @event_time.min > 30
    return @base * 1.5

  end

  return @base * 1

end

def calculate_weekend



  if @event_time.hour  >=  9 && @event_time.hour  <  10

    return @base * 1.7  unless   @event_time.min > 30
    return @base * 2

  end

  if @event_time.hour  >=  10 && @event_time.hour  <  23


    return @base * 2
  end

  return @base * 1

end



def generate_week

  loop do

    if (@event_time.sunday? || @event_time.saturday?)

      Consumption.create( energy: @energy, stamp:@event_time, value: calculate_weekend , alwayson: 12)
    else

      Consumption.create( energy: @energy, stamp:@event_time, value: calculate_week , alwayson: 12)

    end

    @event_time = @event_time + (60 *5) + rand(0..30).to_i

    break if @event_time > Time.now

  end
end


  create_base


  Consumption.delete_all

#  uncomment when ready start_time = Time.now - ((60 * 60 * 24)* 10)
start_time = Time.now - (1500000)

# create gas datas
gas_temp_night = 16
gas_temp_present = 20
gas_temp_day = 18


# create gas datas

@event_time = start_time
p "start"

p @event_time

# gas

@base = 1.354458 + rand(0..9).to_f/10
@energy = "gas"

generate_week


@base = 10.354458 + rand(0..9).to_f/10
@energy = "elec"


generate_week

@base = 0.34448 + rand(0..9).to_f/10
@energy = "water"


generate_week




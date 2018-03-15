# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

puts "- Drop the database"
# Using TRUNCATE (way faster than delete_all)
ActiveRecord::Base.connection.tables.each do |table|
  next if table.match(/\Aschema_migrations\Z/)
  ActiveRecord::Base.connection.execute("TRUNCATE #{table} CASCADE")
end

def create_base
  puts "starting House seed"

  House.delete_all

  House.create!( name: 'Home sweet home')

  puts "House seed completed"

  puts "starting brand seed"



  Brand.create!( name: 'Google Nest')
  Brand.create!( name: 'Philips Hue')
  smappee_brand = Brand.create!( name: 'Smappee')

  puts "brand seed completed"

  puts "starting object type seed"




  # creation thermostat

  puts "creation type thermostat"
  puts "enter user"
  user = "toto"
  puts "enter password"
  pwd = "password"
  Type.create!( name: 'Thermostat', method:'nest_thermostat', key_user: user, key_password: pwd, brand_id: Brand.first[:id])

# creation camera

puts "creation type camera"
puts "enter user"
user = "toto"
puts "enter password"
pwd = "password"

Type.create!( name: 'Camera', method:'nest_camera', key_user: user, key_password: pwd, brand_id: Brand.first[:id])

# creation lampes

puts "creation type lampes"
puts "enter user"
user = "toto"
puts "enter password"
pwd = "password"
Type.create!( name: 'Lampes', method:'philips_lampes', key_user: user, key_password: pwd, brand_id: Brand.last[:id])

puts "creation type smappee"
Type.create!( name: 'Smappee', method:'smappee', brand: smappee_brand)


puts "type  seed completed"


puts "starting action seed"



puts "create action on nest thermostat"

Action.create!( name: 'Augmenter température', api_param: 'puts nest.temperature           99.00', type_id:  Type.find_by(name: 'Thermostat').id)
Action.create!( name: 'Baisser température', api_param: 'puts nest.temperature            00.00', type_id: Type.find_by(name: 'Thermostat').id)

puts "create action on nest camera"

Action.create!( name: 'Afficher Camera', api_param: 'je sais pas encore' , type_id: Type.find_by(name: 'Camera').id)
Action.create!( name: 'Effacer Camera', api_param: 'je sais pas encore' , type_id: Type.find_by(name: 'Camera').id)

puts "create action on philipshue"

Action.create!( name: 'off', api_param: '  {"on":false}' , type_id: Type.find_by(name: 'Lampes').id)
Action.create!( name: 'on', api_param: ' {"on":true}' , type_id: Type.find_by(name: 'Lampes').id)


puts "action seed completed"

puts "starting devices seed"

Device.create!( name: 'Thermostat Nest', type_id: Type.find_by(name: 'Thermostat').id, house_id: House.first[:id])
Device.create!( name: 'Camera Nest', type_id: Type.find_by(name: 'Thermostat').id, house_id: House.first[:id])

Device.create!( name: 'Cuisine', type_id: Type.find_by(name: 'Lampes').id, house_id: House.first[:id])
Device.create!( name: 'Salon', type_id: Type.find_by(name: 'Lampes').id, house_id: House.first[:id])

puts "devices seed completed"


User.update(:house_id => House.first.id)


end


def calculate_week


  if @event_time.hour  >=  6 && @event_time.hour  <  7

    return @base * 3  unless   @event_time.min < 30
    return @base * 2.5
  end

  if @event_time.hour  >=  7 && @event_time.hour  <  8

    return  @base * 2.5

  end

  if @event_time.hour  >=  8 && @event_time.hour  <  9

    return @base * 2.5 unless   @event_time.min < 30
    return @base * 2

  end

  if @event_time.hour  >=  9 && @event_time.hour  <  10

    return  @base * 0.7  unless   @event_time.min < 30
    return  @base * 2
  end

  if @event_time.hour  >=  10 && @event_time.hour  <  17
   return @base * 0.5
 end
 if @event_time.hour  >=  17 && @event_time.hour  <  18

  return  @base * 2  unless   @event_time.min > 30
  return  @base * 1

end
if @event_time.hour  >=  18 && @event_time.hour  <  22

  return @base * 3

end

if @event_time.hour  >=  22 && @event_time.hour  <  23

  return  @base * 1  unless   @event_time.min > 30

  return @base * 1.5

end

return @base * 0.5

end

def calculate_weekend



  if @event_time.hour  >=  9 && @event_time.hour  <  10

    return   @base * 1.7  unless   @event_time.min > 30
    return  @base * 2

  end

  if @event_time.hour  >=  10 && @event_time.hour  <  23


    return @base * 2
  end

  @result =  @base * 0.5

end

def generate_water

  if @event_time.hour  >=  6 && @event_time.hour  <  8

    @base = 0.23 + rand(0.05.. 0.09)

    @energy = "water"
    Consumption.create!( energy: @energy, stamp:@event_time, value: @base , alwayson: 12)

    return

  end

  def generate_solar

    if @event_time.hour  >=  6 && @event_time.hour  <  9
      @solar = @solar * 1.05 + rand(0.01..1.15)

    end

    if @event_time.hour  >=  10 && @event_time.hour  <  12
      @solar = @solar * 1.10 + rand(-1.01..1.15)

    end

    if @event_time.hour  >=  13 && @event_time.hour  <  15
      @solar = @solar * 1.15 + rand(1.01..1.15)

    end

    if @event_time.hour  >=  16 && @event_time.hour  <  17
      @solar = @solar * 1.00003 + rand(-1.0001..1.015)

    end

    if @event_time.hour  >=  17 && @event_time.hour  <  19
      @solar = @solar * 1.00030 + rand(-1.01..1.15)
          end

      @energy = "solar"
      Consumption.create!( energy: @energy, stamp:@event_time, value: @solar , alwayson: 12)

      return

    end


  if @event_time.hour  >=  21 && @event_time.hour  <  23

    @base = 0.23 + rand(0.05.. 0.09)
    @energy = "water"
    Consumption.create!( energy: @energy, stamp:@event_time, value: @base , alwayson: 12)

    return
  end

    @energy = "water"
    Consumption.create!( energy: @energy, stamp:@event_time, value: 0 , alwayson: 12)
end


def generate_week

  loop do

    if (@event_time.sunday? || @event_time.saturday?)

      @base = 1.04 + rand(0.05.. 0.09)

      @energy = "gas"
      Consumption.create!( energy: @energy, stamp:@event_time, value: calculate_weekend, alwayson: 12)
      @base = 1.12 + rand(0.05.. 0.09)
      @energy = "elec"
      # Consumption.create!( energy: @energy, stamp:@event_time, value:calculate_weekend , alwayson: 12)
       # @energy = "solar"
       # Consumption.create!( energy: @energy, stamp:@event_time, value: calculate_weekend , alwayson: 12)



     else


      @base = 1.04 + rand(0.05.. 0.09)

      @energy = "gas"
      Consumption.create!( energy: @energy, stamp:@event_time, value: calculate_week , alwayson: 12)
      @base = 1.12 + rand(0.05.. 0.09)
      @energy = "elec"
      # Consumption.create!( energy: @energy, stamp:@event_time, value: rand(0.1 ..5) , alwayson: 12)
      # @energy = "solar"
      # Consumption.create!( energy: @energy, stamp:@event_time, value: rand(0.1 ..5) , alwayson: 12)



      generate_water
      #
      # @solar = 1
      # generate_solar


    end

    @event_time = @event_time + (60 *5) + rand(0..30).to_i

    break if @event_time > Time.now

  end
end

  #uncomment
  create_base


  Consumption.delete_all

#  uncomment when ready start_time = Time.now - ((60 * 60 * 24)* 10)
start_time = Time.now - 15.days


# create gas datas

@event_time = start_time
p "start"


# gas

@event_time = start_time

generate_week

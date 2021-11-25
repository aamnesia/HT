require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'pas_wagon'
require_relative 'cargo_wagon'
require_relative 'pas_train'
require_relative 'menu_text'

class Operations
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def main_menu
    operations = {
      1 => 'create_station',
      2 => 'create_train', 3 => 'change_route',
      4 => 'follow_route', 5 => 'hook_wagon', 6 => 'unhook_wagon',
      7 => 'move_train', 8 => 'show_stations_trains', 9 => 'trains_on_station',
      10 => 'show_wagons', 11 => 'occupy_wagon_capacity' }

    loop do
      print MAIN_MENU
      operation = gets.chomp.to_i
      break if operation.zero?
      send(operations[operation])
    end
  end

  private

  def create_station
    print 'Введите название станции: '
    station_name = gets.chomp
    @stations << Station.new(station_name)
  rescue StandardError
    puts 'Такое название не подходит. Попробуйте ещё раз)'
    retry
  else
    puts "Станция #{station_name} создана!"
  end

  def create_train
    begin
      print TRAIN_TYPE_CHOICE
      chosen_type = gets.chomp.to_i
      raise unless [1, 2].include?(chosen_type)
    rescue StandardError
      puts 'Введите 1 или 2'
      retry
    end

    begin
      print 'Введите номер поезда: '
      number = gets.chomp

      train = PassengerTrain.new(number) if chosen_type == 1
      train = CargoTrain.new(number) if chosen_type == 2
      @trains << train
    rescue StandardError
      puts 'Неправильный формат номера поезда. Попробуйте ещё раз)'
      retry
    else
      puts "#{train.type_name} поезд номер #{train.number} создан!"
    end
  end

  def create_route
    puts 'Выберите первую станцию маршрута: '
    first_station = choose_station
    puts 'Выберите конечную станцию маршрута: '
    last_station = choose_station

    route = Route.new(first_station, last_station)
    @routes << route

    puts "Маршрут #{route.route_name} создан!"
  end

  def change_route
    route_operations = { 1 => 'create_route',
      2 => 'add_station', 3 => 'delete_station' }

    loop do
      print ROUTE_MENU
      begin
        route_operation = gets.chomp.to_i
        break if route_operation.zero?
        send(route_operations[route_operation])
        raise unless (0..3).include?(route_operation)
      rescue StandardError
        puts 'Введите 1, 2, 3 или 0'
        retry
      end
    end
  end

  def add_station
    route = choose_route
    station = choose_station
    route.add_station(station)
    puts "Станция #{station.station_name} добавлена в маршрут!"
  end

  def delete_station
    route = choose_route
    station = choose_station
    route.delete_station(station)
    puts "Станция #{station.station_name} удалена из маршрута!"
  end

  def follow_route
    train = choose_train
    route = choose_route
    train.follow_route(route)

    puts "#{train.type_name} поезд номер #{train.number} следует " +
    "по маршруту #{route.route_name}!"
  end

  def hook_wagon
    train = choose_train
    print 'Введите номер вагона: '
    wagon_number = gets.chomp

    if train.type_name == 'Пассажирский'
      print 'Введите кол-во мест в вагоне: '
      number_of_seats = gets.chomp.to_i
      wagon = PassengerWagon.new(wagon_number, number_of_seats)
    else
      print 'Введите объём вагона: '
      capacity = gets.chomp.to_i
      wagon = CargoWagon.new(wagon_number, capacity)
    end
    train.hook_wagon(wagon)
    puts "Вагон #{wagon.number} прицеплен!"
  end

  def unhook_wagon
    train = choose_train
    wagon = choose_wagon(train)
    train.unhook_wagon(wagon)
    puts "Вагон #{wagon.number} отцеплен!"
  end

  def move_train
    train = choose_train
    if train.current_route
      begin
        puts MOVING_TRAIN_CHOICE
        direction = gets.chomp.to_i
        raise unless [1, 2].include?(direction)
      rescue StandardError
        puts 'Можно ввести только 1 или 2'
        retry
      end
      train.go_forward if direction == 1
      train.go_back if direction == 2

      print "Поезд прибыл на станцию #{train.current_station.station_name}"
    else
      puts 'Поезду не назначен маршрут('
    end
  end

  def occupy_wagon_capacity
    train = choose_train
    wagon = choose_wagon(train)

    if wagon.type == :passenger
      wagon.take_seat
      puts 'Вы заняли 1 место)'
    else
      print 'Какой объем занять? '
      wagon.occupy_volume(gets.chomp.to_i)
      puts 'Объем дополнен'
    end
  end

  def show_stations_trains
    puts 'Станции:'
    @stations.each { |station| puts "#{station.station_name} " }
    puts 'Поезда: '
    @trains.each { |train| puts "#{train.type_name} поезд " +
    "номер #{train.number} " }
  end

  def show_trains_on_station
    puts 'Выберите станцию:'
    station = choose_station
    puts 'Список поездов на станции:'
    station.trains_block do |train|
      puts "#{train.type_name} поезд номер #{train.number}: " +
      "кол-во вагонов - #{train.wagons.size}"
    end
  end

  def show_wagons
    train = choose_train
    puts 'Список вагонов поезда:'
    if train.type == :passenger
      train.wagons_block do |wagon|
        puts "#{wagon.type_name} вагон номер #{wagon.number}: " +
        "свободных мест - #{wagon.free_seats}, " +
        "занятых мест - #{wagon.taken_seats}"
      end
    else
      train.wagons_block do |wagon|
        puts "#{wagon.type_name} вагон номер #{wagon.number}: " +
        "доступный объем - #{wagon.volume_left}, " +
        "занятый объем - #{wagon.occupied_volume}"
      end
    end
  end

  def choose_route
    puts 'Выберите маршрут из списка:'
    @routes.each_index { |index| puts "#{index + 1} - " +
    "#{@routes[index].route_name}" }
    entered_index = gets.chomp.to_i
    allowed_indexes = (1..@routes.length).to_a
    raise unless allowed_indexes.include?(entered_index)

    @routes[entered_index - 1]
  rescue StandardError
    puts 'Маршрут не найден'
    retry
  end

  def choose_train
    puts 'Выберите поезд из списка:'
    @trains.each_index do |index|
      puts "#{index + 1} - #{@trains[index].type_name} поезд " +
      "номер #{@trains[index].number}"
    end
    entered_index = gets.chomp.to_i
    allowed_indexes = (1..@trains.length).to_a
    raise unless allowed_indexes.include?(entered_index)

    @trains[entered_index - 1]
  rescue StandardError
    puts 'Поезд не найден'
    retry
  end

  def choose_wagon(train)
    begin
      puts 'Выберите вагон из списка:'
      train.wagons.each_index { |index| puts "#{index + 1} - " +
      "#{train.wagons[index].number}" }
      entered_index = gets.chomp.to_i
      allowed_indexes = (1..train.wagons.length).to_a
      raise unless allowed_indexes.include?(entered_index)

      train.wagons[entered_index - 1]
    rescue StandardError
      puts 'Вагон не найден'
      retry
    end
  end

  def choose_station
    begin
      @stations.each_index { |index| puts "#{index + 1} - " +
      "#{@stations[index].station_name}" }
      entered_index = gets.chomp.to_i
      allowed_indexes = (1..@stations.length).to_a
      raise unless allowed_indexes.include?(entered_index)

      @stations[entered_index - 1]
    rescue StandardError
      puts 'Станция не найдена. Попробуйте ещё раз)'
      retry
    end
  end
end

operations = Operations.new
operations.main_menu

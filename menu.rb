class Menu
  MENU_OPTIONS = {
    '1' => :list_books,
    '2' => :list_people,
    '3' => :create_person,
    '4' => :create_book,
    '5' => :create_rental,
    '6' => :list_all_rentals,
    '7' => :exit_program,
    '8' => :return_to_menu # New option to return to the menu
  }.freeze

  def initialize(app)
    @app = app
  end

  def display_menu
    puts 'Please choose an option:'
    MENU_OPTIONS.each do |key, value|
      puts "#{key}. #{value.to_s.tr('_', ' ')}"
    end
    process_choice
  end

  def process_choice
    choice = gets.chomp
    if MENU_OPTIONS.include?(choice)
      @app.send(MENU_OPTIONS[choice])
    else
      puts 'Invalid choice. Please try again.'
      display_menu
    end
  end

  def menu_options
    MENU_OPTIONS
  end
end
  def create_person(name, age)
    print 'Would you like to create a student (1) or a teacher (2)? Select a number: '
    choice = gets.chomp
    case choice
    when '1'
      @app.create_student(name, age)
    when '2'
      print 'Specialization: '
      specialization = gets.chomp
      @app.create_teacher(name, age, specialization)
    else
      puts 'Invalid choice. Please try again.'
      display_menu
    end
  end

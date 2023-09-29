require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'menu'

class App
  def initialize
    @books = []
    @rentals = []
    @people = []
    @menu = Menu.new(self)
  end

  def start
    puts 'Welcome to the School Library App!'
    loop do
      @menu.display_menu
      choice = gets.chomp

      if @menu.menu_options.include?(choice)
        send(@menu.menu_options[choice])
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end

  def list_books
    if @books.empty?
      puts 'No books available. Please add some books and try again.'
    else
      puts 'List of available books:'
      @books.each_with_index do |book, index|
        puts "#{index + 1}) Title: #{book.title} | Author: #{book.author}"
      end
    end
  end

  def list_people
    if @people.empty?
      puts 'No people added yet. Please add a person and try again.'
    else
      puts 'List of people:'
      @people.each_with_index do |person, index|
        puts "#{index + 1}) [#{person.class}] Name: #{person.name} | Age: #{person.age} | ID: #{person.id}"
      end
    end
  end

  def create_person(name = nil, age = nil)
    if name.nil? && age.nil?
      print 'Would you like to create a student (1) or a teacher (2)? Select a number: '
      choice = gets.chomp
      print 'Name: '
      name = gets.chomp
      print 'Age: '
      age = gets.chomp.to_i
    end

    case choice
    when '1'
      create_student(name, age)
    when '2'
      create_teacher(name, age)
    else
      puts 'Invalid choice. Please try again.'
    end

    start
  end

  def create_student(name, age)
    classroom = nil
    student = Student.new(age, classroom, name)
    @people << student
    puts "Student created successfully. ID is #{student.id}"
  end

  def create_teacher(name, age)
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    @people << teacher
    puts "Teacher created successfully. Teacher ID is #{teacher.id}"
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    if title.strip != '' && author.strip != ''
      book = Book.new(title, author)
      @books << book
      puts 'Book created successfully.'
    else
      puts 'Please enter the book title and author.'
    end

    start
  end

  def create_rental
    if @books.empty? || @people.empty?
      puts 'Nothing to see here. Add books and people first.'
    else
      puts 'Select a book to rent:'
      list_books
      book_number = gets.chomp.to_i - 1
      puts 'Enter your ID to rent the book:'
      list_people
      person_id = gets.chomp.to_i - 1
      individual = @people[person_id]

      print 'Enter the rental date [yyyy-mm-dd]: '
      date = gets.chomp

      if date.match?(/^\d{4}-\d{2}-\d{2}$/)
        rental = Rental.new(@books[book_number], individual, date)
        @rentals << rental
        puts 'Book rented successfully.'
      else
        puts 'Invalid date format. Please use yyyy-mm-dd.'
      end
    end

    start
  end

  def list_all_rentals
    if @rentals.empty?
      puts 'No rentals available at the moment.'
    else
      print 'Enter your ID to view rentals: '
      id = gets.chomp.to_i
      rentals = @rentals.select { |rend| rend.person.id == id }

      if rentals.empty?
        puts 'No rental records for that ID.'
      else
        puts 'Here are your rental records:'
        puts ''
        rentals.each_with_index do |record, index|
          puts "#{index + 1}| Date: #{record.date} | Borrower: #{record.person.name} | " \
               "Status: #{record.person.class} | Borrowed book: \"#{record.book.title}\" by #{record.book.author}"
        end
      end
    end

    puts 'Press any key to return to the menu...'
    gets # Wait for user input

    start
  end

  def exit_program
    puts 'Thank you for using the app. Goodbye!'
    exit
  end
end

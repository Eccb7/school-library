require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'menu'
require 'json'

class App
  def initialize
    @books = []
    @rentals = []
    @people = []
    @menu = Menu.new(self)
    load_data_from_json
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
        puts "#{index + 1}. #{book.title} by #{book.author}"
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
    save_data_to_json
  end

  def create_teacher(name, age)
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    @people << teacher
    puts "Teacher created successfully. Teacher ID is #{teacher.id}"
    save_data_to_json
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
      save_data_to_json
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
      puts 'Enter person to rent the book:'
      list_people
      person_id = gets.chomp.to_i - 1
      individual = @people[person_id]

      print 'Enter the rental date [yyyy-mm-dd]: '
      date = gets.chomp

      if date.match?(/^\d{4}-\d{2}-\d{2}$/)
        rental = Rental.new(@books[book_number], individual, date)
        @rentals << rental
        puts 'Book rented successfully.'
        save_data_to_json
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
      rentals = @rentals.select do |rend|
        rend.person && rend.person.id == id
      end

      if rentals.empty?
        puts 'No rental records found for that ID.'
      else
        puts 'Here are your rental records:'
        puts ''
        rentals.each_with_index do |record, index|
          puts "#{index + 1}| Date: #{record.date} | Borrower: #{record.person.name} | " \
               "Status: #{record.person.class} | Borrowed book: \"#{record.book.title}\" by #{record.book.author}"
        end
      end
    end
  end

  def exit_program
    puts 'Thank you for using the app. Goodbye!'
    save_data_to_json
    exit
  end

  private

  def save_data_to_json
    # Save books to a JSON file
    File.write('data/books.json', JSON.dump(@books))

    # Save people to a JSON file
    File.write('data/people.json', JSON.dump(@people))

    # Save rentals to a JSON file
    File.write('data/rentals.json', JSON.dump(@rentals))
  end

  def load_data_from_json
    # Load books from the books.json file if it exists
    if File.exist?('data/books.json')
      File.open('data/books.json', 'r') do |file|
        book_data = JSON.parse(file.read)
        @books = book_data.map do |book_hash|
          Book.new(book_hash['title'], book_hash['author'])
        end
      end
    end

    # Load people from the people.json file if it exists
    if File.exist?('data/people.json')
      File.open('data/people.json', 'r') do |file|
        person_data = JSON.parse(file.read)
        @people = person_data.map do |person_hash|
          Person.new(person_hash['age'], name: person_hash['name'])
        end
      end
    end

    # Load rentals from the rentals.json file if it exists
    if File.exist?('data/rentals.json')
      File.open('data/rentals.json', 'r') do |file|
        rental_data = JSON.parse(file.read)
        @rentals = rental_data.map do |rental_hash|
          book = @books.find { |b| b.title == rental_hash['book_title'] }
          person = @people.find { |p| p.id == rental_hash['person_id'] }
          Rental.new(book, person, rental_hash['date'])
        end
      end
    end
  end
end

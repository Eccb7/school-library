require_relative 'app'

MENU_OPTIONS = {
  '1' => :list_books,
  '2' => :list_people,
  '3' => :create_person,
  '4' => :create_book,
  '5' => :create_rental,
  '6' => :list_all_rentals,
  '7' => :exit_program
}.freeze

def display_menu
  puts 'Please choose an option:'
  MENU_OPTIONS.each do |key, value|
    puts "#{key}. #{value.to_s.tr('_', ' ')}"
  end
end

app = App.new
app.start(MENU_OPTIONS, method(:display_menu))

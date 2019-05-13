def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  students = []
  name = STDIN.gets.chomp

  

  until name.empty? do
    students << {name: name, cohort: :november}

    puts "Now we have #{students.count} students"

STDIN.gets
    name = gets.chomp
  end

  # return the array of students

  students
end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end

def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.length} great students"
end


students = input_students
print_header
print(students)
print_footer(students)

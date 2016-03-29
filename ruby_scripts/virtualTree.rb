class Tree
  def initialize (name, typeOfFruit)
    @name = name
    @typeOfFruit = typeOfFruit
    @height = 0
    @age = 0
    @alive = true
    @fruits = 0
    @fruitsPerYear = 0
    puts ""
    puts ""
    puts ""
    puts "  Q         "
    puts "   \\  O    "
    puts "    | /     "
    puts "    |/      "
    puts "    |       "
    puts "____|____   "
    puts "The #{@name} seedling is sprouting"
    puts ""
  end

  nameOfTree = "Blood"

  def oneYearPassed
    @age += 1
    puts "The #{@name} tree is #{@age} years old"
    puts ""
  end

  @userAction = ""
  def interactWithTree
    puts "Choose either of these options:"
    puts ""
    puts "Forward x many years, type:        grow"
    puts "Count fruit on tree, type:         count"
    puts "Pick fruit, type:                  pick"
    puts "Exit program:                      exit"
    @userAction = gets.chomp.downcase
    if @userAction == "grow"
      grow
      interactWithTree
    elsif @userAction == "count"
        count
        interactWithTree
      elsif @userAction == "pick"
        pick
        interactWithTree
      elsif @userAction == "exit"
        exit          
    else
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
      puts "CHOOSE ONLY AVAILABLE OPTIONS -- (grow, count, pick) -- CHOOSE ONLY AVAILABLE OPTIONS"
      puts ""
      puts ""
      puts ""
      interactWithTree
    end
  end

  private

  def fruiting
    if @age >= 5 && @age < 10
      @fruitsPerYear = @age * 12
      @fruits = @fruitsPerYear
    elsif @age >= 10 && @age < 30
      @fruitsPerYear = @age * 15
      @fruits = @fruitsPerYear
    elsif @age >= 30
      @fruitsPerYear = @age * 18 + 130
      @fruits = @fruitsPerYear
    end
  end

  def grow
    puts ""
    puts "How many years to forward in time?"
    howManyYears = gets.chomp.to_i
    puts ""
    puts ""
    puts "         ,`, `o,` o          "
    puts "      ,` `,  `o   ` o        "
    puts "   o`  o ` o `o` `o , `,     "
    puts "  o`,` ,` `,  `o   ` o` ,    "
    puts "  `,`  o ` o `o` `o , `, `o  "
    puts " ` `,` ,` `,  `o   ` o` ,`   "
    puts " o`,`  o ` o `o` `o , o`, ,  "
    puts "   ` o\\ o , `  / ` ,  ,   o "
    puts "    ` o` |  ` ` ,/o`   o     "
    puts "    ,    |   | /             "
    puts "     o \\ |   |              "
    puts "        \\|   |              "
    puts "         |   |               "
    puts "         |   |               "
    puts "      ___/   \\____          "
    @age += howManyYears
    if @age > 130 
      puts "The  #{@name} Tree  reached the  end  of it's days."
      puts "With  no  more  leafs,  comes no  more  fruit."
      puts "Let's take a moment to charish the joys and pleasures"
      puts "this  tree  has  provided  us  through  the  years."
      puts ""
      puts "Good bye ol' friend"
      exit
    end
    @fruits = 0
    fruiting
    puts "The #{@name}Tree is now #{@age} years old, and has produced #{@fruits} #{@typeOfFruit}s this year."
    puts ""
    puts ""
  end

  def count
    puts ""
    puts ""
    puts "#{@fruits} #{@typeOfFruit}s on the #{@name} Tree"
  end

  def pick
    puts ""
    puts ""
    puts "How many #{@typeOfFruit}s do you want to pick?"
    pickingHowMany = gets.chomp.to_i
    if pickingHowMany < @fruits
      @fruits -= pickingHowMany
      puts "Mmmm deliscious. There are now #{@fruits} #{@typeOfFruit}s left on the tree"
    elsif pickingHowMany == @fruits
      @fruits = 0
      puts "You picked all the #{@typeOfFruit}s from the tree. There are none left this year."
    else
      puts "Sorry there are only #{@fruits} left on the tree"
      pick
    end 
  end

end



bloodOrange = Tree.new("Blood Orange", "Orange")
bloodOrange.interactWithTree
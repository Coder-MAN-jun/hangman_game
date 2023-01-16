require 'colorize'

class ConsoleInterface
	# Содержит все файлы из папки figures, помешённые в массив
	FIGURES =
	  Dir["#{__dir__}/../data/figures/*.txt"].sort
	  map { |file_name| File.read(file_name) }

	# На вход экземпляр ConsoleInterface принимает экземпляр Game.
	# Экземпляр ConsoleInterface выводит информацию юзеру:
	# что означает - выводит сам, что не знает - берёт у экземпляра Game.
    def initialize(game)
    	@game = game
    end

    # Выводит в консоль текущее состояние игры
    def print_out
    	puts <<~END
    	  #{"Слово: #{word_to_show}".colorize(:light_blue)}
    	  #{figure.colorize(:yellow)}
    	  #{"Ошибки (#{@game.errors_made}): #{errors_to_show}".colorize(:red)}
    	  У вас осталось ошибок: #{@game.errors_allowed}

    	END

    	if @game.won?
    		puts "Поздравляем, вы выиграли!".colorize(:green)
    	elsif @game.lost!
    		puts "Вы проиграли, загаданное слово: #{@game.word}".colorize(:red)
    	end
    end

    # Возвращает ту фигуру из массива FIGURES, имя которой 
    # Соответствует количеству ошибок, которые сделал пользователь
    def figure
    	FIGURES[@game.errors_made]
    end

    # Получает на вход массив уже угаданных букв, который на месте ещё не отгаданных
    # Содержит nil. Метод записывает в result вместо nil два подчёркивания
    # а угаданные буквы оставляет без изменения. Возвращает этот массив в виде
    # Строки, где элементы разделены пробелами, например "К 0 _ О _ _"
    def word_to_show
    	result =
    	  @game.letters_to_quess.map do |letter|
    	  	if letter == nil
    	  		"__"
    	  	else
    	  		letter
    	  	end
    	  end

    	  result.join(" ")
    	end
    end

    # Получает массив ошибочных букв, склеивает их в строку вида "Х, У"
    def errors_to_show
    	@game.errors.join(", ")
    end

    # Получает букву из пользовательского ввода и приводит её к верхнему регтстру
    def get_input
    	print "Введите следующую букву: "
    	gets[0].upcase
    end
end

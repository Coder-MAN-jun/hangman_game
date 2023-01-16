require 'colorize'

class ConsoleInterface
  # содержит все файлы из папки figures, помещённые в массив
  FIGURES =
      Dir["#{__dir__}/../data/figures/*.txt"].
      sort.
      map { |file_name| File.read(file_name) }

  # на вход экземпляр ConsoleInterface принимает экземпляр Game.
  # Экземпляр ConsoleInterface вывыодит информацию юзеру:
  # что знает - выводит сам, что не знает - берёт у экземпляра Game
  def initialize(game)
    @game = game
  end

  #выводит в консоль текущее состояние игры
  def print_out
    puts <<~END
      #{"Слово: #{word_to_show}".colorize(:light_blue)}
      #{figure.colorize(:yellow)}
      #{"Ошибки (#{@game.errors_made}): #{errors_to_show}".colorize(:red)}
      У вас осталось ошибок: #{@game.errors_allowed}
    END

    if @game.won?
      puts "Поздравляем, вы выиграли!".colorize(:green)
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}".colorize(:red)
    end
  end

  # возвращает ту фигуру из массива FIGURES, имя которой
  # соответствует кол-ву ошибок, которые сделал пользователь
  def figure
    FIGURES[@game.errors_made]
  end

  # получает на вход массив уже угаданных букв, который на месте еще не отгаданных
  # содержит nil. Метод записывает в result вместо nil два подчеркивания,
  # а угаданные буквы оставляет без изменения. Возвращает этот массив в виде
  # строки, где элементы разделены пробелами, например "К О __ О __ __"
  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter == nil
          "__"
        else
          letter
        end
      end

    result.join(" ")
  end

  #получает массив ошибочных букв, склеивает их в строку вида "Х, У"
  def errors_to_show
    @game.errors.join(", ")
  end

  # получает букву из пользовательского ввода и приводит её к верхнему регистру
  def get_input
    print "Введите следующую букву: "
    gets[0].upcase
  end
end
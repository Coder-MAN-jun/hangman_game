class Game
  #кол-во допустимых ошибок
  TOTAL_ERRORS_ALLOWED = 7

  # экземпляр на вход получает загаданное слово
  # задаем переменную экземпляра с буквами загаданного слова
  # и пустой массив для дальнейшего сбора в него вводимых букв
  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  # возвращает буквы, которые отсутствуют в @letters(ошибочные)
  def errors
    @user_guesses - normalized_letters
  end

  # возвращает кол-во ошибок, сделанных пользователем
  def errors_made
    errors.length
  end

  # отнимает от допустимого кол-ва ошибок, кол-во сделанных ошибок и
  # возвращает кол-во ошибок, которые пользователь ещё может сделать
  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  #возвращает массив с уже отгаданными буквами
  def letters_to_guess
    result =
      @letters.map do |letter|
        if @user_guesses.include?(letter)
          letter
        else
          nil
        end
      end
    result
  end

  # возвращает true, если у пользователя не осталось ошибок
  # т.е. игра проиграна
  def lost?
    errors_allowed == 0
  end

  # заменяет при вводе Й-Ё на И-Е, чтобы они считались за одну букву
  def normalize_letter(letter)
    letter = "И" if letter == "Й"
    letter = "Е" if letter == "Ё"
    letter
  end

  # приводит Й-Ё в массиве с буквами к И-Е
  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end

  # возвращает true, если один из методов в условии возвращает true
  def over?
    won? || lost?
  end

  # закидывает в массив букв введенных пользователем передаваемую букву.
  # если игра не закончена и передаваемая буква отутствует в массиве
  # введённых букв
  def play!(letter)
    if !over? && !@user_guesses.include?(letter)
      @user_guesses << letter
    end
  end

  # возвращает true, если загаданное и введённое слова совпали
  def won?
    (@letters - @user_guesses).empty?
  end

  # возвращает загаданное слово
  def word
    @letters.join
  end
end
class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  # ошибочные буквы (массив)
  def errors
    @user_guesses - normalized_letters
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_number
  end

  def errors_number
    (@user_guesses - normalized_letters).size
  end

  # отгаданные буквы
  def letters_to_guess
    result = []

    @letters.each do |letter|
      if @user_guesses.include?(normalize(letter))
        result << letter
      else
        result << nil
      end
    end

    result
  end

  def lost?
    errors_number >= TOTAL_ERRORS_ALLOWED
  end

  # преобразование букв Ё и Й
  def normalize(letter)
    if letter == 'Ё'
      'Е'
    elsif letter == 'Й'
      'И'
    else
      letter
    end
  end

  # буквы загаданного слова с преобразованными буквами Ё и Й
  def normalized_letters
    @letters.map { |letter| normalize(letter) }
  end

  def over?
    won? || lost?
  end

  # учёт введённой буквы
  def play!(letter)
    if !over? && !@user_guesses.include?(normalize(letter))
      @user_guesses << normalize(letter)
    end
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def word
    @letters.join
  end
end

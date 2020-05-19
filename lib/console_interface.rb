class ConsoleInterface
  FIGURES = Dir[__dir__ + '/../data/figures/*.txt'].
    sort.
    map { |file_name| File.read(file_name, encoding: 'UTF-8') }

  def initialize(game)
    @game = game
  end

  def figure
    FIGURES[@game.errors_number]
  end

  def get_input
    gets[0].upcase
  end

  def print_out
    puts <<~END
      Слово: #{word_to_show}
      #{figure}
      Ошибки (#{@game.errors_number}): #{@game.errors.join(', ')}
      У вас осталось ошибок: #{@game.errors_allowed}

    END

    if @game.won?
      puts 'Ура! Вы выиграли!'
    elsif @game.lost?
      puts "Вы проиграли. Загаданное слово: #{@game.word}"
    end
  end

  def word_to_show
    result = []

    @game.letters_to_guess.each do |letter|
      if letter.nil?
        result << '__'
      else
        result << letter
      end
    end

    result.join(' ')
  end
end

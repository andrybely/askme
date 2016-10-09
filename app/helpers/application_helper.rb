module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def sklonenie(number)
    if (number == nil || !number.is_a?(Numeric))
      number = 0
    end

    ostatok100 = number % 100

    if (ostatok100 >= 11 && ostatok100 <= 14)
      return " вопросов"
    end
    ostatok = number % 10
    if (ostatok == 1)
      return " вопрос"
    end
    if (ostatok >= 2 && ostatok <= 4)
      return " вопроса"
    end
    if (ostatok > 4 || ostatok == 0)
      return " вопросов"
    end
  end
end

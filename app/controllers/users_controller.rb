class UsersController < ApplicationController
  def index
    @users = [
      User.new(
            id: 1,
            name: 'Andry',
            username: 'bely10',
            avatar_url: 'https://s.gravatar.com/avatar/f7c5764b449ec995f6f8e6d9cd96b2e0?s=80'
      ),
      User.new(
            id: 2,
            name: 'Misha',
            username: 'aristofun'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
                  name: 'Andry',
                  username: 'bely10',
                  avatar_url: 'https://s.gravatar.com/avatar/f7c5764b449ec995f6f8e6d9cd96b2e0?s=80'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('27.03.2016')),
    ]

    @new_question = Question.new
  end
end

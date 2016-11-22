module UsersHelper

  def background_user
    @choice = 0
    case
      when @choice == 1
      then
        var = 'background-color: #005a55'
      when @choice == 2
      then
        var = 'background-color: red'
      when @choice == 3
      then
        var = 'background-color: dodgerblue'
      when @choice == 4
      then
        var = 'background-color: green'
      else
        var = 'background-color: #005a55'
    end

    @user_bg = "#{var}"
  end
end

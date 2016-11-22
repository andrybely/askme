require 'openssl'

class User < ApplicationRecord
  #параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  #проверка адреса эл почты
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/}
  #юзернэйм максимум 40 знаков в формате (только латинские буквы, цифры, и знак _)
  validates :username, length: {maximum: 40}, format: {with: /\A[a-zA-Z0-9"_"]+\z/}

  before_validation :username_downcase

  def username_downcase
    if username =~ /[A-Z]/
      self.username = username.downcase!
    else
      username
    end
  end

  @user_bg = ''

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password

  def encrypt_password
    if self.password.present?
      #создаем соль
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      #Создаем хэш пароля
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  #служебный метод, преобразующий бинарную строку в 16 ричный формат для удобства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email) #находим пользователя

    #при аутентификации пользователя сравнивается хэш пароля, сам пароль нигде не сохраняется никогда!
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password,
                                                                                             user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end
end

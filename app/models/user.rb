class User < ApplicationRecord

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    has_many :cats,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Cat,
        dependent: :destroy

    has_many :cat_rental_requests,
        through: :cats,
        source: :cat_rental_requests

    attr_reader :password

    after_initialize :ensure_session_token

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        user && user.is_password?(password) ? user : nil
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.update!(session_token: self.class.generate_session_token)
        self.session_token
    end

    def is_password?(password) 
        bcrypted_password = BCrypt::Password.new(self.password_digest)
        bcrypted_password.is_password?(password)
    end
    
    def password=(password) 
        @password = password
        self.password_digest = BCrypt::Password.create(password)
        self.save
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    def owns_cat?(cat) 
        cat.user_id == self.id
    end
end

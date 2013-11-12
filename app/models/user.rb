require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :password, :username
  attr_reader :password
  
  has_many :loop_collections, :dependent => :destroy, :inverse_of => :user
  
  has_many :authored_loops, :foreign_key => :author_id, :class_name => "Loop", :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :favorited_loop_collections, :through => :favorites, :source => :loop_collection
  
  before_validation :ensure_session_token_set
  
  validates :password, :allow_nil => true, :length => {:minimum => 6}
  validates :password_digest, :session_token, :username, :presence => true
  validates :username, :uniqueness => true
  
  def ensure_session_token_set
    self.session_token || reset_session_token
  end
  
  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest  = BCrypt::Password.create(password)
  end
  
  def has_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def User.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return (user && user.has_password?(password)) ? user : nil
  end
  
  def User.create_demo_account
    un = "Osho_#{User.count}"
    user = User.new(:password => "password", :username => un)
    
    collections = LoopCollection.all
    collection_count = collections.count
    debugger
    user.favorited_loop_collections = collections[0..collection_count/2]
    user.loop_collections = [LoopCollection.copy_random_collection(user), LoopCollection.copy_random_collection(user)]
    user.save
    return user
  end
  
end

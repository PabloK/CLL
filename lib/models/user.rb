#encoding: utf-8
require 'bcrypt'

# TODO standard error messages need to be in swedish
class User
  include DataMapper::Resource  
  include BCrypt
  property :id,             Serial
  property :firstname,      String
  property :lastname,       String
  property :email,          String,   :required => true, :unique => true
  property :password_hash,  String,   :required => true, :lazy => true
  property :lookup,         String,   :lazy => false
  property :recover_key,    String,   :lazy => false
  
  has n, :ability_keys, :through => Resource
  
  validates_format_of :email , :as => /^.*@.*\..*{3,}$/i, :message => "Email adressen är felaktig."
  validates_length_of :email , :within => 5..250, :message => "Email adressen bör vara mellan 5 och 250 tecken lång."

  def lookup_valid?(session_lookup)
    return session_lookup == @lookup
  end

  def firstname=(name)
    return prepare_name(name)
  end

  def lastname=(name)
    return prepare_name(name)
  end
  
  def generate_recover_key!
    update!(:recover_key => (0...64).map{ ('a'..'z').to_a[rand(26)]}.join)
  end

  def new_lookup!
    update!(:lookup => (0...50).map{ ('a'..'z').to_a[rand(26)]}.join)
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def email= email
    super email.downcase
  end

  private 
  def prepare_name(name)
    return name.split.join(" ").capitalize
  end
end

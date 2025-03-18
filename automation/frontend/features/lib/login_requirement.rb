# Handle load login credentials
class LoginRequirement
  include DataMagic
  DataMagic.load 'secrets.yml'

  def load_secret_details(user_details)
    data_for "secrets/#{user_details}"
  end
end

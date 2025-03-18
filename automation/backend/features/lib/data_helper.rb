# Module for preparing user data
class DataHelper
  def initialize(path)
    @db = YAML.load_file "features/data/#{path}/#{ENV['env']}.yml"
  end

  def prepare_credentials(user_details)
    hash = { 'email' => '', 'password' => '' }
    hash['email'] = @db['credentials'][user_details]['email']
    hash['password'] = @db['credentials'][user_details]['password']
    hash
  end

  def credentials(user_details)
    @db['credentials'][user_details]
  end

  def user_information(user_details, key)
    @db['credentials'][user_details][key]
  end
end

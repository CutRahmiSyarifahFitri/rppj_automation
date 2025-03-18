require 'faker'

# Module to generate faker data
module FakerGenerator
  def generate_faker_timestamp
    Time.now.strftime('%d%m%y%H%M%S')
  end

  def generate_faker_name(timestamp: nil)
    base_name = Faker::Lorem.sentence(word_count: 1)
    name_parts = base_name.gsub('.', '').split
    base_name = name_parts[0, 2].join(' ')
    "#{base_name} Auto #{timestamp}"
  end

  def generate_faker_isafe_number(timestamp: nil)
    random_digits = Faker::Number.number(digits: 3)
    "UA#{timestamp}#{random_digits}"
  end

  def generate_faker_email(name)
    name = name.downcase.gsub(' ', '_')
    "#{name}@yopmail.com"
  end
end

World(FakerGenerator)

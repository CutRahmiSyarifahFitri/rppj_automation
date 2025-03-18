require 'dotenv'

def find_environment_files
  environments_path = File.join(PROJECT_ROOT, '/environments')
  staging_files = Dir.glob(File.join(environments_path, '.env.*staging*'))
  production_files = Dir.glob(File.join(environments_path, '.env.*production*'))

  p staging_files
  { staging: staging_files, production: production_files }
end

def select_loaded_files(env_files)
  if env_files[:staging].any? && env_files[:production].any?
    p 'Loaded staging environment files by default'
    env_files[:staging]
  elsif env_files[:staging].any?
    p 'Loaded staging environment files'
    env_files[:staging]
  elsif env_files[:production].any?
    p 'Loaded production environment files'
    env_files[:production]
  else
    raise 'No environment file found. Please ensure .env.staging or .env.production exists.'
  end
end

def load_environment
  env_files = find_environment_files
  loaded_files = select_loaded_files(env_files)
  Dotenv.load(*loaded_files)
end

load_environment

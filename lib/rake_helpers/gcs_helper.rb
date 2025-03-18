require 'google/cloud/storage'
require 'google/apis/storage_v1'

@bucket_name = ENV['BUCKET_NAME']

# Initialize Google Cloud Storage client
def initialize_storage_client
  Google::Cloud::Storage.new
end

# Initialize Google Storage API client
def initialize_storage_api
  storage_api = Google::Apis::StorageV1::StorageService.new
  storage_api.authorization = Google::Auth.get_application_default(['https://www.googleapis.com/auth/cloud-platform'])
  storage_api
end

# Disable public access prevention
def disable_public_access_prevention
  storage_api = initialize_storage_api
  bucket = storage_api.get_bucket(@bucket_name)
  if bucket.iam_configuration.public_access_prevention == 'enforced'
    bucket.iam_configuration.public_access_prevention = 'inherited'
    storage_api.patch_bucket(@bucket_name, bucket)
    puts "Public Access Prevention has been disabled for bucket '#{@bucket_name}'."
  else
    puts "Public Access Prevention is not enforced for bucket '#{@bucket_name}'."
  end
end

# Grant public permission to a bucket
def grant_public_permission
  storage = initialize_storage_client
  bucket = storage.bucket(@bucket_name)
  if bucket
    bucket.policy do |policy|
      policy.add 'roles/storage.objectViewer', 'allUsers'
    end
    puts "Public read access granted to bucket '#{@bucket_name}'."
  else
    puts "Bucket '#{@bucket_name}' not found."
  end
end

# Upload a file to GCS
def upload_file(local_file_path, gcs_file_name)
  storage = initialize_storage_client
  bucket = storage.bucket(@bucket_name)
  if bucket
    bucket.create_file(local_file_path, gcs_file_name)
    "https://storage.googleapis.com/#{@bucket_name}/#{gcs_file_name}"
  else
    puts "Bucket '#{@bucket_name}' not found."
  end
end

# Read files from GCS
def read_file(file_name)
  storage = initialize_storage_client
  bucket = storage.bucket(@bucket_name)
  files = bucket.files
  if files
    puts "Files in bucket '#{@bucket_name}':"
    files.each do |file|
      puts file.name
    end
  else
    puts "File '#{file_name}' not found in bucket '#{@bucket_name}'."
  end
end

# Delete a file from GCS
def delete_file(file_name)
  storage = initialize_storage_client
  bucket = storage.bucket(@bucket_name)
  file = bucket.file(file_name)
  if file
    file.delete
    puts "File '#{file_name}' has been deleted from bucket '#{@bucket_name}'."
  else
    puts "File '#{file_name}' not found in bucket '#{@bucket_name}'."
  end
end

# Create a signed URL for a file in GCS
# 15 minutes default
def create_signed_url(file_name, expiration = 15 * 60)
  storage = initialize_storage_client
  bucket = storage.bucket(@bucket_name)
  file = bucket.file(file_name)
  if file
    signed_url = file.signed_url method: 'GET', expires: expiration
    puts "Signed URL: #{signed_url}"
  else
    puts "File '#{file_name}' not found in bucket '#{@bucket_name}'."
  end
end

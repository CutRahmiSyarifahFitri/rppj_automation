require 'google/apis/drive_v3'
require 'googleauth'
require 'dotenv'

APPLICATION_NAME = 'UAssist Automation Report'.freeze
SERVICE_ACCOUNT_JSON = ENV['SERVICE_ACCOUNT_JSON']
SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_FILE

def authorize_service_account
  authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
    json_key_io: File.open(File.join(PROJECT_ROOT, SERVICE_ACCOUNT_JSON)),
    scope: SCOPE
  )
  authorizer.fetch_access_token!
  authorizer
end

def initialize_drive_service
  service = Google::Apis::DriveV3::DriveService.new
  service.client_options.application_name = APPLICATION_NAME
  service.authorization = authorize_service_account
  service
end

def upload_file(file_path, folder_id = nil)
  service = initialize_drive_service
  file_metadata = {
    name: File.basename(file_path),
    parents: [folder_id]
  }.compact

  file = Google::Apis::DriveV3::File.new
  file.name = file_metadata[:name]
  file.parents = file_metadata[:parents]

  uploaded_file = service.create_file(file, upload_source: file_path, content_type: 'text/html')

  permission = Google::Apis::DriveV3::Permission.new(
    type: 'anyone',
    role: 'reader'
  )
  service.create_permission(uploaded_file.id, permission)

  "https://drive.google.com/file/d/#{uploaded_file.id}/view?usp=sharing"
end

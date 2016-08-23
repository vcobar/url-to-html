json.extract! job, :id, :url, :html, :server_code, :completed, :created_at, :updated_at
json.url job_url(job, format: :json)
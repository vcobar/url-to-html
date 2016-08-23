class FetchHtmlWorker
  include Sidekiq::Worker

  def perform(job_id)
    job = Job.find(job_id)
    begin
      page            = MetaInspector.new(job.url)
      job.server_code = page.response.status
      job.html        = page.to_hash
      job.completed   = true
      job.save
    rescue => error
      job.server_code = 500
      job.html        = error
      job.save
    end
  end
end
class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  respond_to :xml, :json

  def fetch_html
    @job = Job.new(job_params)

   if @job.save
    # send job to queue
    FetchHtmlWorker.perform_async(@job.id)
    render :json => { jobID: @job.id }, :callback => params[:callback]
   else
    render :json => { errors: @job.errors, status: :unprocessable_entity }, :callback => params[:callback]
   end
  end

  def fetch_job
    job = Job.find(params[:id])
    render :json => job, :callback => params[:callback]
  end

  def fetch_job_status
    job = Job.find(params[:id])
    job_status = job.completed? ? "COMPLETE" : "IN_PROGRESS"
    render :json => { jobID: job.id, status: job_status }, :callback => params[:callback]
  end

  def invalid_route
    render :json => { error: 'invalid route' }, :callback => params[:callback]
  end

  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:url, :html, :server_code, :completed)
    end
end

class TwitterRunsController < ApplicationController
  # GET /twitter_runs
  # GET /twitter_runs.json
  def index
    @twitter_runs = TwitterRun.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @twitter_runs }
    end
  end

  # GET /twitter_runs/1
  # GET /twitter_runs/1.json
  def show
    @twitter_run = TwitterRun.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @twitter_run }
    end
  end

  # GET /twitter_runs/new
  # GET /twitter_runs/new.json
  def new
    @twitter_run = TwitterRun.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @twitter_run }
    end
  end

  # GET /twitter_runs/1/edit
  def edit
    @twitter_run = TwitterRun.find(params[:id])
  end

  # POST /twitter_runs
  # POST /twitter_runs.json
  def create
    @twitter_run = TwitterRun.new(params[:twitter_run])

    respond_to do |format|
      if @twitter_run.save
        format.html { redirect_to @twitter_run, notice: 'Twitter run was successfully created.' }
        format.json { render json: @twitter_run, status: :created, location: @twitter_run }
      else
        format.html { render action: "new" }
        format.json { render json: @twitter_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /twitter_runs/1
  # PUT /twitter_runs/1.json
  def update
    @twitter_run = TwitterRun.find(params[:id])

    respond_to do |format|
      if @twitter_run.update_attributes(params[:twitter_run])
        format.html { redirect_to @twitter_run, notice: 'Twitter run was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @twitter_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twitter_runs/1
  # DELETE /twitter_runs/1.json
  def destroy
    @twitter_run = TwitterRun.find(params[:id])
    @twitter_run.destroy

    respond_to do |format|
      format.html { redirect_to twitter_runs_url }
      format.json { head :no_content }
    end
  end
end

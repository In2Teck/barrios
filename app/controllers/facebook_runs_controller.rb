class FacebookRunsController < ApplicationController
  # GET /facebook_runs
  # GET /facebook_runs.json
  def index
    @facebook_runs = FacebookRun.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facebook_runs }
    end
  end

  # GET /facebook_runs/1
  # GET /facebook_runs/1.json
  def show
    @facebook_run = FacebookRun.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facebook_run }
    end
  end

  # GET /facebook_runs/new
  # GET /facebook_runs/new.json
  def new
    @facebook_run = FacebookRun.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facebook_run }
    end
  end

  # GET /facebook_runs/1/edit
  def edit
    @facebook_run = FacebookRun.find(params[:id])
  end

  # POST /facebook_runs
  # POST /facebook_runs.json
  def create
    @facebook_run = FacebookRun.new(params[:facebook_run])

    respond_to do |format|
      if @facebook_run.save
        format.html { redirect_to @facebook_run, notice: 'Facebook run was successfully created.' }
        format.json { render json: @facebook_run, status: :created, location: @facebook_run }
      else
        format.html { render action: "new" }
        format.json { render json: @facebook_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /facebook_runs/1
  # PUT /facebook_runs/1.json
  def update
    @facebook_run = FacebookRun.find(params[:id])

    respond_to do |format|
      if @facebook_run.update_attributes(params[:facebook_run])
        format.html { redirect_to @facebook_run, notice: 'Facebook run was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @facebook_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facebook_runs/1
  # DELETE /facebook_runs/1.json
  def destroy
    @facebook_run = FacebookRun.find(params[:id])
    @facebook_run.destroy

    respond_to do |format|
      format.html { redirect_to facebook_runs_url }
      format.json { head :no_content }
    end
  end
end

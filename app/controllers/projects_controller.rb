class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = policy_scope(Project)
      .where(is_master: true)
  end

  # GET /projects/1 or /projects/1.json
  def show
    authorize @project
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.client_ids << params[:client_id] if params[:client_id]
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    
    result = Projects::SetupNewProject.new({
      current_user: current_user,
      project: @project,
    }).perform

    if !result[:success]
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: result[:errors], status: :unprocessable_entity }
      end
      return
    end

    @project = result[:data]
    authorize @project

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.fetch(:project, {})
        .permit(
          :is_master,
          :parent_project_id,
          :title,
          :client_ids => [],
        )
    end
end

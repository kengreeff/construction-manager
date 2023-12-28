class ProjectSpacesController < ApplicationController
  before_action :set_project_space, only: %i[ show edit update destroy ]

  # GET /project_spaces or /project_spaces.json
  def index
    @project_spaces = policy_scope(ProjectSpace)
      .where(project_id: params[:project_id])
  end

  # GET /project_spaces/1 or /project_spaces/1.json
  def show
    @categories = Category.where(category_type: "ProjectItem")
  end

  # GET /project_spaces/new
  def new
    @project_space = ProjectSpace.new
  end

  # GET /project_spaces/1/edit
  def edit
  end

  # POST /project_spaces or /project_spaces.json
  def create
    @project_space = ProjectSpace.new(project_space_params)
    @project_space.project_id = params[:project_id]

    respond_to do |format|
      if @project_space.save
        format.html { redirect_to project_space_url(@project_space, @project_space), notice: "Project space was successfully created." }
        format.json { render :show, status: :created, location: @project_space }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project_space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_spaces/1 or /project_spaces/1.json
  def update
    respond_to do |format|
      if @project_space.update(project_space_params)
        format.html { redirect_to project_space_url(@project_space, @project_space), notice: "Project space was successfully updated." }
        format.json { render :show, status: :ok, location: @project_space }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project_space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_spaces/1 or /project_spaces/1.json
  def destroy
    @project_space.destroy!

    respond_to do |format|
      format.html { redirect_to project_spaces_url, notice: "Project space was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_space
      @project_space = ProjectSpace.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_space_params
      params.fetch(:project_space, {})
        .permit(
          :title,
        )
    end
end

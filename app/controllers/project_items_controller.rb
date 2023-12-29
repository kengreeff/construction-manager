class ProjectItemsController < ApplicationController
  before_action :set_project_item, only: %i[ show edit update destroy ]

  # GET /project_items or /project_items.json
  def index
    @project_items = ProjectItem.all
  end

  # GET /project_items/1 or /project_items/1.json
  def show
  end

  # GET /project_items/new
  def new
    @project_item = ProjectItem.new(
      category_id: params[:category_id],
      project_id: params[:project_id],
      project_space_id: params[:space_id],
    )
  end

  # GET /project_items/1/edit
  def edit
  end

  # POST /project_items or /project_items.json
  def create
    @project_item = ProjectItem.new(project_item_params)
    
    if (supplier_title = params.dig(:project_item, :supplier_title)) && supplier_title.present?
      @project_item.supplier = Supplier.find_or_create_by(title: supplier_title)
    end

    respond_to do |format|
      if @project_item.save
        format.html { redirect_to project_space_url(@project_item.project_id, @project_item.project_space_id), notice: "Project item was successfully created." }
        format.json { render :show, status: :created, location: @project_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_items/1 or /project_items/1.json
  def update
    respond_to do |format|
      if @project_item.update(project_item_params)
        format.html { redirect_to project_space_url(@project_item.project_id, @project_item.project_space_id), notice: "Project item was successfully updated." }
        format.json { render :show, status: :ok, location: @project_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_items/1 or /project_items/1.json
  def destroy
    @project_item.destroy!

    respond_to do |format|
      format.html { redirect_to project_items_url, notice: "Project item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_item
      @project_item = ProjectItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_item_params
      params.fetch(:project_item, {})
        .permit(
          :category_id,
          :colour,
          :description,
          :finish,
          :internal_code,
          :material,
          :product_code,
          :project_id,
          :project_space_id,
          :quantity,
          :status_id,
          :supplier_id,
          :title,
          :unit_price,
          :url,
        )
    end
end

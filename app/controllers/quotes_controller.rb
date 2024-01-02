class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    @quote.project_id = params[:project_id]
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)
    @quote.user = current_user

    if (supplier_title = params.dig(:quote, :supplier_title)) && supplier_title.present?
      @quote.supplier = Supplier.find_or_create_by(title: supplier_title)
    end

    respond_to do |format|
      if @quote.save
        format.html { redirect_to project_url(@quote.project_id), notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    if (supplier_title = params.dig(:quote, :supplier_title)) && supplier_title.present?
      @quote.supplier = Supplier.find_or_create_by(title: supplier_title)
    end

    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to project_url(@quote.project_id), notice: "Quote was successfully updated." }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy!

    respond_to do |format|
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.fetch(:quote, {})
        .permit(
          :description,
          :expiry_date,
          :issue_date,
          :original_document,
          :project_id,
          :reference,
          :signed_document,
          :supplier_id,
          :total,
        )
    end
end

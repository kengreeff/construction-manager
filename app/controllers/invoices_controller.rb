class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]

  # GET /invoices or /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1 or /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @invoice.project_id = params[:project_id]
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user = current_user

    if (supplier_title = params.dig(:invoice, :supplier_title)) && supplier_title.present?
      @invoice.supplier = Supplier.find_or_create_by(title: supplier_title)
    end

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to project_url(@invoice.project_id), notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    if (supplier_title = params.dig(:invoice, :supplier_title)) && supplier_title.present?
      @invoice.supplier = Supplier.find_or_create_by(title: supplier_title)
    end

    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to project_url(@invoice.project_id), notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.fetch(:invoice, {})
        .permit(
          :description,
          :due_date,
          :issue_date,
          :original_document,
          :project_id,
          :quote_id,
          :reference,
          :remittance_document,
          :supplier_id,
          :total,
        )
    end
end

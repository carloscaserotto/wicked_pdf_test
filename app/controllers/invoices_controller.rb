class InvoicesController < ApplicationController
  def index
    @invoices = scope
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Invoices",
        page_size: 'A4',
        template: "invoices/index.html.erb",
        layout: "pdf.html",
        orientation: "Landscape",
        lowquality: true,
        #disposition: "attachment",
        zoom: 1,
        dpi: 75
      end
    end
  end

  def show
    #byebug
    @invoice = scope.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Invoice No. #{@invoice.id}",
        page_size: 'A4',
        template: "invoices/show.html.erb",
        layout: "pdf.html",
        orientation: "Landscape",
        lowquality: true,
        #disposition: "attachment",
        zoom: 1,
        dpi: 75
      end
    end
  end

  def new
    @invoice = Invoice.new
  end

  def create
    #byebug
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to @invoice
    else
      render :new, status: :unprocessable_entity
    end

  end
  def edit
    @invoice = Invoice.find(params[:id])
  end
  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update(invoice_params)
      redirect_to @invoice
    else
      render :edit
    end
  end

  

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    redirect_to root_path

  end

  private
  def scope
    ::Invoice.all.includes(:invoice_items)
  end
  def invoice_params
    params.require(:invoice).permit(:from_full_name, :from_address, :from_email, :from_phone, :to_full_name, 
                                     :to_address, :to_email, :to_phone, :status, :discount, :vat)
  end

end

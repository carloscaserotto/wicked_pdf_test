class InvoiceItemsController < ApplicationController
  def index
    @invoice_items = scope
  end

  def show
    @invoice_item = scope.find(params[:id])
    @invoice = Invoice.find(params[:id])
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Invoice No. #{@invoice.id}",
          page_size: 'A4',
          template: "invoice_itmes/show.html.erb",
          layout: "pdf.html",
          orientation: "Landscape",
          lowquality: true,
          zoom: 1,
          dpi: 75
        end
      end
  end

  def new
    @invoice_item = InvoiceItem.new
  end

  def create
    #byebug
    @invoice_item = InvoiceItem.new(invoice_item_params)
    if @invoice_item.save
      redirect_to invoice_items_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @invoice_item = InvoiceItem.find(params[:id])
    if @invoice_item.update(invoice_item_params)
      redirect_to @invoice_item
    else
      render :edit
    end
  end

  def edit
    @invoice = InvoiceItem.find(params[:id])
  end

  def destroy
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.destroy

    redirect_to root_path
  end
  
  private
  def scope
    ::InvoiceItem.all
  end
  def invoice_item_params
    params.require(:invoice_item).permit(:name, :description, :price, :qty, :invoice_id)
  end
end

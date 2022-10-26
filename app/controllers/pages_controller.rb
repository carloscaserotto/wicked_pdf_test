class PagesController < ApplicationController
    def home
        respond_to do |format|
            format.html
            format.pdf do
              render pdf: "Invoices",
              page_size: 'A4',
              template: "pages/home.html.erb",
              layout: "pdf.html",
              orientation: "Landscape",
              lowquality: true,
              #disposition: "attachment",
              zoom: 1,
              dpi: 75
            end
          end
    end
end
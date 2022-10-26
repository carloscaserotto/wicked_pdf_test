class Invoice < ApplicationRecord
    has_many :invoice_items, dependent: :destroy

    STATUS_CLASS = {
        :draft => "badge badge-secondary",
        :sent => "badge badge-primary",
        :paid => "badge badge-success"
    }
    FROM_FULL_NAME_CLASS = {
        :LEASA => "pagado"
    }
    def subtotal
        self.invoice_items.map { |item| item.qty * item.price }.sum
    end

    def discount_calculated
        subtotal * (self.discount / 100.0)
    end

    def vat_calculated
        (subtotal - discount_calculated) * (self.vat / 100.0)
    end

    def total
        subtotal - discount_calculated + vat_calculated
    end

    def status_class
        STATUS_CLASS[self.status.to_sym]
    end

    def from_full_name_class
        FROM_FULL_NAME_CLASS[self.from_full_name.to_sym]
    end
end

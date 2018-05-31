class LineItem < ApplicationRecord
  # Need inverse_of because https://github.com/rails/rails/issues/25198
  belongs_to :order, inverse_of: :line_items
  belongs_to :item

  #validate :consistent_organization

  validates :item_id, presence: true
  validates :quantity, numericality: { other_than: 0, only_integer: true }

  private

  def consistent_organization
    return unless order.present? && item.present?
    if order.organization_id != item.organization_id

      raise ActiveModel::Validations 'order line items must be for same organization'
    end
  end
end
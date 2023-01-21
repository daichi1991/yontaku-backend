require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { User.new(firebase_local_id: 'abcdef12345', active: true) }
  let(:product) { Product.new(user: user, name: '商品1')}
  let(:sale) { Sale.new(product: product, price: 100, publish: true) }
  let(:payment_method) { PaymentMethod.new(payment_method: 'method1') }
  let(:account) { Account.new(user: user, payment_method: payment_method, active: true) }

  it "account, saleがある場合、有効" do
    order = Order.new(
      account: account,
      sale: sale
    )
    expect(order).to be_valid
  end

  it "accountがない場合、無効" do
    order = Order.new(
      sale: sale
    )
    order.valid?
    expect(order.errors[:account]).to include("must exist")
  end

  it "saleがない場合、無効" do
    order = Order.new(
      account: account
    )
    order.valid?
    expect(order.errors[:sale]).to include("must exist")
  end
end

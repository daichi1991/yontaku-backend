json.array! @my_accounts do |my_accounts|
  json.id my_accounts.id
  json.user my_accounts.user.id
  json.payment_method do
    json.id my_accounts.payment_method.id
    json.key my_accounts.payment_method.key
    json.name my_accounts.payment_method.name
  end
end
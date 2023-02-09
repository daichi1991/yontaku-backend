json.id @account.id
json.user @account.user.id
json.payment_method do
  json.id @account.payment_method.id
  json.key @account.payment_method.key
  json.name @account.payment_method.name
end
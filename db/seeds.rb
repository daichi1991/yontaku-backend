# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.find_or_create_by(
  uid: 'GAEpfK0DwEMimbw4rKtAQBEAfBy2',
  active: true
)

product = Product.find_or_create_by(
  user: user,
  name: '難関私立文系英単語100',
  description: '最難関私立文系を目指すならマストの英単語を収録！'
)

sale = Sale.find_or_create_by(
  product: product,
  price: 1000,
  publish: true
)

payment_method = PaymentMethod.find_or_create_by(
  payment_method: 'フリー'
)

account = Account.find_or_create_by(
  user: user,
  payment_method: payment_method,
  active: true
)

order = Order.find_or_create_by(
  account: account,
  sale: sale
)

cart = Cart.find_or_create_by(
  user: user,
  sale: sale
)

question = Question.find_or_create_by(
  product: product,
  number: 1,
  question: 'りんご'
)

answer1 = Answer.find_or_create_by(
  question: question,
  answer: 'apple',
  correct: true
)

answer2 = Answer.find_or_create_by(
  question: question,
  answer: 'orange',
  correct: false
)

answer3 = Answer.find_or_create_by(
  question: question,
  answer: 'grape',
  correct: false
)

answer3 = Answer.find_or_create_by(
  question: question,
  answer: 'strawberry',
  correct: false
)
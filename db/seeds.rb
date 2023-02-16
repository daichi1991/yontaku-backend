# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
payment_method1 = PaymentMethod.find_or_create_by(
  key: 'free',
  name: 'フリー'
)

payment_method2 = PaymentMethod.find_or_create_by(
  key: 'paypal',
  name: 'ペイパル'
)

user = User.find_or_create_by(
  uid: 'abcdef12345',
  active: true
)

product = Product.find_or_create_by(
  user: user,
  name: '難関私立文系英単語100',
  description: '最難関私立文系を目指すならマストの英単語を収録！'
)

sale1 = Sale.find_or_create_by(
  product: product,
  price: 1000,
  publish: true
)

sale2 = Sale.find_or_create_by(
  product: product,
  price: 2000,
  publish: false
)

sale3 = Sale.find_or_create_by(
  product: product,
  price: 3000,
  publish: true
)

account = Account.find_or_create_by(
  user: user,
  payment_method: payment_method1,
  active: true
)

order = Order.find_or_create_by(
  account: account,
  sale: sale3
)

cart = Cart.find_or_create_by(
  user: user,
  sale: sale3
)

question1 = Question.find_or_create_by(
  product: product,
  question: 'りんご'
)

answer1_1 = Answer.find_or_create_by(
  question: question1,
  answer: 'apple',
  correct: true
)

answer1_2 = Answer.find_or_create_by(
  question: question1,
  answer: 'orange',
  correct: false
)

answer1_3 = Answer.find_or_create_by(
  question: question1,
  answer: 'grape',
  correct: false
)

answer1_4 = Answer.find_or_create_by(
  question: question1,
  answer: 'strawberry',
  correct: false
)

question2 = Question.find_or_create_by(
  product: product,
  question: '勉強'
)

answer1_1 = Answer.find_or_create_by(
  question: question2,
  answer: 'study',
  correct: true
)

answer1_2 = Answer.find_or_create_by(
  question: question2,
  answer: 'work',
  correct: false
)

answer1_3 = Answer.find_or_create_by(
  question: question2,
  answer: 'walk',
  correct: false
)

answer1_4 = Answer.find_or_create_by(
  question: question2,
  answer: 'run',
  correct: false
)
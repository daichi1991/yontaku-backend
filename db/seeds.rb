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
  username: 'テストユーザー'
  active: true
)

subject_english = Subject.find_or_create_by(
  key: 'english',
  name: '英語'
)

subject_world_history = Subject.find_or_create_by(
  key: 'world_history',
  name: '世界史'
)

subject_japanese_history = Subject.find_or_create_by(
  key: 'japanese_history',
  name: '日本史'
)

subject_mathematics = Subject.find_or_create_by(
  key: 'mathematics',
  name: '数学'
)

subject_physics = Subject.find_or_create_by(
  key: 'physics',
  name: '物理'
)

product = Product.find_or_create_by(
  user: user,
  subject: subject_english,
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
  question: '靴'
)

answer2_1 = Answer.find_or_create_by(
  question: question2,
  answer: 'shoes',
  correct: true
)

answer2_2 = Answer.find_or_create_by(
  question: question2,
  answer: 'work',
  correct: false
)

answer1_3 = Answer.find_or_create_by(
  question: question2,
  answer: 'walk',
  correct: false
)

answer2_4 = Answer.find_or_create_by(
  question: question2,
  answer: 'run',
  correct: false
)

question3 = Question.find_or_create_by(
  product: product,
  question: '電話'
)

answer3_1 = Answer.find_or_create_by(
  question: question3,
  answer: 'phone',
  correct: true
)

answer3_2 = Answer.find_or_create_by(
  question: question3,
  answer: 'cat',
  correct: false
)

answer3_3 = Answer.find_or_create_by(
  question: question3,
  answer: 'dog',
  correct: false
)

answer3_4 = Answer.find_or_create_by(
  question: question3,
  answer: 'panda',
  correct: false
)

question4 = Question.find_or_create_by(
  product: product,
  question: '猫'
)

answer4_1 = Answer.find_or_create_by(
  question: question4,
  answer: 'cat',
  correct: true
)

answer4_2 = Answer.find_or_create_by(
  question: question4,
  answer: 'dog',
  correct: false
)

answer4_3 = Answer.find_or_create_by(
  question: question4,
  answer: 'store',
  correct: false
)

answer4_4 = Answer.find_or_create_by(
  question: question4,
  answer: 'cut',
  correct: false
)

question5 = Question.find_or_create_by(
  product: product,
  question: '犬'
)

answer5_1 = Answer.find_or_create_by(
  question: question5,
  answer: 'dog',
  correct: true
)

answer5_2 = Answer.find_or_create_by(
  question: question5,
  answer: 'cat',
  correct: false
)

answer5_3 = Answer.find_or_create_by(
  question: question5,
  answer: 'store',
  correct: false
)

answer5_4 = Answer.find_or_create_by(
  question: question5,
  answer: 'cut',
  correct: false
)

question6 = Question.find_or_create_by(
  product: product,
  question: '切る'
)

answer6_1 = Answer.find_or_create_by(
  question: question6,
  answer: 'cut',
  correct: true
)

answer6_2 = Answer.find_or_create_by(
  question: question6,
  answer: 'cat',
  correct: false
)

answer6_3 = Answer.find_or_create_by(
  question: question6,
  answer: 'store',
  correct: false
)

answer6_4 = Answer.find_or_create_by(
  question: question6,
  answer: 'dog',
  correct: false
)

question7 = Question.find_or_create_by(
  product: product,
  question: 'パンダ'
)

answer7_1 = Answer.find_or_create_by(
  question: question7,
  answer: 'panda',
  correct: true
)

answer7_2 = Answer.find_or_create_by(
  question: question7,
  answer: 'cat',
  correct: false
)

answer7_3 = Answer.find_or_create_by(
  question: question7,
  answer: 'dog',
  correct: false
)

answer7_4 = Answer.find_or_create_by(
  question: question7,
  answer: 'cut',
  correct: false
)

question8 = Question.find_or_create_by(
  product: product,
  question: 'ルビー'
)

answer8_1 = Answer.find_or_create_by(
  question: question8,
  answer: 'ruby',
  correct: true
)

answer8_2 = Answer.find_or_create_by(
  question: question8,
  answer: 'cat',
  correct: false
)

answer8_3 = Answer.find_or_create_by(
  question: question8,
  answer: 'panda',
  correct: false
)

answer8_4 = Answer.find_or_create_by(
  question: question8,
  answer: 'cut',
  correct: false
)

question9 = Question.find_or_create_by(
  product: product,
  question: '箱'
)

answer9_1 = Answer.find_or_create_by(
  question: question9,
  answer: 'box',
  correct: true
)

answer9_2 = Answer.find_or_create_by(
  question: question9,
  answer: 'ruby',
  correct: false
)

answer9_3 = Answer.find_or_create_by(
  question: question9,
  answer: 'panda',
  correct: false
)

answer9_4 = Answer.find_or_create_by(
  question: question9,
  answer: 'cut',
  correct: false
)

question10 = Question.find_or_create_by(
  product: product,
  question: '部屋'
)

answer10_1 = Answer.find_or_create_by(
  question: question10,
  answer: 'room',
  correct: true
)

answer10_2 = Answer.find_or_create_by(
  question: question10,
  answer: 'box',
  correct: false
)

answer10_3 = Answer.find_or_create_by(
  question: question10,
  answer: 'ruby',
  correct: false
)

answer10_4 = Answer.find_or_create_by(
  question: question10,
  answer: 'cut',
  correct: false
)

question11 = Question.find_or_create_by(
  product: product,
  question: '蹴る'
)

answer11_1 = Answer.find_or_create_by(
  question: question11,
  answer: 'kick',
  correct: true
)

answer11_2 = Answer.find_or_create_by(
  question: question11,
  answer: 'box',
  correct: false
)

answer11_3 = Answer.find_or_create_by(
  question: question11,
  answer: 'room',
  correct: false
)

answer11_4 = Answer.find_or_create_by(
  question: question11,
  answer: 'fan',
  correct: false
)

question12 = Question.find_or_create_by(
  product: product,
  question: '頭'
)

answer12_1 = Answer.find_or_create_by(
  question: question12,
  answer: 'head',
  correct: true
)

answer12_2 = Answer.find_or_create_by(
  question: question12,
  answer: 'box',
  correct: false
)

answer12_3 = Answer.find_or_create_by(
  question: question12,
  answer: 'room',
  correct: false
)

answer12_4 = Answer.find_or_create_by(
  question: question12,
  answer: 'kick',
  correct: false
)

study1 = Study.create(
  user: user,
  product: product,
  mode: 0
)

study_detail1_1 = StudyDetail.create(
  study: study1,
  question: question1,
  answer: answer1_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail1_2 = StudyDetail.create(
  study: study1,
  question: question2,
  answer: answer2_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail1_3 = StudyDetail.create(
  study: study1,
  question: question3,
  answer: answer3_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail1_4 = StudyDetail.create(
  study: study1,
  question: question4,
  answer: answer4_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail1_5 = StudyDetail.create(
  study: study1,
  question: question5,
  answer: answer5_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail1_6 = StudyDetail.create(
  study: study1,
  question: question6,
  answer: answer6_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail1_7 = StudyDetail.create(
  study: study1,
  question: question7,
  answer: answer7_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail1_8 = StudyDetail.create(
  study: study1,
  question: question8,
  answer: answer8_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail1_9 = StudyDetail.create(
  study: study1,
  question: question9,
  answer: answer9_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail1_10 = StudyDetail.create(
  study: study1,
  question: question10,
  answer: answer10_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail1_11 = StudyDetail.create(
  study: study1,
  question: question11,
  answer: answer11_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail1_12 = StudyDetail.create(
  study: study1,
  question: question12,
  answer: answer12_2,
  skip: false,
  required_milliseconds: 1234
)

study2 = Study.create(
  user: user,
  product: product,
  mode: 0
)

study_detail2_1 = StudyDetail.create(
  study: study2,
  question: question1,
  answer: answer1_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail2_2 = StudyDetail.create(
  study: study2,
  question: question2,
  answer: answer2_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail2_3 = StudyDetail.create(
  study: study2,
  question: question3,
  answer: answer3_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail2_4 = StudyDetail.create(
  study: study2,
  question: question4,
  answer: answer4_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail2_5 = StudyDetail.create(
  study: study2,
  question: question5,
  answer: answer5_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail2_6 = StudyDetail.create(
  study: study2,
  question: question6,
  answer: answer6_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail2_7 = StudyDetail.create(
  study: study2,
  question: question7,
  answer: answer7_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail2_8 = StudyDetail.create(
  study: study2,
  question: question8,
  answer: answer8_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail2_9 = StudyDetail.create(
  study: study2,
  question: question9,
  answer: answer9_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail2_10 = StudyDetail.create(
  study: study2,
  question: question10,
  answer: answer10_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail2_11 = StudyDetail.create(
  study: study2,
  question: question11,
  answer: answer11_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail2_12 = StudyDetail.create(
  study: study2,
  question: question12,
  answer: answer12_2,
  skip: false,
  required_milliseconds: 1234
)

study3 = Study.create(
  user: user,
  product: product,
  mode: 0
)

study_detail3_1 = StudyDetail.create(
  study: study3,
  question: question1,
  answer: answer1_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail3_2 = StudyDetail.create(
  study: study3,
  question: question2,
  answer: answer2_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail3_3 = StudyDetail.create(
  study: study3,
  question: question3,
  answer: answer3_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail3_4 = StudyDetail.create(
  study: study3,
  question: question4,
  answer: answer4_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail3_5 = StudyDetail.create(
  study: study3,
  question: question5,
  answer: answer5_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail3_6 = StudyDetail.create(
  study: study3,
  question: question6,
  answer: answer6_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail3_7 = StudyDetail.create(
  study: study3,
  question: question7,
  answer: answer7_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail3_8 = StudyDetail.create(
  study: study3,
  question: question8,
  answer: answer8_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail3_9 = StudyDetail.create(
  study: study3,
  question: question9,
  answer: answer9_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail3_10 = StudyDetail.create(
  study: study3,
  question: question10,
  answer: answer10_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail3_11 = StudyDetail.create(
  study: study3,
  question: question11,
  answer: answer11_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail3_12 = StudyDetail.create(
  study: study3,
  question: question12,
  answer: answer12_2,
  skip: false,
  required_milliseconds: 1234
)

study4 = Study.create(
  user: user,
  product: product,
  mode: 0
)

study_detail4_1 = StudyDetail.create(
  study: study4,
  question: question1,
  answer: answer1_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail4_2 = StudyDetail.create(
  study: study4,
  question: question2,
  answer: answer2_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail4_3 = StudyDetail.create(
  study: study4,
  question: question3,
  answer: answer3_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail4_4 = StudyDetail.create(
  study: study4,
  question: question4,
  answer: answer4_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail4_5 = StudyDetail.create(
  study: study4,
  question: question5,
  answer: answer5_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail4_6 = StudyDetail.create(
  study: study4,
  question: question6,
  answer: answer6_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail4_7 = StudyDetail.create(
  study: study4,
  question: question7,
  answer: answer7_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail4_8 = StudyDetail.create(
  study: study4,
  question: question8,
  answer: answer8_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail4_9 = StudyDetail.create(
  study: study4,
  question: question9,
  answer: answer9_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail4_10 = StudyDetail.create(
  study: study4,
  question: question10,
  answer: answer10_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail4_11 = StudyDetail.create(
  study: study4,
  question: question11,
  answer: answer11_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail4_12 = StudyDetail.create(
  study: study4,
  question: question12,
  answer: answer12_2,
  skip: false,
  required_milliseconds: 1234
)

study5 = Study.create(
  user: user,
  product: product,
  mode: 0
)

study_detail5_1 = StudyDetail.create(
  study: study5,
  question: question1,
  answer: answer1_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail5_2 = StudyDetail.create(
  study: study5,
  question: question2,
  answer: answer2_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail5_3 = StudyDetail.create(
  study: study5,
  question: question3,
  answer: answer3_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail5_4 = StudyDetail.create(
  study: study5,
  question: question4,
  answer: answer4_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail5_5 = StudyDetail.create(
  study: study5,
  question: question5,
  answer: answer5_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail5_6 = StudyDetail.create(
  study: study5,
  question: question6,
  answer: answer6_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail5_7 = StudyDetail.create(
  study: study5,
  question: question7,
  answer: answer7_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail5_8 = StudyDetail.create(
  study: study5,
  question: question8,
  answer: answer8_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail5_9 = StudyDetail.create(
  study: study5,
  question: question9,
  answer: answer9_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail5_10 = StudyDetail.create(
  study: study5,
  question: question10,
  answer: answer10_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail5_11 = StudyDetail.create(
  study: study5,
  question: question11,
  answer: answer11_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail5_12 = StudyDetail.create(
  study: study5,
  question: question12,
  answer: answer12_2,
  skip: false,
  required_milliseconds: 1234
)

study6 = Study.create(
  user: user,
  product: product,
  mode: 0
)

study_detail6_1 = StudyDetail.create(
  study: study6,
  question: question1,
  answer: answer1_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail6_2 = StudyDetail.create(
  study: study6,
  question: question2,
  answer: answer2_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail6_3 = StudyDetail.create(
  study: study6,
  question: question3,
  answer: answer3_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail6_4 = StudyDetail.create(
  study: study6,
  question: question4,
  answer: answer4_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail6_5 = StudyDetail.create(
  study: study6,
  question: question5,
  answer: answer5_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail6_6 = StudyDetail.create(
  study: study6,
  question: question6,
  answer: answer6_1,
  skip: false,
  required_milliseconds: 1234
)

study_detail6_7 = StudyDetail.create(
  study: study6,
  question: question7,
  answer: answer7_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail6_8 = StudyDetail.create(
  study: study6,
  question: question8,
  answer: answer8_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail6_9 = StudyDetail.create(
  study: study6,
  question: question9,
  answer: answer9_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail6_10 = StudyDetail.create(
  study: study6,
  question: question10,
  answer: answer10_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail6_11 = StudyDetail.create(
  study: study6,
  question: question11,
  answer: answer11_2,
  skip: false,
  required_milliseconds: 1234
)

study_detail6_12 = StudyDetail.create(
  study: study6,
  question: question12,
  answer: answer12_2,
  skip: false,
  required_milliseconds: 1234
)

require_relative './seeds/product.rb'
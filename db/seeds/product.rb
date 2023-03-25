require 'yaml'

puts "Product -- STARTED --"

records = YAML.load_file("#{Rails.root}/lib/assets/product/product.yml")
ActiveRecord::Base.transaction do
  records.each do |record|
    if record["default_key"] == ""
      puts "FAIL: default_key is null"
      break
    end
    break if Product.exists?(default_key: record["default_key"])
    user = User.find_by(uid: record["user_uid"])
    subject = Subject.find_by(key: record["subject_key"])
    product = Product.new(
      user: user,
      subject: subject,
      name: record["name"],
      description: record["description"]
    )
    product.save!
    sale = Sale.new(product: product, price: record["sale"]["price"], publish: record["sale"]["publish"])
    sale.save!

    record["question"].each do |question_record|
      question = Question.new(product: product, question: question_record["question"])
      question.save!

      correct_answer = Answer.new(question: question, answer: question_record["correct"], correct: true)
      correct_answer.save!

      question_record["dummy"].each do |dummy|
        dummy_answer = Answer.new(question: question, answer: dummy, correct: false)
        dummy_answer.save!
      end

    end
  end
end

puts "Product -- FINISHED --"
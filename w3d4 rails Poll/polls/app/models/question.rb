# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true
  
  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )
  
  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )
  
  def results
    results_hash = Hash.new(0)
    
    answer_choices.each do |choice|
      results_hash[choice.text] = choice.responses.length
    end
    
    results_hash
  end
  
  def results_include
    results_hash = Hash.new(0)
    
    answer_choices.includes(:responses).each do |choice|
      results_hash[choice.text] = choice.responses.length
    end
    
    results_hash
  end
  
  def results_sql
    choices = AnswerChoice.find_by_sql([<<-SQL, self.id])
    SELECT 
      answer_choices.*, COUNT(responses.id) AS response_count
    FROM
      answer_choices
    JOIN
      responses
    ON
      responses.answer_choice_id = answer_choices.id
    WHERE
      answer_choices.question_id = ?
    GROUP BY
      answer_choices.id
    SQL
    
    Hash[
      choices.map do |choice|
        [choice.text, choice.response_count]
      end
    ]
  end
  
  def results_ar
    choices = self
      .answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS response_count")
      .joins(:responses)
      .where("answer_choices.question_id = ?", self.id)
      .group("answer_choices.id")
      
      Hash[
        choices.map do |choice|
          [choice.text, choice.response_count]
        end
      ]
  end
  
  def results_best
    responses.count
  end
end

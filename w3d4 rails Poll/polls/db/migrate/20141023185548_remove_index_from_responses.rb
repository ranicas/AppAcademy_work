class RemoveIndexFromResponses < ActiveRecord::Migration
  def change
    remove_index :responses, [:question_id, :answer_choice_id]
    add_index :responses, :answer_choice_id
  end
end

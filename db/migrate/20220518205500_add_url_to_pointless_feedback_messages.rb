class AddUrlToPointlessFeedbackMessages < ActiveRecord::Migration
  def change
    add_column :pointless_feedback_messages, :url, :string
  end
end

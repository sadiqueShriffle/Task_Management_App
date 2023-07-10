require 'csv'

class Task
  attr_accessor :title, :description, :completed

  def initialize(title, description)
    @title = title
    @description = description
    @completed = false
  end

  def mark_as_completed
    @completed = true
  end

  def to_csv_row
    [title, description, completed ? 'Completed' : 'Incomplete']
  end

  
end


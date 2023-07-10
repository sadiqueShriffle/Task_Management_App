require 'csv'
require_relative 'task_list'

class TaskExporter
  def export_tasks_to_csv(tasks)
    if tasks.empty?
      puts "No tasks found."
    else
      headers = ["Title", "Description", "Status"]
      CSV.open("Database.csv", "w", write_headers: true, headers: headers) do |csv|
        tasks.each { |task| csv << task.to_csv_row }
      end
      puts "Tasks exported to Database.csv successfully."
    end
  end
end

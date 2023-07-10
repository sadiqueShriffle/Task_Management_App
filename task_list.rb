require 'csv'
require_relative 'task'
require_relative 'task_exporter'

class TaskList
  
  attr_accessor :tasks
  
    def initialize
      @tasks = []
      @exporter = TaskExporter.new
     
    end

    #Add Task
    def add_task(title, description)
      if task_exists?(title)
        puts "Task with the same title already exists. Please choose a different title."
      else
        task = Task.new(title, description) # Sent it to Task Class 
        @tasks << task
        puts "Task '#{title}' added successfully."
      end
    end


    def update_task
      if @tasks.empty?
        puts "No tasks found."
        return
      end
    
      print "Enter the task ID to update (1 to #{tasks.length}):  "
      task_id = gets.chomp.to_i
    
      if valid_task_index?(task_id)
        task = @tasks[task_id - 1]
      else
        puts "\nInvalid Task Index"
        return
      end
    

      display_task_details(task)
      loop do
        puts "\nWhat would you like to update?\n"
        puts "1. Title"
        puts "2. Description"
        puts "3. Task Status"
        puts "4. Exit\n\n"
        option = gets.chomp.to_i
    
        case option
        when 1
          update_title(task)
        when 2
          update_description(task)
        when 3
          update_task_status(task)
        when 4
          break
        else
          puts "Invalid option. Please select a valid option."
        end
      end
    
      puts "Task updated successfully!"
    end
  
    
    def display_task_details(task)
      puts "\n\nTitle: #{task.title}"
      puts "Description: #{task.description}"
      puts "Complete: #{task.completed}"
    end
    
    def update_title(task)
      print "Enter the new title: "
      new_title = gets.chomp.strip
      if new_title.empty?
        puts "\nTitle Should not be empty"
      else
        if task_exists?(new_title)
          puts "\nSimilar Title Already Exists! Provide a unique name\n"
        else
          task.title = new_title 
          puts "Title   #{new_title} Updated Successfully"
          task.completed = false
        end
      end
    end
    
    def update_description(task)
      print "Enter the new description:"
      new_description = gets.chomp.strip
      task.description = new_description unless new_description.empty?
      puts "Description  #{new_description} Updated Successfully"
      task.completed = false
    end
    
    def update_task_status(task)
      print "Enter the new status (t/f): "
      new_status = gets.chomp.downcase
    
      if new_status == "t"
        task.completed = true
        puts "Task Marked as Completed"
      elsif new_status == "f"
        task.completed = false
        puts "Task Marked as Incomplete"
      else
        puts "Invalid completion status. Please enter 't' or 'f'."
        
      end
    end
    
    # List Tasks
    def list_tasks
      if @tasks.empty?
        puts "No tasks found."
      else
        puts "Tasks:"
        @tasks.each_with_index do |task, index|
          status = task.completed ? "[✔️]" : "[ ⏳ ]"
          puts "#{index + 1}. Task:        #{task.title}       #{status}"
          puts "   Description: #{task.description}"
          puts 
        end
      end
    end
  
    # Mark Task
    def mark_task_as_complete(index)
      if valid_task_index?(index)
        task = @tasks[index - 1]
        task.mark_as_completed
        puts "Task '#{task.title}' marked as complete."
      else
        puts "Invalid task index."
      end
    end
  

    # Delete Task 
    def delete_task(index)
      if valid_task_index?(index)
        task = @tasks.delete_at(index - 1)
        puts "Task '#{task.title}' deleted."
      else
        puts "Invalid task index."
      end
    end


    # calling from task_exporter
    def export_tasks_to_csv
      @exporter.export_tasks_to_csv(@tasks)
    end
  

    #Search Task
    def search_task_by_title(title)
      matching_tasks = @tasks.select { |task| task.title.downcase.include?(title.downcase) }
      display_search_results(matching_tasks)
    end

    #Display Search Result
    def display_search_results(tasks)
      if tasks.empty?
        puts "No matching tasks found."
      else
        puts "Matching tasks:"
        tasks.each_with_index do |task, index|
          status = task.completed ? "[✔️]" : "[ ⏳ ]"
          puts "#{index + 1}. Task:         #{task.title}       #{status}"
          puts "   Description: #{task.description}"
        end
      end
    end


    #Sort Task
    def sort_tasks_by_title(ascending = true)
      if @tasks.empty?
        puts "No task to perform sorting"
      else
        sorted_tasks = @tasks.sort_by(&:title)
        sorted_tasks.reverse! unless ascending
        
        puts "Tasks sorted by title in #{ascending ? 'ascending' : 'descending'} order:"
        
        sorted_tasks.each_with_index do |task, index|
          status = task.completed ? "[✔️]" : "[ ⏳ ]"
        puts "#{index + 1}. Task:         #{task.title}       #{status}"
        puts "   Description: #{task.description}"
      end
      end
    end
  
    
    #Check Task
    def task_exists?(title)
      @tasks.any? { |task| task.title.downcase == title.downcase }
    end

    def check_task_size
      return @tasks.length
    end
    
    private
    def valid_task_index?(index)
      index >= 1 && index <= @tasks.length
    end  
end
  
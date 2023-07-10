
require_relative 'task_list'
class TaskManager

    def initialize
        @task_list = TaskList.new
    end

    MAX_ATTEMPT=3

    def display_menu
        print "--------------------------------------------------\n\n"
        #puts "\nTask Manager"
        puts "1. Add a task\n"
        puts "2. Update Task"
        puts "3. List tasks\n"
        puts "4. Mark a task as complete\n"
        puts "5. Delete a task\n"
        puts "6. Export tasks to CSV\n"
        puts "7. Search a task by title\n"
        puts "8. Sort Task Title\n"
        puts "9. Exit"
        print "\n\n------------------------------------------------------\n"
      end
    
      def get_user_choice
        print "\nEnter your choice: "
        gets.chomp.to_i
      end
    
      def add_task
        invalid_title_inputs = 0  # Counter for consecutive invalid title inputs
        invalid_description_inputs = 0  # Counter for consecutive invalid description inputs
      
        loop do
          begin
            print "Enter task title: "
            title = gets.chomp.strip
            raise "Title should not be empty" if title.empty?
      
            if @task_list.task_exists?(title)
              raise "Duplicate title. Please enter a unique title."
            else
              invalid_description_inputs = 0  # Reset the counter for consecutive invalid description inputs
      
              begin
                print "Enter task description: "
                description = gets.chomp.strip
                raise "Description should not be empty" if description.empty?
              rescue => e
                invalid_description_inputs += 1  # Increment the counter for consecutive invalid description inputs
                puts e
                if invalid_description_inputs >= MAX_ATTEMPT
                  puts "\n\nMaximum number of  invalid description . Terminating the program."
                  return
                else
                  retry
                end
              end
            end
      
            @task_list.add_task(title, description)
            break
          rescue StandardError => e
            invalid_title_inputs += 1  # Increment the counter for consecutive invalid title inputs
            puts e.message
      
            if invalid_title_inputs >= MAX_ATTEMPT
              puts "\n\n Maximum number of  invalid title . Terminating the program."
              return 
            else
              retry
            end
          end
        end
      end
      
      def update_task
        @task_list.update_task
      end
  
      
      def list_tasks
        @task_list.list_tasks
      end
    
      def mark_task_as_complete
        
        if @task_list.check_task_size == 0
          puts "No Tasks Found to mark_as_completed "
        else
  
        print "\nEnter the task index to mark as complete: "
        index = gets.chomp.to_i
        
        @task_list.mark_task_as_complete(index)
         
        end
      end
  
      def delete_task
        if @task_list.check_task_size == 0
          puts "No Tasks Found to delete "
        else
        print "Enter the task index to delete: "
        index = gets.chomp.to_i
        @task_list.delete_task(index)
      end
    end

    
      def export_tasks_to_csv
        @task_list.export_tasks_to_csv
      end
    
      def search_task_by_title  # ...
        if @task_list.check_task_size == 0
          puts "No any Task Present at the Moment "
        else
        print "Enter the task title to search: "
        title = gets.chomp
        @task_list.search_task_by_title(title)
        end
      end
  
        
    def sort_tasks_by_title_menu
  
      if @task_list.check_task_size == 0
        puts "No any Task Present at the Moment "
      else
      loop do
        puts "\nSort Tasks by Title"
        puts "1. Sort in ascending order"
        puts "2. Sort in descending order"
        puts "3. Back"
  
        print "\nEnter your choice: "
        choice = gets.chomp.to_i
  
        case choice
        when 1
          @task_list.sort_tasks_by_title(true)
        when 2
          @task_list.sort_tasks_by_title(false)
        when 3
          break
        else
          puts "Invalid choice. Please try again."
        end
      end
    end
  end
end
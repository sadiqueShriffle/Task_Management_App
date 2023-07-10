require_relative 'task_manager'

class Main

    print "\n\n#####################################\n"
    print "             Task Manager            \n"
    print "#####################################\n\n"

    MAX_ATTEMPT = 3

    def initialize
      @task_call=TaskManager.new
      
    end


    def run
      invalid_inputs = 0  # Counter for invalid inputs
      loop do
        @task_call.display_menu
        if invalid_inputs >= MAX_ATTEMPT
          puts "Maximum number of invalid inputs reached. Terminating the program.\n\n"
          break
        end
        
        choice =  @task_call.get_user_choice  
        
        # Validation for maximum Attempts
       
    
        case choice
        when 1
          @task_call.add_task
        when 2
          @task_call.update_task
        when 3
          @task_call.list_tasks
        when 4
          @task_call.mark_task_as_complete
        when 5
          @task_call.delete_task
        when 6
          @task_call.export_tasks_to_csv
        when 7
          @task_call.search_task_by_title
        when 8
          @task_call.sort_tasks_by_title_menu
        when 9
          puts "Thanks...\n"
          break
        else
          invalid_inputs += 1  # Increment the counter for invalid inputs
          puts "Invalid choice. Please try again.\n\n"
        end
      end
    end
    

      # Main application
  task_manager_app = Main.new
  task_manager_app.run

  end

  # ...


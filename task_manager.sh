#!/bin/bash

tasks_file="tasks.txt"

function list_tasks {
    if [ -f "$tasks_file" ]; then
        echo "Task List:"
        cat "$tasks_file"
    else
        echo "No tasks found."
    fi
}

function add_task {
    echo "$1" >> "$tasks_file"
    echo "Task added: $1"
}

function remove_task {
    sed -i "$1d" "$tasks_file"
    echo "Task removed."
}

function prioritize_task {
    sed -i "$1d" "$tasks_file"
    task=$(sed -n "$1p" "$tasks_file")
    echo "$task (Priority)" >> "$tasks_file"
    echo "Task prioritized."
}

while true; do
    echo "Menu:"
    echo "1. List tasks"
    echo "2. Add task"
    echo "3. Remove task"
    echo "4. Prioritize task"
    echo "5. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1)
            list_tasks
            ;;
        2)
            read -p "Enter task description: " new_task
            echo "Due date (optional, leave blank if none): "
            read due_date
            echo "Priority (optional, leave blank if none): "
            read priority
            echo "Category (optional, leave blank if none): "
            read category
            task_info="$new_task"
            if [ -n "$due_date" ]; then
                task_info="$task_info - Due: $due_date"
            fi
            if [ -n "$priority" ]; then
                task_info="$task_info - Priority: $priority"
            fi
            if [ -n "$category" ]; then
                task_info="$task_info - Category: $category"
            fi
            add_task "$task_info"
            ;;
        3)
            list_tasks
            read -p "Enter task number to remove: " task_number
            remove_task "$task_number"
            ;;
        4)
            list_tasks
            read -p "Enter task number to prioritize: " task_number
            prioritize_task "$task_number"
            ;;
        5)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
done

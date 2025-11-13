//
//  UpdateTaskView.swift
//  ToDoWithWeather
//
//  Created by Akua Afrane-Okese on 2025/11/13.
//

import SwiftUI

struct UpdateTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable var task: TaskDetails
    
    var body: some View {
        
        List {
            HStack {
                Text("Enter Task:")
                    .padding(.horizontal, 8)
                TextField("", text: $task.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("Enter Description:")
                    .padding(.horizontal, 8)
                TextField("", text: $task.taskDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("Completed: ")
                Spacer()
                CheckboxFieldView(checked: (task.isCompleted)) { isChecked in
                    task.isCompleted = isChecked
                }
            }
            Button("Update") {
                dismiss()
            }.disabled(task.title.isEmpty || task.taskDescription.isEmpty)
        }
    }
}

#Preview {
    UpdateTaskView(task: TaskDetails())
}

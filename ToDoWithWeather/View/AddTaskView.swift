//
//  AddTaskView.swift
//  ToDoWithWeather
//
//  Created by Akua Afrane-Okese on 2025/11/13.
//

import SwiftUI
import SwiftData

struct AddTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var task = Task()
    
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
            Button(action: { addItem(title: task.title, description: task.taskDescription) }) {
                Text("Add")
            }.disabled(task.title.isEmpty || task.taskDescription.isEmpty)
        }
    }
    
    private func addItem(title: String, description: String) {
        withAnimation {
            let newItem = Task(title: title, taskDescription: description)
            context.insert(newItem)
        }
        dismiss()
    }
}

#Preview {
    AddTaskView()
        .modelContainer(for: Task.self)
}

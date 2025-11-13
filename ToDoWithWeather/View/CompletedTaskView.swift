//
//  CompletedTaskView.swift
//  ToDoWithWeather
//
//  Created by Akua Afrane-Okese on 2025/11/13.
//

import SwiftUI
import SwiftData

struct CompletedTaskView: View {
    
    @Query(filter: #Predicate<Task> { task in
        task.isCompleted }
        ) var savedTasks: [Task]
    
    var body: some View {
        if savedTasks.isEmpty {
            Text("No completed tasks yet.")
                .padding()
                .font(.title3)
                .bold()
        } else {
            List {
                ForEach(savedTasks) { task in
                    VStack(alignment: .leading) {
                        Text(task.title)
                            .bold()
                            .font(.title3)
                        Divider()
                        Text(task.taskDescription)
                    }
                }
            }
        }
        
    }
}

#Preview {
    CompletedTaskView()
}

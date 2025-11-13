//
//  HomeView.swift
//  ToDoWithWeather
//
//  Created by Akua Afrane-Okese on 2025/11/13.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Query(filter: #Predicate<TaskDetails> { task in
        task.isCompleted == false }
    ) var savedTasks: [TaskDetails]
    @Environment(\.modelContext) private var context
    
    @State private var showAdd = false
    @State private var editedTask: TaskDetails?
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        
        VStack {
            if let data = viewModel.current {
                Text("To Do List")
                    .font(.title2)
                    .padding()
                Text("Today's Weather")
                    .fontWeight(.semibold)
                HStack(spacing: 50) {
                    VStack {
                        Text("Temperature: \(viewModel.temperature)")
                            .fontWeight(.medium)
                        Text("Sunset: \(viewModel.sunset)")
                            .fontWeight(.medium)
                        Text("Sunrise: \(viewModel.sunrise)")
                            .fontWeight(.medium)
                    }
                    VStack {
                        AsyncImage(url: URL(string: viewModel.imageURL)) { phase in
                            if let image = phase.image {
                                image.resizable()
                            } else {
                                Image(systemName: "cloud.sun")
                                    .resizable()
                                    .frame(width:80, height:80)
                            }
                            
                        }.frame(width:80, height:80)
                    }.padding(7)
                }
            } else {
                ProgressView("Loading data...")
            }
        }.task {
            await viewModel.getWeatherDetails()
        }
        NavigationStack {
            if savedTasks.isEmpty {
                Text("No tasks yet")
                    .padding()
                    .bold()
            }
            List {
                ForEach(savedTasks) { task in
                    VStack(alignment: .leading) {
                        Text(task.title)
                            .bold()
                            .font(.title3)
                            .onTapGesture {
                                editedTask = task
                            }
                        Divider()
                        Text(task.taskDescription)
                            .onTapGesture {
                                editedTask = task
                            }
                        HStack {
                            Text("Completed: ")
                            Spacer()
                            CheckboxFieldView(checked: (task.isCompleted)) { isChecked in
                                task.isCompleted.toggle()
                            }
                        }
                    }
                }.onDelete(perform: deleteTodo)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Task") {
                        showAdd.toggle()
                    }
                }
            }
            .sheet(isPresented: $showAdd,
                   content: {
                NavigationStack {
                    AddTaskView()
                }
                .presentationDetents([.medium])
            })
            .sheet(item: $editedTask) {
                editedTask = nil
            } content: { task in
                UpdateTaskView(task: task)
            }.presentationDetents([.medium])
        }
    }
    
    private func addItem() {
        withAnimation {
            showAdd.toggle()
        }
    }
    
    func deleteTodo(indexSet: IndexSet) {
        indexSet.forEach{ index in
            let todoList = savedTasks[index]
            context.delete(todoList)
        }
        do {
            try context.save()
        } catch {
            print("error.localizedDescription")
        }
    }
}

#Preview {
    HomeView()
}

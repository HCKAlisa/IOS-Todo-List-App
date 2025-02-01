//
//  TaskEditView.swift
//  Todo List App
//
//  Created by Chung Ki Ho on 13/4/2024.
//

import SwiftUI




struct TaskEditView: View {
    
    @Binding var dueDate: Date
    @Binding var newItemName: String
    @Binding var scheduleTime: Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    enum Option: String, CaseIterable, Identifiable {
        case pink,
             red,
             orange,
             yellow,
             mint,
             teal,
             blue,
             indigo
        var id: Self{ self }
    }
    
    @State private var selectedColor: Option = .mint
    
    @ObservedObject
    var vm = ViewModel()
    
    
    var body: some View {
        let opacity = scheduleTime ? 1.0 : 0.5
        
            VStack {
                Form{
                    Section(){
                        TextField("Task Name", text: $newItemName)
                    } header: {
                        Text("Title")
                    }
                    Section(){
                        Toggle("Schedule Time", isOn: $scheduleTime)
                        DatePicker("Due Date", selection: $dueDate, in: Date()...)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .frame(maxHeight: 300)
                            .disabled(scheduleTime == false)
                            .opacity(opacity)
                    } header:{
                        Text("Due Date")
                    }
                    
                    Picker("Background Color", selection: $selectedColor){
                        ForEach(Option.allCases) { option in
                                Text(option.rawValue.capitalized)
                        }
                    }
                    
                    Rectangle()
                        .fill(getColor())

                    Button("Save", action: submit)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .navigationTitle("Add Task")

        }
    }
    
    func getColor() -> Color{
        switch selectedColor{
        case .mint:
            return Color.mint
        case .red:
            return Color.red
        case .orange:
            return Color.orange
        case .yellow:
            return Color.yellow
        case .teal:
            return Color.teal
        case .blue:
            return Color.blue
        case .indigo:
            return Color.indigo
        case .pink:
            return Color.pink
        }
    }
    
    func submit() {
        withAnimation
        {
            let item = Item(name: newItemName, scheduleTime: scheduleTime, dueDate: dueDate, bgColor: selectedColor.rawValue)
            vm.items.append(item)
            vm.save()
            newItemName = ""
            scheduleTime = false
            dueDate = Date.now
            selectedColor = .mint
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
}


struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(dueDate: .constant(Date.now), newItemName: .constant(""), scheduleTime: .constant(false),vm: ViewModel())
    }
}

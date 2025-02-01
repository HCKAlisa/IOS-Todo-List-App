//
//  FloatButton.swift
//  Todo List App
//
//  Created by Chung Ki Ho on 13/4/2024.
//

import SwiftUI

struct FloatButton: View {
    
    @Binding var dueDate: Date
    @Binding var newItemName: String
    @Binding var scheduleTime: Bool
    
    @ObservedObject //@State* updates the UI upon its changes // -> ObserveObject
    var vm = ViewModel()
    
    static let color0 = Color(red: 238/255, green: 130/255, blue: 238/255);
    static let color1 = Color(red: 0/255, green: 209/255, blue: 255/255);
    let gradient = Gradient(colors: [color0, color1]);
    
    var body: some View
    {
        
        HStack
        {
            Spacer()
            NavigationLink(destination: TaskEditView(dueDate: $dueDate, newItemName: $newItemName, scheduleTime: $scheduleTime, vm: vm))
            {
                Text("+ New Task")
                    .font(.headline)
            }
            .padding(15)
            .foregroundColor(.indigo)
            .background(gradient)
            .cornerRadius(30)
            .padding(30)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        }
        
    }
}

struct FloatButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatButton(dueDate: .constant(Date.now), newItemName: .constant("Type new Todo"), scheduleTime: .constant(false),vm: ViewModel())
    }
}

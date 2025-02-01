//
//  ContentView.swift
//  Todo List App
//
//  Created by Alisa Ho on 25/3/2024.
//

import SwiftUI

let coloredNavAppearance = UINavigationBarAppearance()
let backgroundGradient = LinearGradient(
    colors: [Color.red, Color.blue],
    startPoint: .top, endPoint: .bottom)

struct HomeScreen: View {
    static let color0 = Color(red: 238/255, green: 130/255, blue: 238/255);
    static let color1 = Color(red: 0/255, green: 209/255, blue: 255/255);
    let gradient = Gradient(colors: [color0, color1]);
    
    @StateObject //@State* updates the UI upon its changes // -> ObserveObject
    var vm = ViewModel()
    
    @State var dueDate = Date()
    @State var newItemName: String = ""
    @State var scheduleTime: Bool = false
    
    let itemsKey: String = "item_list"
    var body: some View {
        
    NavigationView{
        
            VStack(alignment: .center)
            {
                if (vm.items.count == 0)
                {
                    HStack(alignment: .center, spacing: 6)
                    {
                        Spacer()
                        VStack{
                            Text("You Finished All Your Tasks!")
                                .font(.system(size: 20))
                            Text("Keep it up!")
                                .font(.system(size: 30))
                            Text("🥳")
                                .font(.system(size: 50))
                        }
                        
                        Spacer()
                    }
                }
                else {
                    
                    let today = vm.items.filter( {$0.done == false && $0.scheduleTime == true && (formatDate(date: $0.dueDate) == formatDate(date: Date.now))})
                    let overdue = vm.items.filter({$0.done == false && $0.scheduleTime == true && (formatDate(date: $0.dueDate) < formatDate(date: Date.now))})
                    let future = vm.items.filter({$0.done == false && $0.scheduleTime == true && (formatDate(date: $0.dueDate) > formatDate(date: Date.now))})
                    let unasigned = vm.items.filter({$0.done == false && $0.scheduleTime == false})
                    
                    HStack{
                        VStack(alignment: .center, spacing: 3.0){
                            Text("Today")
                            Text(String(today.count))
                        }
                        .frame(width:80.0, height: 80.0,alignment: .center)
                        .background(gradient)
                        .foregroundColor(Color.white)
                        .cornerRadius(12.0)
                        
                        VStack(alignment: .center, spacing: 3.0){
                            Text("Overdue")
                            Text(String(overdue.count))
                        }
                        .frame(width:80.0, height: 80.0,alignment: .center)
                        .background(gradient)
                        .foregroundColor(Color.white)
                        .cornerRadius(12.0)
                        
                        VStack(alignment: .center, spacing: 3.0){
                            Text("Future")
                            Text(String(future.count))
                        }
                        .frame(width:80.0, height: 80.0,alignment: .center)
                        .background(gradient)
                        .foregroundColor(Color.white)
                        .cornerRadius(12.0)
                        
                        VStack(alignment: .center, spacing: 3.0){
                            Text("No Date")
                            Text(String(unasigned.count))
                        }
                        .frame(width:80.0, height: 80.0,alignment: .center)
                        .background(gradient)
                        .foregroundColor(Color.white)
                        .cornerRadius(12.0)
                    }
                    
                    List{
                        ForEach (0..<vm.items.count, id: \.self){ index in
                            
                            Cell(item: $vm.items[index])
                                .listRowSeparatorTint(.blue)
                                .alignmentGuide(.listRowSeparatorTrailing){ d in
                                    d[.trailing]
                                }
                                .listRowInsets(EdgeInsets())
                        }
                        .onDelete(perform: {IndexSet in
                            IndexSet.forEach{ index in
                                let itemToDelete = vm.items[index]//index
                                vm.items = vm.items.filter{$0.id != itemToDelete.id}
                            }
                        })
                        .onMove(perform: vm.Move)
                    }
                    .scrollContentBackground(.hidden)
                    .environment(\.defaultMinListRowHeight, 64)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                }
                FloatButton(dueDate: $dueDate, newItemName: $newItemName, scheduleTime: $scheduleTime,vm: vm)
            }.navigationTitle("Tasks")
        }
    }
    
    func formatDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none

        return dateFormatter.string(from: date)
    }
}



struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}


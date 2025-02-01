//
//  Cell.swift
//  Todo List App
//
//  Created by Alisa Ho on 25/3/2024.
//

import SwiftUI

struct Cell: View {
    let bubbleGumPink = Color(red: 0.9, green: 0.7, blue: 0.9)
    let moonGray = Color(white: 0.9, opacity: 0.7)
    @Binding //one variable from the published will be passed here , let's observe for it, it forced a State variable to be passed
    var item: Item
    
    var body: some View {
        let bg = item.done ?  moonGray : getColor()
        let opacity = item.done ? 0.4 : 1.0
        VStack(alignment: .leading){
            HStack()
            {
                let img = item.done ? "checkmark.square.fill" : "square"
                
                Image(systemName: img)
                    .padding([.trailing], 12)
                    .font(.system(size: 18))
                Text(item.name).strikethrough(item.done)
                    .lineLimit(1)
                    .font(.system(size: 18))
                
                if(item.scheduleTime == true){
                    Spacer()
                    Text(formatDate(date: item.dueDate))
                }

            }
            
            
        }.opacity(opacity)
            .padding()
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .background(bg)
            .onTapGesture {
                self.item.done.toggle()
            }
            .ignoresSafeArea()
    }
    
    func getColor() -> Color{
        switch (item.bgColor) {
        case "mint":
            return Color.mint
        case "red":
            return Color.red
        case "orange":
            return Color.orange
        case "yellow":
            return Color.yellow
        case "teal":
            return Color.teal
        case "blue":
            return Color.blue
        case "indigo":
            return Color.indigo
        case "pink":
            return Color.pink
        default:
            return Color.cyan
        }
    }
    
    func formatDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: date)
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell(item: .constant(Item(name: "Test", scheduleTime: false, dueDate: Date.now, bgColor: "pink")))
    }
}

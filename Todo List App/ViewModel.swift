//
//  ViewModel.swift
//  Todo List App
//
//  Created by Alisa Ho on 25/3/2024.
//

import Foundation

class ViewModel: ObservableObject //some variable can be published
{
    @Published var items: [Item] = []{
        didSet{
            save()
        }
    }
    
    let itemsKey: String = "item_list"
    
    init()
    {
        getItem()
    }
    
    func Move (from source: IndexSet, to destination: Int)
    {
        items.move(fromOffsets: source, toOffset: destination)
        save()
    }
    
    func save()
    {
        
        if let encodedData = try? JSONEncoder().encode(items)
        {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func getItem()
    {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Item].self, from: data)
        else { return }
        self.items = savedItems;
    }
    
}


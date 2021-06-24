//
//  ReminderModel.swift
//  WinRemind
//
//  Created by Winston Purnomo on 6/8/21.
//

import Foundation

class ReminderHolder: ObservableObject {
    
    @Published private(set) var reminders: Array<Reminder>
    private var newestID: Int = 1
    
    init() {
        reminders = []
        reminders.append(Reminder(id: 0, special: true, content: "Here goes your stuff", due: Date()))
    }
    
    func addReminder(content: String, due: Date) {
        objectWillChange.send()
        let cont = Reminder(id: newestID, content: content, due: due)
        reminders.append(cont)
        newestID += 1
    }
    
    struct Reminder: Hashable {

        let id: Int
        var special: Bool = false
        var done: Bool = false
        var content: String
        var due: Date
        
        mutating func markToggle() {
            self.done.toggle()
        }
        
    }
    
}

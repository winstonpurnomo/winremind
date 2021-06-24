//
//  AddView.swift
//  WinRemind
//
//  Created by Winston Purnomo on 6/8/21.
//

import SwiftUI

struct AddView: View {
    var model: ContentView
    
    @State private var text = ""
    @State private var date = Date()
    var body: some View {
        VStack {
            Button(action: {
                model.isModal = false
            }, label: {
                Image(systemName: "xmark.circle")
                Text("Cancel")
            })
            TextField("your reminder", text: $text)
            DatePicker(selection: $date, label: { Text("Date") })
            if text.count > 0 {
                Button(action: {
                    model.model.addReminder(content: text, due: date)
                    model.isModal = false
                    print(model.model.reminders)
                }, label: {
                    
                    Image(systemName: "square.and.arrow.down")
                    Text("Save")
                })
                .padding()
            } else {
                Label(
                    title: { Text("Save") },
                    icon: { Image(systemName: "square.and.arrow.down") })
                    .padding()
                    .foregroundColor(.gray)
                }
        }
        .padding()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(model: ContentView())
    }
}

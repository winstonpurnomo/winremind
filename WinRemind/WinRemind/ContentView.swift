//
//  ContentView.swift
//  WinRemind
//
//  Created by Winston Purnomo on 6/8/21.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @ObservedObject var model = ReminderHolder()
    @State var isModal: Bool = false
    @State var showDone: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("WinRemind")
                    .font(.largeTitle)
                    .bold()
                    .frame(height: geometry.size.height * 0.08, alignment: .center)
                .padding(.bottom)
                ScrollView {
                    ForEach(model.reminders, id: \.self) { reminder in
                        ReminderView(reminder: reminder)
                            .frame(height: geometry.size.height * 0.08)
                    }
                    .padding()
                }
                Spacer()
                Button("Add Reminder") {
                    self.isModal = true
                }.sheet(isPresented: $isModal, content: {
                    AddView(model: self)
                })
                .frame(alignment: .center)
            }
            .frame(alignment: .center)
        }
    }
}

struct ReminderView: View {
    @State var reminder: ReminderHolder.Reminder
    
    private func dateConverter(date: NSDate) -> String {
        let dater = DateFormatter()
        dater.dateStyle = .short
        dater.timeStyle = .short
        return dater.string(from: date as Date)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(alignment: .top) {
                    if reminder.special {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .frame(width: geometry.size.width * 0.15)
                    } else {
                        checkboxView(size: geometry)
                    }
                    if reminder.done {
                        Text(reminder.content)
                            .foregroundColor(Color.gray)
                            .strikethrough()
                            .frame(width: geometry.size.width * 0.45, alignment: .leading)
                    } else {
                        Text(reminder.content)
                            .frame(width: geometry.size.width * 0.45, alignment: .leading)
                    }
                    if reminder.special {
                        Text(" ")
                    } else {
                        Text(dateConverter(date: reminder.due as NSDate)).fontWeight(.light)
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                            .frame(width: geometry.size.width * 0.45)
                    }
                        
                }
                .padding(.vertical, 2.0)
                .frame(height: geometry.size.height * 0.08)
            }
        }
    }
    
    func checkboxView(size: GeometryProxy) -> some View {
        Button(action: {
            reminder.markToggle()
        }, label: {
            if reminder.done {
                Image(systemName: "checkmark.circle.fill")
            } else {
                Image(systemName: "circle")
            }
        })
        .frame(width: size.size.width * 0.15)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

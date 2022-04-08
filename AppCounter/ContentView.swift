//
//  ContentView.swift
//  AppCounter
//
//  Created by Gustavo Pereira on 05/04/22.
//

import SwiftUI

class Counter: ObservableObject {
    
    @Published var days = 0
    @Published var horas = 0
    @Published var minutes = 0
    @Published var seconds = 0
    
    var selectedDate = Date()
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .day, .month, .hour, .minute, .second], from: Date())
            
            let currentDate = calendar.date(from: components)
            
            let selectedComponents = calendar.dateComponents([.year, .day, .month, .hour, .minute, .second], from: self.selectedDate)
            
            var eventDateComponents = DateComponents()
            eventDateComponents.year = selectedComponents.year
            eventDateComponents.month = selectedComponents.month
            eventDateComponents.day = selectedComponents.day
            eventDateComponents.hour = selectedComponents.hour
            eventDateComponents.minute = selectedComponents.minute
            eventDateComponents.second = selectedComponents.second
            
            let eventDate = calendar.date(from: eventDateComponents)
            
            let timeLeft = calendar.dateComponents([ .day, .hour, .minute, .second], from: currentDate!, to: eventDate!)
            
            if  (timeLeft.day! >= 0 && timeLeft.hour! >= 0 && timeLeft.minute! >= 0 && timeLeft.second! >= 0){
                self.days = timeLeft.day ?? 0
                self.horas = timeLeft.hour ?? 0
                self.minutes = timeLeft.minute ?? 0
                self.seconds = timeLeft.second ?? 0
                
            } else {
                self.days = 0
                self.horas = 0
                self.minutes = 0
                self.seconds = 0
            }
            
        }
    }
    
}

struct ContentView: View {
    
    @StateObject var counter = Counter()
    
    var body: some View {
        

        
        VStack {
            DatePicker(selection: $counter.selectedDate, in: Date()..., displayedComponents: [.hourAndMinute, .date]) {
                Text("Selecione a data:")
            }.datePickerStyle(GraphicalDatePickerStyle())
            .padding()
        
            
            HStack {
                Text("\(counter.days) dias")
                    .font(.title2)
                    .fontWeight(.medium)
                Text("\(counter.horas) horas")
                    .font(.title2)
                    .fontWeight(.medium)
                Text("\(counter.minutes) min")
                    .font(.title2)
                    .fontWeight(.medium)
                Text("\(counter.seconds) seg")
                    .font(.title2)
                    .fontWeight(.medium)
                    
            }.padding()
        }
        .overlay(RoundedRectangle(cornerRadius: 16)
            .stroke(Color.gray, lineWidth: 2))
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

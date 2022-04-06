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
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .day, .month, .hour, .minute, .second], from: Date())
            
            let currentDate = calendar.date(from: components)
            
            var eventDateComponents = DateComponents()
            eventDateComponents.year = 2022
            eventDateComponents.month = 12
            eventDateComponents.day = 25
            eventDateComponents.hour = 11
            eventDateComponents.minute = 10
            eventDateComponents.second = 24
            
            let eventDate = calendar.date(from: eventDateComponents)
            
            let timeLeft = calendar.dateComponents([ .day, .hour, .minute, .second], from: currentDate!, to: eventDate!)
            
            self.days = timeLeft.day ?? 0
            self.horas = timeLeft.hour ?? 0
            self.minutes = timeLeft.minute ?? 0
            self.seconds = timeLeft.second ?? 0
        }
    }
    
}

struct ContentView: View {
    
    @StateObject var counter = Counter()
    
    var body: some View {
        
        VStack {
            HStack {
                Text("\(counter.days) dias")
                Text("\(counter.horas) horas")
                Text("\(counter.minutes) min")
                Text("\(counter.seconds) seg")
                
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

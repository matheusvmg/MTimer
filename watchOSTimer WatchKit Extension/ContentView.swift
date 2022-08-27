//
//  ContentView.swift
//  watchOSTimer WatchKit Extension
//
//  Created by Matheus Góes on 27/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

struct MainView: View {
    @State var secondScreenShown = false
    @State var timerVal = 60
    private let time = [60, 45, 30, 15, 5]
    
    var body: some View {
        VStack {
            Text("Start timer for \(timerVal) seconds")
                .font(.system(size: 18, weight: .bold, design: .default))
            Picker(selection: $timerVal, label: Text("")) {
                ForEach(time, id: \.self) { timer in
                    Text("\(timer)")
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .stroke(.red, lineWidth:  3)
                    .offset(y: 0)
                    .padding(.init(top: 17, leading: 1, bottom: 1, trailing: 1))
            )
            .background(.clear)
            NavigationLink(destination: SecondView(secondScreenShown: $secondScreenShown, timerVal: timerVal), isActive: $secondScreenShown, label: { Text("Go") })
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}

struct SecondView: View {
    @Binding var secondScreenShown: Bool
    @State var timerVal: Int
    @State var timer: Timer?
    
    var body: some View {
        if timerVal > 0 {
            VStack {
                Text("Time remaining")
                    .font(.system(size: 14))
                Text("\(timerVal)")
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(timerVal < 10 ? .red : .white)
                    .onAppear() {
                        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                            if self.timerVal > 0 {
                                self.timerVal -= 1
                            }
                        }
                    }
                Text("seconds")
                    .font(.system(size: 14))
                Button {
                    timer?.invalidate()
                    self.secondScreenShown = false
                } label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                }
            }
        } else {
            Button {
                timer?.invalidate()
                self.secondScreenShown = false
            } label: {
                Text("Done")
                    .foregroundColor(.green)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

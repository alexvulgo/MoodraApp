//
//  SessionView.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import SwiftUI

struct SessionView: View {
    
    @ObservedObject var timer : SimpleTimer = SimpleTimer(action: {})
    @State private var isPresentingTimerView = false
    let settings = [5, 10, 15, 20, 25, 30]
    @State var selectedOption = 5
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss
    
    func dismissWindow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            dismiss()
        }
    }
    
    var body: some View {
        
        if !isPresentingTimerView {
            
            HStack(alignment: .top) {
                VStack(spacing: 0) {
                    HStack(alignment: .top) {
                        Button {
                            openWindow(id: "mudraSelectionSession")
                            dismissWindow()
                        } label: {
                            Label("Back", systemImage: "chevron.backward")
                                .labelStyle(.iconOnly)
                        }
                        .offset(x: -38, y: -20)
                        
                        Text("Start session")
                            .font(.system(size: 35))
                            .bold()
                            .padding(.trailing, 60)
                            .frame(width: 270, height: 40)
                    }
                    
                    Text("Take some of your time to meditate by focusing on the movement of your hands.")
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                        .frame(width: 300, height: 50)
                        .padding()
                
                    HStack{
                        
                        Picker("Select an Option", selection: $selectedOption) {
                            ForEach(0..<settings.count) { index in
                                Text((String(format: "%d min", settings[index]))).tag(settings[index])
                            }
                        }
                        
                        Button("Start") {
                            isPresentingTimerView.toggle()
                            timer.start()
                        }
                       
                    }.onChange(of: selectedOption, {timer.set_timer(setMinutes: selectedOption)})
                        .frame(width: 420 ,height: 50)
                }.padding(.vertical, 12)
            }.frame(width: 420, height: 240)
        }
        else{
            TimerView(timer: timer, isPresented: $isPresentingTimerView, timeSelected: selectedOption)
                .glassBackgroundEffect(
                in: RoundedRectangle(
                    cornerRadius: 32,
                    style: .continuous
                )
            )
        }
    }
}

#Preview {

    SessionView().glassBackgroundEffect(
        in: RoundedRectangle(
            cornerRadius: 32,
            style: .continuous
        )
    )
}

#Preview {

    SessionView().glassBackgroundEffect(
        in: RoundedRectangle(
            cornerRadius: 32,
            style: .continuous
        )
    )
}

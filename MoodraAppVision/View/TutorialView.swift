//
//  TutorialView.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import SwiftUI

struct TutorialView: View {
    
    @Binding var selectedMudra : [Mudra]
    @Binding var dismissMudraView : Bool
    
    @Binding var count : Int //variable that updates the mudraView
    
    @State private var i = 0
    
    //Variables for hand tracking
    @State var handController : HandGestureController = HandGestureController()
    //@State var temp = false //created to test the countdown
    @State private var timer: Timer? //timer used for countdown
    @State private var counter = 5 //the user have to mantain the position for 5 seconds
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss
    
    func dismissWindow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            dismiss()
        }
    }
    
    //IMMERSIVE SPACE
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @Binding  var showImmersiveSpace : Bool
    @Binding  var immersiveSpaceIsShown : Bool
    
    var body: some View {
            
        NavigationStack {
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .top) {
                    
                    //Back Button and Immersive Space Button
                    
                    Button {
                        self.reset()
                    } label: {
                        Label("Back", systemImage: "chevron.backward")
                            .labelStyle(.iconOnly)
                    }
                    .offset(y: -8)
                    
                    Button {
                        //Immersive Space
                        showImmersiveSpace.toggle()
                    } label: {
                        Label("Immersive Space", systemImage: "mountain.2.fill")
                            .labelStyle(.iconOnly)
                    }  .onChange(of: showImmersiveSpace) { _, newValue in
                        Task {
                            if newValue {
                                switch await openImmersiveSpace(id: "beach") {
                                case .opened:
                                    immersiveSpaceIsShown = true
                                case .error, .userCancelled:
                                    fallthrough
                                @unknown default:
                                    immersiveSpaceIsShown = false
                                    showImmersiveSpace = false
                                }
                            } else if immersiveSpaceIsShown {
                                await dismissImmersiveSpace()
                                immersiveSpaceIsShown = false
                            }
                        }
                    }
                    .offset(y: -8)
                    
                }.padding()
                
                
                HStack{
                    
                    Spacer()
                    
                    Text("\(selectedMudra[i].name)")
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                }
                
                HStack{
                    
                    Spacer()
                    
                    Text("Put your hands as shown")
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                }
                
                HStack(){
                    Spacer()
                    //if(!temp){
                    if(!handController.checkMudra(mudraToCheck: selectedMudra[i].name)){
                        //Incorrect position
                        ZStack{
                            Image(systemName: "circle")
                                .foregroundStyle(.red)
                                .font(.system(size: 60))
                            
                            Text("\(String(format: "%d", counter))")
                                .bold()
                                .font(.system(size: 30))
                        }
                        .onAppear(perform: {
                            self.resetCountdown()
                        })
                        Spacer()
                        
                        HStack{
                            Spacer()
                            Text("Incorrect position")
                            Spacer()
                        }.padding()
                    }
                 else { //correct position
                    ZStack{
                        Image(systemName: "circle")
                            .foregroundStyle(.green)
                            .font(.system(size: 60))
                        
                        Text("\(String(format: "%d", counter))") //TODO: change it
                            .bold()
                            .font(.system(size: 30))
                    }
                    .onAppear(perform: {
                        self.startCountdown()
                    })
                    Spacer()
                     
                     HStack{
                         Spacer()
                         Text("Correct position")
                         Spacer()
                     }.padding()
                }
                }
                
                
            }
        }/*.onTapGesture {
            temp.toggle()
        }*/
    }
    
    
    func reset() {
           openWindow(id: "main")
           dismissMudraView = true
           dismissWindow()
           dismissWindow()
       }
    
    func resetCountdown() {
        counter = 5
        
        if ((timer?.isValid) != nil)  {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            counter -= 1

            if(counter == 0){
                i += 1
                timer?.invalidate()
                timer = nil
                if i == 3 {i = 0; self.reset(); count = 0} else {count += 1}
                //temp = false
            }
        }
    }
}



/*#Preview {
 TutorialView()
 }*/

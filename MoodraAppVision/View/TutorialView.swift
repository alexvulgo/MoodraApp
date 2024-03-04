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
    
    @State private var i = 0
    @State private var counter = 0
    
    @State var positionIsCorrect: Bool = false
    
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
                        openWindow(id: "main")
                        dismissMudraView = true
                        dismissWindow()
                        dismissWindow()
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
                        .padding()
                    
                    Spacer()
                    
                }
                
                VStack(){
                    Spacer()
                    if(!positionIsCorrect) {
                        //Incorrect position
                        ZStack{
                            Image(systemName: "circle")
                                .foregroundStyle(.red)
                                .font(.system(size: 60))
                            
                            Text("5")
                                .bold()
                                .font(.system(size: 30))
                        }
                        Spacer()
                        
                        HStack{
                            Spacer()
                            Text("Incorrect Position")
                                .bold()
                            Spacer()
                        }.padding()
                    }
                    
                    else { //correct position
                        
                        
                        
                        ZStack{
                            Image(systemName: "circle")
                                .foregroundStyle(.green)
                                .font(.system(size: 60))
                            
                            Text("4") //TODO: change it
                                .bold()
                                .font(.system(size: 30))
                        }
                        Spacer()
                        
                        HStack{
                            Spacer()
                            Text("Correct Position")
                                .bold()
                            Spacer()
                        }.padding()
                    }
                    
                }
            }
            
        }//.frame(width: 1300, height: 360)
    }
}



/*#Preview {
 TutorialView()
 }*/

//
//  MudraSelectionView.swift
//  MoodraAppVision
//
//  Created by Alessandro Esposito Vulgo Gigante on 23/02/24.
//

import SwiftUI

struct MudraSelectionView: View {
    
    //Mudra Model
    var mudra = MudraViewModel()
    
    //Variable for the scrolling  sections
    @State private var currentIndex = 0
    
    @GestureState private var dragOffset : CGFloat = 0
    
    //Mudra selection
    
    @Binding var selectedMudra : [Mudra]
    @Binding var dismissMudraView : Bool
    
    @State var selectedMudraName : [String] = []
    var isSelectable : Bool
    { selectedMudraName.count < 3 || selectedMudraName.contains(mudra.mudras[currentIndex].name)}
    
    //Starting Session
    
    //Enabling start button
    var ready : Bool { selectedMudraName.count < 3}
    
    //selected mudras quantity
    @State var mudraNumber = 0
    
    //Tutorial or session mode
    @State var tutorialMode: Bool
    
    @State var title : String = ""
    
    //Dismiss the view or open the next one
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
            HStack(alignment: .top) {
                Button {
                    openWindow(id: "main")
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
                
                Text(tutorialMode == true ? "Learn Mudras" : "Meditate")
                    .font(.title)
                
                Spacer()
            }
            VStack() {
                
                Text("Select three mudras:")
                    .font(.title)
                    .padding(.vertical,30)
                
                ZStack {
                    //Mudra Card Scrolling
                    ForEach(0..<mudra.mudras.count, id: \.self) { index in
                        ZStack(){
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.ultraThinMaterial)
                                .stroke(selectedMudraName.contains(mudra.mudras[index].name) ? Color(.green) : .clear, lineWidth: 3)
                            VStack(){
                                Image(mudra.mudras[index].images[0])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                Text(mudra.mudras[index].name)
                            }
                        }
                        .onTapGesture {
                            if(currentIndex == index) {
                                if selectedMudraName.contains(mudra.mudras[index].name) {
                                    selectedMudraName.removeAll(where: { $0 == mudra.mudras[index].name})
                                    selectedMudra.removeAll(where: { $0 == mudra.mudras[index]})
                                    mudraNumber = mudraNumber-1
                                }
                                else if isSelectable {
                                    selectedMudraName.append(mudra.mudras[index].name)
                                    selectedMudra.append(mudra.mudras[index])
                                    mudraNumber = mudraNumber+1
                                }
                            }
                        }
                        .frame(width: 240, height: 300)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.2 : 1.0)
                        .offset(x: CGFloat(index - currentIndex)*320 + dragOffset, y:0)
                        
                    }
                }.padding(.vertical,10)
                    .gesture(
                        DragGesture()
                            .onEnded({ value in
                                let threshold: CGFloat = 50
                                if value.translation.width > threshold {
                                    withAnimation {
                                        currentIndex = max(0, currentIndex-1)
                                        
                                    }
                                } else if value.translation.width < -threshold {
                                    withAnimation {
                                        currentIndex = min(mudra.mudras.count, currentIndex+1)
                                    }
                                }
                            })
                    )
                Text("\(mudraNumber)/3")
                    .bold()
                    .padding(.vertical,30)
                
                //if user is in learn mudras
                if(tutorialMode){ 
                    Button("Start"){
                        openWindow(id: "tutorial")
                        dismissMudraView = false
                        openWindow(id: "mudra")
                        dismissWindow()
                        dismissWindow()
                }
                .padding()
                .disabled(ready)
                    //if user is in meditate
                } else {
                    Button("Start"){
                        dismissMudraView = false
                        openWindow(id: "session")
                        dismissWindow()
                        dismissWindow()
                }
                .padding()
                .disabled(ready)
                }
            }
        }
    }
}




/*#Preview {
    MudraSelectionView(mudra: MudraViewModel(), tutorialMode: true)
}*/

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
    
    @State var selectedMudra : [Mudra] = []
    @State var selectedMudraName : [String] = []
    var isSelectable : Bool
    { selectedMudraName.count < 3 || selectedMudraName.contains(mudra.mudras[currentIndex].name)}
    
    //Starting Session
    
    //Enabling start button
    var ready : Bool { selectedMudraName.count < 3}
    
    //selected mudras quantity
    @State var mudraNumber = 0
    
    
    var body: some View {
        
        NavigationStack {
            
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
                                    mudraNumber = mudraNumber-1
                                    
                                }
                                
                                
                                else if isSelectable {
                                    selectedMudraName.append(mudra.mudras[index].name)
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
                
                Button(action: {
                    
                    
                    
                }, label: {
                    Text("Start")
                    //.foregroundColor(.white)
                        .padding()
                    
                }).disabled(ready)
                
                
            }.frame(height: 1000)
            
            
            
                .navigationTitle("Choose mudras")
        }
    }
}




#Preview {
    MudraSelectionView(mudra: MudraViewModel())
}

//
//  MudraSelectionView.swift
//  MoodraAppVision
//
//  Created by Alessandro Esposito Vulgo Gigante on 23/02/24.
//

import SwiftUI

struct MudraSelectionView: View {
    
    var mudra = MudraViewModel()
    
    @State var mudras : Mudra?
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(mudra.mudras) { mudras in
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.ultraThinMaterial)
                                .containerRelativeFrame(.vertical)
                                .frame(width: 250, height: 300)
                                .frame(depth: 1000)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, y: 10)
                                .scrollTransition(axis: .horizontal) { content, phase in
                                    content
                                        .rotation3DEffect(Angle(degrees: (phase.value * -30)), axis: (x: 0, y: 1 , z: 0))
                                        
                                        .scaleEffect(x: phase.isIdentity ? 1 : 0.8 , y: phase.isIdentity ? 1 : 0.8)
                                
                                }
                            
                                .onTapGesture {
                                    withAnimation {
                                        self.mudras = mudras
                                    }
                                }
                            
                            
                        } .scrollTargetLayout()
                    }
                    
                    .frame(height: 300)
                    .safeAreaPadding(.horizontal,32)
                    .scrollClipDisabled()
                    .scrollTargetBehavior(.viewAligned)
                    .defaultScrollAnchor(.center)
                    
                    
                }
            }
            
        }
    }
}




#Preview {
    MudraSelectionView(mudra: MudraViewModel())
}

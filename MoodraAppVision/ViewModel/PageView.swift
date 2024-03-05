//
//  PageView.swift
//  MoodraAppVision
//
//  Created by Alessandro Esposito Vulgo Gigante on 05/03/24.
//

import SwiftUI


//Onboarding


struct PageView: View {
    
    var page : Page
    
    var body: some View {
        VStack(spacing: 20) {
            
            ZStack{
                Circle()
                    .fill(Color.white)
                    .frame(width: 222, height: 222)
                
                Image("Main")
                    .resizable()
                    .frame(width: 222, height: 222)
                
            }
            .padding()
            
            
            Text(page.name)
                .font(.largeTitle)
            
            Text(page.description)
                
        }.frame(width: 600)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    PageView(page: Page.samplePage)
}

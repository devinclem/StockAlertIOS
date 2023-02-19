//
//  noEntryView.swift
//  StockAlert
//
//  Created by Devin C on 11/12/22.
//

import SwiftUI

struct noEntryView: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.9
    @State var uuidUsed: Bool = false
    @State var showSettings: Bool = false
    var body: some View {
        if isActive {
            changeSettings()
        }
        
       
        
        else {
            
            ZStack {
                Color(.darkGray)
                    .ignoresSafeArea()
                VStack {
                    
                    VStack {
                        Spacer()
                        Image(systemName: "centsign.circle")
                            .font(.system(size:200))
                            .foregroundColor(.green)
                        Text("Setting invalid: ")
                            .font(Font.custom("Copperplate", size: 26))
                            .foregroundColor(.black.opacity((0.80)))
                        Text("Select at least one option")
                            .font(Font.custom("Copperplate", size: 26))
                            .foregroundColor(.black.opacity((0.80)))
                        Spacer()
                        Spacer()
                        
                            
                    }
                
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        isAppAlreadyLaunchedOnce()
                        withAnimation(.easeInOut(duration: 1.0)) {
                            self.size = 0.9
                            self.opacity = 0.8
                        }
                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true

                        }
                    }
                    
                }
                
            
            }
        }
        
        
    }
}

struct noEntryView_Previews: PreviewProvider {
    static var previews: some View {
        noEntryView()
    }
}

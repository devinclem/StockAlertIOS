//
//  changedView.swift
//  StockAlert
//
//  Created by Devin C on 11/12/22.
//

import SwiftUI

struct changedView: View {
    
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
                            //.foregroundColor(Color("dreamBlue"))
                            .overlay(
                                (LinearGradient(gradient: Gradient(colors: [Color("dreamBlue"), Color("dreamPurple")]), startPoint: .leading, endPoint: .trailing))
                                )
                            .mask(
                                        Text("Settings Changed")
                                            .font(Font.system(size: 46, weight: .bold))
                                            .multilineTextAlignment(.center)
                                    )
                        
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

struct changedView_Previews: PreviewProvider {
    static var previews: some View {
        changedView()
    }
}

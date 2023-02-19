//
//  youHaveUnsubscribed.swift
//  StockAlert
//
//  Created by Devin C on 11/11/22.
//

import SwiftUI

struct youHaveUnsubscribed: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.9
    @State var uuidUsed: Bool = false
    @State var showSettings: Bool = false
    var body: some View {
        if isActive {
            SignUpView()
        }
       
        
        else {
            
            ZStack {
                Color(.darkGray)
                    .ignoresSafeArea()
                VStack {
                    
                    VStack {
                        Spacer()
                        Text("Unsubscribed")
                            .font(.system(size:200))
                            .frame(maxWidth: .infinity)
                            //.foregroundColor(Color("dreamBlue"))
                            .overlay(
                                (LinearGradient(gradient: Gradient(colors: [Color("dreamBlue"), Color("dreamPurple")]), startPoint: .leading, endPoint: .trailing))
                                )
                            .mask(
                                        Text("Unsubscribed")
                                            .font(Font.system(size: 46, weight: .bold))
                                            .multilineTextAlignment(.center)
                                            .frame(maxWidth: .infinity)
                                    )
                        
                        Spacer()
                        Spacer()
                        
                            
                    }
                
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        isAppAlreadyLaunchedOnce()
                        withAnimation(.easeInOut(duration: 1.7)) {
                            self.size = 0.9
                            self.opacity = 0.8
                        }
                    }
                }
                .onAppear{
                    isIdUsed(ID: getUUID(), completion: idUsed)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true

                        }
                    }
                    
                }
                
            
            }
        }
        
        
    }
    
    func idUsed(used: Bool) {
        
        self.uuidUsed = used
       
    }
        
}


struct youHaveUnsubscribed_Previews: PreviewProvider {
    static var previews: some View {
        youHaveUnsubscribed()
    }
}

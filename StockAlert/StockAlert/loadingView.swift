//
//  loadingView.swift
//  StockAlert
//
//  Created by Devin C on 11/11/22.
//

import SwiftUI

struct loadingView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.9
    @State var uuidUsed: Bool = false
    @State var showSettings: Bool = false
    var body: some View {
        
        
        
        
            
            ZStack {
                Color(.darkGray)
                    .ignoresSafeArea()
                VStack {
                    
                    VStack {
                        Spacer()
                        Image(systemName: "centsign.circle")
                            .font(.system(size:200))
                            .foregroundColor(.green)
                        Text("StockAlert")
                            .font(Font.custom("Copperplate", size: 26))
                            .foregroundColor(.black.opacity((0.80)))
                        Spacer()
                        Spacer()
                        
                            
                    }
                
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        
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
                            
                        }
                    }
                    
                }
                
            
            }
        
        
        
    }
    
    func idUsed(used: Bool) {
        
        self.uuidUsed = used
       
    }
        
}
}

struct loadingView_Previews: PreviewProvider {
    static var previews: some View {
        loadingView()
    }
}

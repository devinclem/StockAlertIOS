//
//  ContentView.swift
//  StockAlert
//
//  Created by Devin C on 11/5/22.
//

import SwiftUI
import Firebase
import AudioToolbox

struct ContentView: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.9
    @State var uuidUsed: Bool = false
    @State var showSettings: Bool = false
    @State var databaseconfigured: Bool = false
    var body: some View {
        if isActive {
            SignUpView()
        }
        else if showSettings {
            changeSettings()
        }
        
        
        else {
            
            ZStack {
                Color(.darkGray)
                    .ignoresSafeArea()
                VStack {
                    
                    VStack {
                        Spacer()
                        Image("Logo")
                            .resizable()
                            .frame(maxWidth: 250, maxHeight: 250)

                        Spacer()
                        
                            
                    }
                
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        
                        configureDatabase()
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
                            if self.uuidUsed {
                                self.showSettings = true
                            }
                            else  {
                                self.isActive = true

                            }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func isAppAlreadyLaunchedOnce() -> Bool {
    let defaults = UserDefaults.standard
    if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
        getUUID()
        print("App already launched")
        return true
    } else {
        setUserID()
        defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
        print("App launched first time")
        return false
    }
}

func vibratePhone() {
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
}

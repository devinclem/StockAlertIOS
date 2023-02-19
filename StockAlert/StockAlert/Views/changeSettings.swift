//
//  changeSettings.swift
//  StockAlert
//
//  Created by Devin C on 11/7/22.
//

import SwiftUI

struct changeSettings: View {
    @State var number = ""
    @State var cluster: Bool = false
    @State var insider: Bool = false
    @State var penny: Bool = false
    @State var entrySubmitted: String? = nil
    @State var maxCircleHeight: CGFloat = 0
    @State var showSettingsChanged: Bool = false
    @State var unsubscribed: Bool = false
    @State var noEntrySelected: Bool = false
    @State var whatisSA: Bool = false
    @State var recentBuys: Bool = false
    
    var body: some View {
        if unsubscribed {
            Unsubscribe()
        }
        else if entrySubmitted != nil{
            changedView()
        }
        else if recentBuys {
            recentBuysView(cameFrom: "changeSettings")
        }
//        else if noEntrySelected {
//            noEntryView()
//        }
        else {
            
            
            ZStack {
                Color("softGray")
                    .ignoresSafeArea()
                VStack {
                    GeometryReader{proxy -> AnyView in
                        
                        let height = proxy.frame(in: .global).height
                        
                        DispatchQueue.main.async {
                            if maxCircleHeight == 0 {
                                maxCircleHeight = height
                            }
                        }
                        
                        return AnyView (
                            
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPink"), Color("dreamPurple")]), startPoint: .leading, endPoint: .trailing))                                    .offset(x: getRect().width / 2, y:
                                                -height / 1.3)
                                    .shadow(radius: 10)

                                
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPurple"), Color("dreamPink")]), startPoint: .leading, endPoint: .trailing))                                    .offset(x: -getRect().width / 2, y:
                                                -height / 1.7)
                                    .shadow(radius: 10)
                                
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamBlue"), Color("dreamPurple")]), startPoint: .leading, endPoint: .trailing))                                    .offset(y:
                                                -height / 1.2)
                                    .shadow(radius: 10)

                                
                                
                            }
                        )
                        
                    }
                    .frame(maxHeight: getRect().width)
                    
                    
                    VStack {
                        
                        Text("Change my Settings")
                            .font(.title)
                            .fontWeight(.bold)
                        //.foregroundColor(Color("dark"))
                        //Letter Spacing
                            .kerning(1.9)
                            .frame(alignment: .leading)
                            .padding(.bottom, 1)
                        HStack {
                            Text("You are already a member.")
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        Text("Change your settings here:")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 8, content: {
                            HStack {
                                Text("Options:")
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                if self.cluster {
                                    Text("Cluster")
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }
                                if self.insider {
                                    Text("Insider")
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }
                                if self.penny {
                                    Text("Penny Stock")
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }
                                
                            }
                            
                            
                            HStack {
                                Button("Cluster") {
                                    self.cluster = !self.cluster
                                    
                                }
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(cluster ? Color("dreamBlue") : Color(.lightGray))                                .padding()
                                .background(
                                    Color(.darkGray)
                                        .cornerRadius(40.0)
                                        .shadow(radius: 10)
                                )
                                Spacer()
                                Button("Insider") {
                                    self.insider = !self.insider
                                }
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(insider ? Color("dreamBlue") : Color(.lightGray))                                .padding()
                                
                                .background(
                                    Color(.darkGray)
                                        .cornerRadius(40.0)
                                        .shadow(radius: 10)
                                )
                                Spacer()
                                Button("Penny") {
                                    self.penny = !self.penny
                                }
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(penny ? Color("dreamBlue") : Color(.lightGray))                                .padding()
                                .background(
                                    Color(.darkGray)
                                        .cornerRadius(40.0)
                                        .shadow(radius: 10)
                                )
                            }
                            
                            
                            Divider()
                            
                        })
                        .padding(.top,25)
                        
                        
                        .padding(.top,25)
                        
                        Spacer()
                            .frame(height: 20.0)
                        if noEntrySelected {
                            Text("Please select an option")
                                .foregroundColor(.red)
                        }
                        Button(action: {
                            getUserPhone(ID: getUUID(), completion: settingsChanged)
                        }, label: {
                            
                            Text("Change my Settings")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.white))
                                .padding()
                                .padding(.horizontal, 50)
                                .background(
                                    Color(.darkGray)
                                        .cornerRadius(40.0)
                                        .shadow(radius: 10)
                                )
                        })
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                        
                        
                        
                        
                    }
                    .padding()
                    .padding(.top, -maxCircleHeight / 1.7)
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                .overlay (
                    VStack {
                        Button(action: {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                withAnimation {
                                    self.recentBuys = true
                                }
                            }
                        }, label: {
                            
                            Text("Recent Trades")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.white))
                                .padding()
                                .padding(.horizontal, 50)
                                .background(
                                    Color(.darkGray)
                                        .cornerRadius(40.0)
                                        .shadow(radius: 10)
                                )
                        })
                        .padding(.bottom, 15)
                        HStack {
                            
                           
                            Button(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                    withAnimation {
                                        self.unsubscribed = true
                                    }
                                }
                            }, label: {
                                Text("Unubscribe")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("dreamBlue"))
                                    .font(.caption)
                                
                            })
                            
                        }
                        
                        
                    }
                    ,alignment: .bottom
                )
                .background(
                    HStack {
                        Circle ()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPink"), Color("dreamLightBlue")]), startPoint: .leading, endPoint: .trailing))                            .frame(width: 130, height: 130)
                            .offset(x: -30, y: 80)
                            .shadow(radius: 10)

                        Spacer(minLength: 0)
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPurple"), Color("dreamBlue")]), startPoint: .leading, endPoint: .trailing))                            .frame(width: 170, height: 170)
                            .offset(x: 90, y: 80)
                            .shadow(radius: 10)

                    }
                    ,alignment: .bottom
                )
                
            }
        }
        
    }
  
    func settingsChanged(submitted: String) {

        if !self.cluster && !self.insider && !self.penny {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation {
                    self.noEntrySelected = true
                }
            }
            vibratePhone()
        }
        else {
            self.entrySubmitted = submitted
            changeUserSettings(cluster: cluster, Insider: insider, Penny: penny, phoneNumber: submitted);
            
            if !self.cluster {
                removeFromCluster(userID: getUUID())
            }
            if !self.penny {
                removeFromPenny(userID: getUUID())
            }
            if !self.insider {
                removeFromInsider(userID: getUUID())
            }
        }
    }
        
}

struct changeSettings_Previews: PreviewProvider {
    static var previews: some View {
        changeSettings()
    }
}



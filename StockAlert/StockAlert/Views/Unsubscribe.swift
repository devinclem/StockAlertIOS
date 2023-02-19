//
//  Unsubscribe.swift
//  StockAlert
//
//  Created by Devin C on 11/11/22.
//

import SwiftUI

struct Unsubscribe: View {
    @State var number = ""
    @State var cluster: Bool = false
    @State var insider: Bool = false
    @State var penny: Bool = false
    @State var entrySubmitted: String? = nil
    @State var maxCircleHeight: CGFloat = 0
    @State var showSettingsChanged: Bool = false
    @State var unsubscribed: Bool = false
    var body: some View {
        if unsubscribed {
            youHaveUnsubscribed()
        }
        else if showSettingsChanged {
            changeSettings()
        }
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
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPink"), Color("dreamPurple")]), startPoint: .leading, endPoint: .trailing))
                                    .offset(x: getRect().width / 2, y:
                                                -height / 1.3)
                                    .shadow(radius: 10)

                                
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamBlue"), Color("dreamPurple")]), startPoint: .leading, endPoint: .trailing))
                                    .offset(x: -getRect().width / 2, y:
                                                -height / 1.7)
                                    .shadow(radius: 10)

                                
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamLightBlue"), Color("dreamPink")]), startPoint: .leading, endPoint: .trailing))
                                    .offset(y:
                                                -height / 1.2)
                                    .shadow(radius: 10)
                                
                                
                            }
                        )
                        
                    }
                    .frame(maxHeight: getRect().width)
                    
                    
                    VStack {
                        Text("Unsubscribe")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                        //.foregroundColor(Color("dark"))
                        //Letter Spacing
                            .kerning(1.9)
                            .frame(alignment: .leading)
                            .padding(.bottom, 1)
                        HStack {
                            Text("Click Unsubscribe to stop receiving StockAlert notifications")
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .font(.caption)
                            
                            
                        }
                        //Email and password
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            
                            
                            
                            Divider()
                            
                        })
                        .padding(.top,25)
                        
                        
                        .padding(.top,25)
                        
                        Spacer()
                            .frame(height: 50.0)
                        Button(action: {
                            unsubscribe(userID: getUUID())
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                withAnimation {
                                    self.unsubscribed = true
                                }
                            }
                        }, label: {
                            
                            Text("Unsubscribe")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
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
                        HStack {
                            
                            
                            Button(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                    withAnimation {
                                        self.showSettingsChanged = true
                                    }
                                }
                            }, label: {
                                Text("Change my Settings")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("dreamPurple"))
                                    .font(.caption)
                                
                            })
                        }
                        
                        
                    }
                    ,alignment: .bottom
                )
                .background(
                    HStack {
                        Circle ()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPurple"), Color(.white)]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: 130, height: 130)
                            .offset(x: -30, y: 80)
                            .shadow(radius: 10)

                        Spacer(minLength: 0)
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamBlue"), Color("dreamPink")]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: 170, height: 170)
                            .offset(x: 90, y: 80)
                            .shadow(radius: 10)

                    }
                    ,alignment: .bottom
                )
                
            }
        }
    }
        
    
}

struct Unsubscribe_Previews: PreviewProvider {
    static var previews: some View {
        Unsubscribe()
    }
}

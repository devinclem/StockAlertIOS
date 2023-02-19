//
//  infoViewSignUp.swift
//  StockAlert
//
//  Created by Devin C on 11/13/22.
//

import SwiftUI

struct infoViewSignUp: View {
    @State var number: String = ""
    @State var cluster: Bool = false
    @State var insider: Bool = false
    @State var penny: Bool = false
    @State var backClicked: Bool = false
    @State var maxCircleHeight: CGFloat = 0
    @State var uuidUsed: Bool = false
    var body: some View {
        if backClicked{
            SignUpView()
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
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamBlue"), Color("dreamPurple")]), startPoint: .leading, endPoint: .trailing))                                   .offset(x: getRect().width / 2, y:
                                                -height / 1.3)
                                    .shadow(radius: 10)

                                
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPink"), Color("dreamPurple")]), startPoint: .leading, endPoint: .trailing))                                    .offset(x: -getRect().width / 2, y:
                                                -height / 1.7)
                                    .shadow(radius: 10)
                                
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamLightBlue"), Color("dreamPurple")]), startPoint: .leading, endPoint: .trailing))                                    .offset(y:
                                                -height / 1.2)
                                    .shadow(radius: 10)

                                
                                
                            }
                        )
                        
                    }
                    .frame(maxHeight: getRect().width)
                    
                    
                    VStack {
                        Text("What is StockAlert?")
                            .font(.title)
                            .fontWeight(.bold)
                        //Letter Spacing
                            .kerning(1.9)
                            .frame(alignment: .leading)
                            .padding(.bottom, 1)
                        
                        HStack {
                            Text("StockAlert sends you notifications in three cases:")
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .font(.caption)
                                .frame(alignment: .leading)
                                .multilineTextAlignment(.center)
                            
                        }
                        
                        //Email and password
                        VStack(alignment: .center, spacing: 8, content: {
                        
                            Text("Insider Purchase:")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(alignment: .leading)
                                .multilineTextAlignment(.center)
                            Text("Nobody knows more about a company and their future than the CEOs, CFOs, Chairmen and Directors (The Insiders). You can use their trade purchases in your analysis since the insiders know most about a stocks future.")
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .font(.caption)
                                .frame(alignment: .leading)
                                .multilineTextAlignment(.center)
                            Divider()
                            Text("Cluster Purchase:")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(alignment: .leading)
                                .multilineTextAlignment(.center)
                                .padding(.top, 8)
                            Text("A cluster purchase is when a trade is purchased at a high volume, usually by a whale in the trading industry. Knowing what successful traders are purchasing can prove to be a huge advantage when creating your own analyzation of a stock.")
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .font(.caption)
                                //.frame(height: 90, alignment: .leading)
                                .multilineTextAlignment(.center)
                                
                            Divider()
                            
                            Text("Penny Stock Purchase:")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(alignment: .leading)
                                .multilineTextAlignment(.center)
                                .padding(.top, 8)
                            Text("Penny Stock purchases are stocks that trade for a low price, often at a high volume. Penny Stocks are often used by traders because of the easy entry and high potential profit. StockAlert will notify you when a penny stock is traded at a high volume.")
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .font(.caption)
                                .frame(alignment: .leading)
                                .multilineTextAlignment(.center)
                                        
                        })
                        .padding(.top,25)
                        
                        
                        
                        
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
                                    self.backClicked = true
                                }
                            }
                        }, label: {
                            
                            Text("Back")
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
                        HStack {
                            Text("StockAlert")
                                .fontWeight(.bold)
                                .foregroundColor(Color("dreamPurple"))
                                .font(.caption)
                            
                            
                        }
                        
                        
                    }
                    ,alignment: .bottom
                )
                .background(
                    HStack {
                        Circle ()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPurple"), Color("dreamBlue")]), startPoint: .leading, endPoint: .trailing))                          .frame(width: 130, height: 130)
                            .offset(x: -30, y: 80)
                            .shadow(radius: 10)

                        Spacer(minLength: 0)
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPink"), Color("dreamLightBlue")]), startPoint: .leading, endPoint: .trailing))                            .frame(width: 170, height: 170)
                            .offset(x: 90, y: 80)
                            .shadow(radius: 10)

                    }
                    ,alignment: .bottom
                )
                
            }
        }
        }
}

struct infoViewSignUp_Previews: PreviewProvider {
    static var previews: some View {
        infoViewSignUp()
    }
}

//
//  SignUpView.swift
//  StockAlert
//
//  Created by Devin C on 11/5/22.
//

import SwiftUI

struct SignUpView: View {
    @State var number: String = ""
    @State var cluster: Bool = false
    @State var insider: Bool = false
    @State var penny: Bool = false
    @State var subscribedClicked: Bool = false
    @State var maxCircleHeight: CGFloat = 0
    @State var uuidUsed: Bool = false
    @State var whatisSA: Bool = false
    @State var notTenDigits: Bool = false
    @State var recentBuys: Bool = false
    @State var noOptionsChosen: Bool = false
    
    var body: some View {
        if recentBuys {
            recentBuysView(cameFrom: "SignUp")
        }
        
        else if subscribedClicked{
            changeSettings()  
        }
        else if whatisSA {
            infoViewSignUp()
        }
        else {
            let valueProxy = Binding<String>(
                get: {number},
                set: {number = String($0.prefix(10))}
            
            )
            
            
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
                        Text("Sign up for StockAlert:")
                            .font(.title)
                            .fontWeight(.bold)
                        //Letter Spacing
                            .kerning(1.9)
                            .frame(alignment: .leading)
                            .padding(.bottom, 1)
                        HStack {
                            Text("Choose your notification settings. You can change these later.")
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .font(.caption)
                                .frame(alignment: .leading)
                            
                        }
                        
                        //Email and password
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
                                .foregroundColor(cluster ? Color("dreamBlue") : Color(.lightGray))
                                .padding()
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
                                .foregroundColor(insider ? Color("dreamBlue") : Color(.lightGray))
                                .padding()
                                
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
                                .foregroundColor(penny ? Color("dreamBlue") : Color(.lightGray))
                                .padding()
                                .background(
                                    Color(.darkGray)
                                        .cornerRadius(40.0)
                                        .shadow(radius: 10)
                                )
                            }
                            
                            
                            Divider()
                            
                        })
                        .padding(.top,25)
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            Text("Phone Number")
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            
                            TextField("1234567890", text: valueProxy)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.top, 5)
                                .keyboardType(.decimalPad)
                            
                            Divider()
                            
                        })
                        .padding(.top,25)
                        VStack {
                            if notTenDigits {
                                Text("Phone number must be 10 digits.")
                                    .foregroundColor(.red)
                            }
                            if noOptionsChosen {
                                Text("Please select an option.")
                                    .foregroundColor(.red)
                            }
                            
                            
                        }
                        Button(action: {
                            if number.count != 10 {
                                self.notTenDigits = true
                            }
                            else {
                                self.notTenDigits = false
                            }
                            if !cluster && !insider && !penny {
                                self.noOptionsChosen = true
                            }
                            else {
                                self.noOptionsChosen = false
                            }
                            if self.noOptionsChosen || self.notTenDigits{
                                //Do nothing
                                vibratePhone()
                            }
                            else {
                                
                                acceptEntry(phoneNumber: number, cluster: cluster, Insider: insider, Penny: penny);
                                isIdUsed(ID: getUUID(), completion: idUsed)
                            }

                           
                        }, label: {
                            
                            Text("Subscribe")
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
                        Button(action: {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                withAnimation {
                                    self.whatisSA = true
                                }
                            }
                        }, label: {
                            Text("What is Stock Alert?")
                                .fontWeight(.bold)
                                .foregroundColor(Color("dreamPurple"))
                                .font(.caption)
                            
                        })
                        .padding(.bottom, 2)
                        
                        
                        
                        
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
    
    func idUsed(used: Bool) {
        self.uuidUsed = used
        self.subscribedClicked = true
        print(cluster)
        print(insider)
        print(penny)
        print(noOptionsChosen)

    }
    
    
    
     
    
    
        
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


extension View {
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
    
}



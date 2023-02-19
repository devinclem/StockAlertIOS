//
//  recentBuysView.swift
//  StockAlert
//
//  Created by Devin C on 11/21/22.
//

import SwiftUI

struct recentBuysView: View {
    @State var number: String = ""
    @State var cluster: Bool = true
    @State var insider: Bool = true
    @State var penny: Bool = true
    @State var allTrades: Bool = false
    @State var maxCircleHeight: CGFloat = 0
    @State var uuidUsed: Bool = false
    @State var whatisSA: Bool = false
    @State var viewDidLoad: Bool = false
    @State var theData: Array<trade> = []
    @State var options: Array<Bool> = [true, true, true]
    @State var cameFrom: String
    @State var backPressed: Bool = false
    let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        
        if backPressed {
            if cameFrom == "SignUp" {
                SignUpView()
            }
            else {
                changeSettings()
            }
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
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPink"), Color(.white)]), startPoint: .bottom, endPoint: .top))
                                    .offset(x: getRect().width / 2, y:
                                                -height / 1.3)
                                    .shadow(radius: 10)
                                
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPurple"), Color("dreamBlue")]), startPoint: .center, endPoint: .trailing))
                                    .offset(x: -getRect().width / 2, y:
                                                -height / 1.7)
                                    .shadow(radius: 10)
                                
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamBlue"), Color("dreamPink")]), startPoint: .trailing, endPoint: .leading))
                                    .offset(y:
                                                -height / 1.2)
                                    .shadow(radius: 10)
                                
                                
                            }
                                .onAppear {
                                    loadTradeHistory(options: [self.cluster, self.insider, self.penny],completion: loadhistory)
                                    
                                }
                        )
                        
                    }
                    .frame(maxHeight: getRect().width)
                    
                    
                    VStack {
                        Text("Most Recent Trades:")
                            .font(.title)
                            .fontWeight(.bold)
                        //Letter Spacing
                            .kerning(1.9)
                            .frame(alignment: .leading)
                            .padding(.bottom, 1)
                        HStack {
                            Button(action: {
                                self.cluster = !self.cluster;
                                self.allTrades = !self.allTrades;
                                loadTradeHistory(options: [self.cluster, self.insider, self.penny], completion: loadhistory)
                            }, label: {
                                Text("Cluster")
                                    .fontWeight(.bold)
                                    .foregroundColor(cluster ? Color("dreamBlue") : Color(.lightGray))
                                    .font(.body)
                                    .padding()
                                    .background(
                                        Color(.darkGray)
                                            .cornerRadius(40.0)
                                            .shadow(radius: 10)
                                    )
                                
                            })
                            
                            .padding(.trailing, 10)
                            
                            
                            Button(action: {
                                self.insider = !self.insider;
                                self.allTrades = false;
                                loadTradeHistory(options: [self.cluster, self.insider, self.penny], completion: loadhistory)
                                
                            }, label: {
                                Text("Insider")
                                    .fontWeight(.bold)
                                    .foregroundColor(insider ? Color("dreamBlue") : Color(.lightGray))
                                    .font(.body)
                                    .padding()
                                    .background(
                                        Color(.darkGray)
                                            .cornerRadius(40.0)
                                            .shadow(radius: 10)
                                    )
                                
                            })
                            
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            
                            Button(action: {
                                self.penny = !self.penny;
                                self.allTrades = false;
                                loadTradeHistory(options: [self.cluster, self.insider, self.penny], completion: loadhistory)
                            }, label: {
                                Text("Penny")
                                    .fontWeight(.bold)
                                    .foregroundColor(penny ? Color("dreamBlue") : Color(.lightGray))
                                    .font(.body)
                                    .padding()
                                    .background(
                                        Color(.darkGray)
                                            .cornerRadius(40.0)
                                            .shadow(radius: 10)
                                    )
                                
                            })
                            
                            .padding(.leading, 10)
                            
                            
                        }
                        VStack(alignment: .leading, spacing: 8, content: {
                                if self.theData.count != 0 {
                                    ScrollView {
                                        
                                        
                                        ForEach(self.theData) { trade in
                                            CustomRowView(ticker: trade.ticker, price: trade.price, date: trade.datetoString(), PChange: trade.percentChange, qty: trade.qty, type: trade.type)
                                            
                                        }
                                        
                                        
                                    }
                                    .cornerRadius(20)
                                    .frame(height: (screenHeight/2))

                            }
                        })
                        .padding(.top,25)
                        .frame(maxWidth: .infinity)

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
                                    self.backPressed = true
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
                        
                        .padding(.bottom, 2)
                        HStack {
                            Text("StockAlert")
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .font(.caption)
                            
                            
                        }
                        
                        
                        
                    }
                    ,alignment: .bottom
                )
                .background(
                    HStack {
                        Circle ()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamBlue"), Color("dreamPurple")]), startPoint: .topTrailing, endPoint: .bottomLeading))                            .frame(width: 130, height: 130)
                            .offset(x: -30, y: 80)
                            .shadow(radius: 10)
                        Spacer(minLength: 0)
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("dreamPurple"), Color(.white)]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: 170, height: 170)
                            .offset(x: 90, y: 80)
                            .shadow(radius: 10)
                    }
                    
                    ,alignment: .bottom
                )
                
            }
        }
        }
        
    func loadhistory(tradeHistory: Array<trade>) {
        self.theData = tradeHistory
        self.theData = tradeHistory.sorted(by: {
            $0.dateString.compare($1.dateString) == .orderedDescending
        })
        
    }
    func idUsed(used: Bool) {
        self.uuidUsed = used
    }
    }
    
    
    
    

struct CustomRowView: View {
    @State var ticker: String
    @State var price: String
    @State var date: String
    @State var PChange: String
    @State var qty: String
    @State var type: String
    @State var color1: Color = Color(.lightGray)
    @State var color2: Color = Color(.darkGray)
    
    @State var cluster: Bool = false
    @State var insider: Bool = false
    @State var penny: Bool = false
    @State var theGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color(.lightGray), Color(.darkGray)]), startPoint: .leading, endPoint: .trailing)
    
    
    
    var body: some View {
        
        if type == "Cluster"{
            clusterCard(ticker: ticker, price: price, date: date, PChange: PChange, qty: qty, type: type)
        }
        else if type == "Insider" {
            insiderCard(ticker: ticker, price: price, date: date, PChange: PChange, qty: qty, type: type)
        }
        else {
            pennyCard(ticker: ticker, price: price, date: date, PChange: PChange, qty: qty, type: type)
        }
                
    }
}



struct recentBuysView_Previews: PreviewProvider {
    static var previews: some View {
        recentBuysView(cameFrom: "SignUp")
    }
}

struct clusterCard: View {
    @State var ticker: String
    @State var price: String
    @State var date: String
    @State var PChange: String
    @State var qty: String
    @State var type: String
    @State var color1: Color = Color(.lightGray)
    @State var color2: Color = Color(.darkGray)
    
    @State var cluster: Bool = false
    @State var insider: Bool = false
    @State var penny: Bool = false
    @State var theGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color(.lightGray), Color(.darkGray)]), startPoint: .leading, endPoint: .trailing)
    
    
    
    var body: some View {
        ZStack {
            
            
            VStack {
                HStack {
                    VStack {
                        Text(ticker)
                            .bold()
                            .shadow(radius: 5)
                            .foregroundColor(Color("dreamBlue"))
                        
                        HStack {
                            VStack {
                                Text("Price:")
                                    .foregroundColor(Color(.white))

                                Text(price)
                                    .font(.caption)
                                    .foregroundColor(Color("dreamBlue"))

                            }
                            VStack {
                                Text("Quantity:")
                                    .foregroundColor(Color(.white))

                                Text(qty)
                                    .font(.caption)
                                    .foregroundColor(Color("dreamBlue"))

                            }
                            VStack {
                                Text("Date:")
                                    .foregroundColor(Color(.white))

                                Text(date)
                                    .font(.caption)
                                    .foregroundColor(Color("dreamBlue"))

                            }
                        }
                    }
                }
                
            }
            HStack {
                Text(type.prefix(1))
                    .font(.largeTitle)
                    .padding(.leading, 30)
                    .bold()
                    .opacity(0.5)
                    .foregroundColor(Color("dreamBlue"))
                    .shadow(color: Color("dreamBlue"), radius: 10)

                    
                Spacer()
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(.lightGray), Color(.darkGray)]), startPoint: .center, endPoint: .leading))
                    .frame(height: 165)
//                    .frame(width: 170, height: 170)
                    .offset(x: 90, y: 45)
                    .opacity(0.3)
                    .shadow(radius: 45)
           
            }
        }
    
        .frame(maxWidth: .infinity, maxHeight: 70,alignment: .center)
        .foregroundColor(.white)
        .padding(.vertical, 10)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray), Color(.darkGray)]), startPoint: .leading, endPoint: .trailing)

            
        )
        .cornerRadius(20)
        .shadow(radius: 5)
        
        
        
        
        
    }
}

struct insiderCard: View {
    @State var ticker: String
    @State var price: String
    @State var date: String
    @State var PChange: String
    @State var qty: String
    @State var type: String
    @State var color1: Color = Color(.lightGray)
    @State var color2: Color = Color(.darkGray)
    
    @State var cluster: Bool = false
    @State var insider: Bool = false
    @State var penny: Bool = false
    @State var theGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color(.lightGray), Color(.darkGray)]), startPoint: .leading, endPoint: .trailing)
    
    
    
    var body: some View {
        ZStack {
            
            
            VStack {
                HStack {
                    VStack {
                        Text(ticker)
                            .bold()
                            .shadow(radius: 5)
                            .foregroundColor(Color("dreamPink"))

                        
                        HStack {
                            VStack {
                                Text("Price:")
                                Text(price)
                                    .font(.caption)
                                    .foregroundColor(Color("dreamPink"))
                            }
                            VStack {
                                Text("Quantity:")
                                Text(qty)
                                    .font(.caption)
                                    .foregroundColor(Color("dreamPink"))
                            }
                            VStack {
                                Text("Date:")
                                Text(date)
                                    .font(.caption)
                                    .foregroundColor(Color("dreamPink"))
                            }
                        }
                    }
                }
                
            }
            HStack {
                Text(type.prefix(1))
                    .font(.largeTitle)
                    .padding(.leading, 30)
                    .bold()
                    .opacity(0.5)
                    .foregroundColor(Color("dreamPink"))
                    .shadow(color: Color("dreamPink"), radius: 10)


                    
                Spacer()
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(.lightGray), Color(.darkGray)]), startPoint: .center, endPoint: .leading))
                    .frame(height: 165)
//                    .frame(width: 170, height: 170)
                    .offset(x: 90, y: 45)
                    .opacity(0.3)
                    .shadow(radius: 10)
                    
           
            }
        }
    
        .frame(maxWidth: .infinity, maxHeight: 70,alignment: .center)
        .foregroundColor(.white)
        .padding(.vertical, 10)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray), Color(.darkGray)]), startPoint: .leading, endPoint: .trailing)

            
        )
        .cornerRadius(20)
        .shadow(radius: 5)
        
        
        
        
        
    }
}

struct pennyCard: View {
    @State var ticker: String
    @State var price: String
    @State var date: String
    @State var PChange: String
    @State var qty: String
    @State var type: String
    @State var color1: Color = Color(.lightGray)
    @State var color2: Color = Color(.darkGray)
    
    @State var cluster: Bool = false
    @State var insider: Bool = false
    @State var penny: Bool = false
    @State var theGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color(.lightGray), Color(.darkGray)]), startPoint: .leading, endPoint: .trailing)
    
    
    
    var body: some View {
        ZStack {
            
            
            VStack {
                HStack {
                    VStack {
                        Text(ticker)
                            .bold()
                            .shadow(radius: 5)
                            .foregroundColor(Color("dreamPurple"))

                        
                        HStack {
                            VStack {
                                Text("Price:")
                                Text(price)
                                    .font(.caption)
                                    .foregroundColor(Color("dreamPurple"))
                            }
                            VStack {
                                Text("Quantity:")
                                Text(qty)
                                    .font(.caption)
                                    .foregroundColor(Color("dreamPurple"))
                            }
                            VStack {
                                Text("Date:")
                                Text(date)
                                    .font(.caption)
                                    .foregroundColor(Color("dreamPurple"))
                            }
                        }
                    }
                }
                
            }
            HStack {
                Text(type.prefix(1))
                    .font(.largeTitle)
                    .padding(.leading, 30)
                    .bold()
                    .opacity(0.5)
                    .foregroundColor(Color("dreamPurple"))
                    .shadow(color: Color("dreamPurple"), radius: 10)
                    
                Spacer()
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(.lightGray), Color(.darkGray)]), startPoint: .center, endPoint: .leading))
                    .frame(height: 165)
//                    .frame(width: 170, height: 170)
                    .offset(x: 90, y: 45)
                    .opacity(0.3)
                    .shadow(radius: 10)
                    
           
            }
        }
    
        .frame(maxWidth: .infinity, maxHeight: 70,alignment: .center)
        .foregroundColor(.white)
        .padding(.vertical, 10)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray), Color(.darkGray)]), startPoint: .leading, endPoint: .trailing)

            
        )
        .cornerRadius(20)
        .shadow(radius: 5)
        
        
        
        
        
    }
}

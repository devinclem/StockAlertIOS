//
//  Firebaselogic.swift
//  StockAlert
//
//  Created by Devin C on 11/6/22.
//

import Foundation
import FirebaseDatabase
import Firebase
import Security

var myphone = ["+18623565906"]
let devindatabse = Database.database().reference()
var called = false
var alreadyEntered = false
var alreadyConfigured = false
//Accepts the phone number entered when sign up button is clicked
func acceptEntry(phoneNumber: String, cluster: Bool, Insider: Bool, Penny: Bool) -> Bool{
    
    //Parses the phone number into the correct form
    let correctPhone = getIntoCorrectForm(phoneNumber: phoneNumber)
    
    //If user wants cluster notifications
    if cluster {
        addClusterEntry(sendTo: correctPhone, sendFrom: myphone.randomElement()!, UserID: getUUID())
    }
    
    //If user wants Insider notifications
    if Insider {
        addInsiderEntry(sendTo: correctPhone, sendFrom: myphone.randomElement()!, UserID: getUUID())
    }
    
    //If user wants Penny stock notifications
    if Penny {
        addPennyEntry(sendTo: correctPhone, sendFrom: myphone.randomElement()!, UserID: getUUID())
    }
    return true
    
}



//Parses the phone number entry into the correct form to be sent to twilio
func getIntoCorrectForm(phoneNumber: String) -> String{
    var finalString = "+1"
    
    for char in phoneNumber {
        if char.isNumber {
            finalString += String(char)
        }
        
    }
    return finalString
    
}

//Adds the userID and phone number to the firebase database for ClusterUsers
func addClusterEntry(sendTo: String, sendFrom: String, UserID: String){
    devindatabse.child("ClusterUsers").child(sendFrom).child(UserID).setValue(sendTo)
    devindatabse.child("TotalUsers").child(UserID).setValue(sendTo)

}

//Adds the userID and phone number to the firebase database for InsiderUSers
func addInsiderEntry(sendTo: String, sendFrom: String, UserID: String){
    devindatabse.child("InsiderUsers").child(sendFrom).child(UserID).setValue(sendTo)
    devindatabse.child("TotalUsers").child(UserID).setValue(sendTo)
}

//Adds the userID and phone number to the firebase database for PennyStockUsers
func addPennyEntry(sendTo: String, sendFrom: String, UserID: String){
    print("Adding Penny Stock Entry")
    devindatabse.child("PennyStockUsers").child(sendFrom).child(UserID).setValue(sendTo)
    devindatabse.child("TotalUsers").child(UserID).setValue(sendTo)
}
var testing: ((Bool) -> Void)?

//Checks if the userID given is already an entry in the databse (user has already signed up)
func isIdUsed(ID: String, completion: @escaping (Bool) -> Void){
    
    var userDictionary: NSDictionary = NSDictionary()
    var inDatabase = false
    
    let group = DispatchGroup()
    let ID = getUUID()
    group.enter()
    devindatabse.child("TotalUsers").observeSingleEvent(of: .value, with: { snapshot in
        let value = snapshot.value as? NSDictionary

        userDictionary = value! as NSDictionary
        if totalUsersCheck(totalUsers: userDictionary, ID: ID) {
            
            inDatabase = true

        }
        //completion(inDatabase)
        group.leave()
          // ...
    }) { error in
        print(error.localizedDescription)
        
    }
    group.notify(queue: .main) {
        
        completion(inDatabase)
        testing = completion
    }
    
}

//Checks if a value is in a given dictionary
func totalUsersCheck(totalUsers: NSDictionary, ID: String) -> Bool{
    if totalUsers[ID] != nil {
        return true
    }
    return false
}

//Changes the user notifications settings
func changeUserSettings(cluster: Bool, Insider: Bool, Penny: Bool, phoneNumber: String) {

    if cluster {
        addClusterEntry(sendTo: phoneNumber, sendFrom: myphone.randomElement()!, UserID: getUUID())
    }
    if Insider {
        addInsiderEntry(sendTo: phoneNumber, sendFrom: myphone.randomElement()!, UserID: getUUID())
    }
    if Penny {
        addPennyEntry(sendTo: phoneNumber, sendFrom: myphone.randomElement()!, UserID: getUUID())
    }
    
    

}

//Un subscribes from stockalert. Removes fromd every database entry
func unsubscribe(userID: String) {
    removeFromPenny(userID: userID)
    removeFromCluster(userID: userID)
    removeFromInsider(userID: userID)
    removeFromTotal(userID: userID)
    deleteFromKeyChain(userID: userID)
}

//Removes user from the clusterusers in firebase if user is listed in the ClusterUsers
func removeFromCluster(userID: String) {
    var clusterUsers: NSDictionary = NSDictionary()
    devindatabse.child("ClusterUsers").observeSingleEvent(of: .value, with: { snapshot in
      let value = snapshot.value as? NSDictionary

        clusterUsers = value! as NSDictionary
        for entry in clusterUsers {
            var phoneNumber = entry.key as! String
            //print("Phone Number: " + phoneNumber)
            var pairing = entry.value as! NSDictionary
            //print("Dictionary")
            for user in pairing {
                var currentUUID = user.key as! String
                if userID == currentUUID {
                    let userToRemove = devindatabse.child("ClusterUsers").child(phoneNumber).child(currentUUID)
                    userToRemove.removeValue()
                }
            }
            
        }
        
    }) { error in
      print(error.localizedDescription)
    }
    

}

//Removes user from the insiderUsers database
func removeFromInsider(userID: String) {
    var insiderUsers: NSDictionary = NSDictionary()

    devindatabse.child("InsiderUsers").observeSingleEvent(of: .value, with: { snapshot in
      let value = snapshot.value as? NSDictionary

        insiderUsers = value! as NSDictionary
        for entry in insiderUsers {
            var phoneNumber = entry.key as! String
            //print("Phone Number: " + phoneNumber)
            var pairing = entry.value as! NSDictionary
            //print("Dictionary")
            for user in pairing {
                var currentUUID = user.key as! String
                if userID == currentUUID {
                    let userToRemove = devindatabse.child("InsiderUsers").child(phoneNumber).child(currentUUID)
                    userToRemove.removeValue()
                }
            }
            
        }
        
    }) { error in
      print(error.localizedDescription)
    }
}

//Removes user from the pennyStockUSers database
func removeFromPenny(userID: String) {
    var pennyUsers: NSDictionary = NSDictionary()

    devindatabse.child("PennyStockUsers").observeSingleEvent(of: .value, with: { snapshot in
      let value = snapshot.value as? NSDictionary

        pennyUsers = value! as NSDictionary
        for entry in pennyUsers {
            var phoneNumber = entry.key as! String
            //print("Phone Number: " + phoneNumber)
            var pairing = entry.value as! NSDictionary
            //print("Dictionary")
            for user in pairing {
                var currentUUID = user.key as! String
                if userID == currentUUID {
                    let userToRemove = devindatabse.child("PennyStockUsers").child(phoneNumber).child(currentUUID)
                    userToRemove.removeValue()
                }
            }
            
        }
        
    }) { error in
      print(error.localizedDescription)
    }

}

//Removes user from the totalUsers database
func removeFromTotal(userID: String) {
    var totalUsers: NSDictionary = NSDictionary()

    devindatabse.child("TotalUsers").observeSingleEvent(of: .value, with: { snapshot in
      let value = snapshot.value as? NSDictionary

        totalUsers = value! as NSDictionary
        for pairing in totalUsers {
            var currentID = pairing.key as! String
            if userID == currentID {
                let userToRemove = devindatabse.child("TotalUsers").child(currentID)
                userToRemove.removeValue()
            }

            
        }
        
    }) { error in
      print(error.localizedDescription)
    }
}

//I dont even remember for sure what this does but i think it returns the users phone?
func getUserInfo(userID: String) -> Array<String>{
    var userInfo: Array<String> = []
    
    return userInfo
}

//Gets the UUID of the user (from keychain)
func getUUID() -> String {
    let username = "StockAlertUUID"

    // Set query
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: username,
        kSecMatchLimit as String: kSecMatchLimitOne,
        kSecReturnAttributes as String: true,
        kSecReturnData as String: true,
    ]
    var item: CFTypeRef?

    // Check if user exists in the keychain
    if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
        // Extract result
        if let existingItem = item as? [String: Any],
           let username = existingItem[kSecAttrAccount as String] as? String,
           let passwordData = existingItem[kSecValueData as String] as? Data,
           let password = String(data: passwordData, encoding: .utf8)
        {
//            print(username)
            //print(password)
            return password
        }
    } else {
        print("Something went wrong trying to find the user in the keychain")
    }
    return "Invalid"
    
}

//Sets the user current UUID to save in the keychain
func setUserID() -> Bool{
    let currentUUID = (UIDevice.current.identifierForVendor!.uuidString)

    let username = "StockAlertUUID"
    let password = currentUUID.data(using: .utf8)!

    // Set attributes
    let attributes: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: username,
        kSecValueData as String: password,
    ]
    
    // Add user
    if SecItemAdd(attributes as CFDictionary, nil) == noErr {
        print("User saved successfully in the keychain")
    } else {
        print("Something went wrong trying to save the user in the keychain")
    }
    print("users UUID: " + getUUID())

    return true
}


func checkString(entry: String) -> Bool {
    return true
}

func isalreadyConfigured() -> Bool {
    return alreadyConfigured
}

func configureDatabase() {
    if alreadyConfigured {
        //DO NOTHING
    }
    else {
        FirebaseApp.configure()
        alreadyConfigured = true
    }
    
}


func readTotalUsers() {
    devindatabse.child("TotalUsers").observeSingleEvent(of: .value, with: { snapshot in
        guard let value = snapshot.value as? NSDictionary else {
            return
        }
        print(value)
    })
    print("LAST")
}
var completionPhone: ((String) -> Void)?

//Checks if the userID given is already an entry in the databse (user has already signed up)
func getUserPhone(ID: String, completion: @escaping (String) -> Void){

    var userDictionary: NSDictionary = NSDictionary()
    var userPhone = ""

    let group = DispatchGroup()
    let ID = getUUID()
    group.enter()
    devindatabse.child("TotalUsers").observeSingleEvent(of: .value, with: { snapshot in
        let value = snapshot.value as? NSDictionary

        userDictionary = value! as NSDictionary
        if totalUsersCheck(totalUsers: userDictionary, ID: ID) {
            userPhone.append(userDictionary[ID] as! String)
            

        }
        group.leave()
          // ...
    }) { error in
        print(error.localizedDescription)

    }
    group.notify(queue: .main) {
        completion(userPhone)
        completionPhone = completion
    }

}


//Deletes the username:pass from the users keychain
func deleteFromKeyChain(userID: String) {
    let username = "StockAlertUUID"
    let password = getUUID()

    // Set attributes
    let attributes: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: username,
        kSecValueData as String: password,
    ]
    let query: [CFString: Any] = [kSecMatchItemList as CFString: username]
    print(SecItemDelete(attributes as CFDictionary))

}


//Returns the list of prev cluster Users
func loadTradeHistory(options: Array<Bool>, completion: @escaping (Array<trade>) -> Void){
    let cluster: Bool = options[0]
    let insider: Bool = options[1]
    let penny: Bool = options[2]
    
    var completionHistory: ((Array<trade>) -> Void)?
    var history: Array<trade> = []
    
    let group = DispatchGroup()
    group.enter()
    
    
    devindatabse.child("RecentTrades").observeSingleEvent(of: .value, with: { snapshot in

        let allCategories = snapshot.value as! NSDictionary
        let clusterDictionary = allCategories["ClusterHistory"] as! NSDictionary
        let insiderDictionary = allCategories["InsiderHistory"] as! NSDictionary
        let pennyDictionary = allCategories["PennyHistory"] as! NSDictionary

        if cluster {
            
            for(key,value) in clusterDictionary {
                let value = value as! NSDictionary
                let theticker = key as! String
                let price = value["Price"] as! String
                let qty = value["Qty"] as! String
                let PChange = value["PChange"] as! String
                let date = value["Date"] as! String
                print(date)
                let newTrade = trade(type: "Cluster", ticker: theticker, price: price, qty: qty, dateString: date, percentChange: PChange)
                history.append(newTrade)
                print(newTrade.toString())

            }
            
        }
        
        if penny {
            for(key,value) in pennyDictionary {
                let value = value as! NSDictionary
                let theticker = key as! String
                let price = value["Price"] as! String
                let qty = value["Qty"] as! String
                let PChange = value["PChange"] as! String
                let date = value["Date"] as! String
                let newTrade = trade(type: "Penny", ticker: theticker, price: price, qty: qty, dateString: date, percentChange: PChange)
                history.append(newTrade)

            }
        }
        if insider {
            for(key,value) in insiderDictionary {
                let value = value as! NSDictionary
                let theticker = key as! String
                let price = value["Price"] as! String
                let qty = value["Qty"] as! String
                let PChange = value["PChange"] as! String
                let date = value["Date"] as! String
                let newTrade = trade(type: "Insider", ticker: theticker, price: price, qty: qty, dateString: date, percentChange: PChange)
                history.append(newTrade)

            }
        }
        group.leave()
        
    })
    group.notify(queue: .main) {
        completion(history)
        completionHistory = completion
        
    }
    
}


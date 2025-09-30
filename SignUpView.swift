//
//  SignUpView.swift
//  ShuntSense0
//
//  Created by Bhavna Malladi on 2/18/25.
//

import SwiftUI

struct SignUpView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("isGuestUser") private var isGuestUser: Bool = false
    
    @State private var navigateToHome = false
    
    @State private var fullName: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var emailOrPhone: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Create an Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#243E36"))
                
                TextField("Full Name (Optional)", text: $fullName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    .padding(.horizontal)
                
                TextField("Email or Phone", text: $emailOrPhone)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: createAccount) {
                    Text("Create Account")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#7CA982"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
//                Button(action: skipSignUp) {
//                    Text("Skip and Continue as Guest")
//                        .fontWeight(.semibold)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.gray)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal)
                
                
                
                NavigationLink(destination: HomeView(), isActive: $navigateToHome) { EmptyView() }
            }
            .padding()
        }
    }
    
    private func createAccount() {
        guard password == confirmPassword, !password.isEmpty, !emailOrPhone.isEmpty else {
            print("Error: Passwords don't match or fields are empty")
            return
        }
        
        // Save credentials locally (Consider using Keychain for sensitive data)
        UserDefaults.standard.set(fullName, forKey: "savedFullName")
        UserDefaults.standard.set(emailOrPhone, forKey: "savedEmailOrPhone")
        UserDefaults.standard.set(password, forKey: "savedPassword")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        isLoggedIn = true
        navigateToHome = true
    }
    
    private func skipSignUp() {
        UserDefaults.standard.set(true, forKey: "isGuestUser")
        isGuestUser = true
        navigateToHome = true
    }
}




struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

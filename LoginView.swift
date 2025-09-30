//
//  LoginView.swift
//  ShuntSense0
//
//  Created by Bhavna Malladi on 3/20/25.
//



import SwiftUI

struct LoginView: View {
    @State private var emailOrPhone: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var navigateToHome = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // App Logo & Title
                Text("ShuntSense")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#243E36"))
                
                Text("Log In to Your Account")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                // Email/Phone Field
                TextField("Email or Phone", text: $emailOrPhone)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Password Field
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Login Button
                Button(action: logIn) {
                    Text("Log In")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#7CA982"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Error Message
                if showError {
                    Text("Invalid credentials. Please try again.")
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                // Forgot Password (Local Reset)
//                Button(action: resetPassword) {
//                    Text("Forgot Password?")
//                        .foregroundColor(.blue)
//                }
                
                // Guest Access
//                Button(action: continueAsGuest) {
//                    Text("Continue as Guest")
//                        .fontWeight(.semibold)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color(hex: "#A0C4A8"))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal)
                
                // Navigate to Home
                NavigationLink(destination: HomeView(), isActive: $navigateToHome) { EmptyView() }
            }
            .padding()
        }
        .onAppear {
            autoLogin()
        }
    }
    
    // MARK: - Functions
    
    private func logIn() {
        let storedEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let storedPassword = UserDefaults.standard.string(forKey: "userPassword") ?? ""
        
        if emailOrPhone == storedEmail && password == storedPassword {
            navigateToHome = true
        } else {
            showError = true
        }
    }
    
    private func autoLogin() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            navigateToHome = true
        }
    }
    
//    private func resetPassword() {
//        // Reset stored password (since there's no backend)
//        UserDefaults.standard.set("", forKey: "userPassword")
//        showError = false
//    }
    
    private func continueAsGuest() {
        UserDefaults.standard.set(true, forKey: "isGuestUser")
        navigateToHome = true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

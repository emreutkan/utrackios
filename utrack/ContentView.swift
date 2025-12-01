//
//  ContentView.swift
//  utrack
//
//  Created by emre on 29.11.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegister = false
    @State private var isLoading = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .scaleEffect(2)
                    .padding()
            } else {
                ZStack {
                    // Background gradient
                    LinearGradient(
                        colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            // Logo/Title section
                            VStack(spacing: 16) {
                                Text("UTrack")
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundColor(.primary)
                                
                                Text("Welcome back")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 60)
                            .padding(.bottom, 50)
                            
                            // Form section
                            VStack(spacing: 20) {
                                // Email field
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Email")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.secondary)
                                    
                                    TextField("Enter your email", text: $email)
                                        .textFieldStyle(.plain)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(.systemGray4), lineWidth: 1)
                                        )
                                        .autocapitalization(.none)
                                        .keyboardType(.emailAddress)
                                }
                                
                                // Password field
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Password")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.secondary)
                                    
                                    SecureField("Enter your password", text: $password)
                                        .textFieldStyle(.plain)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(.systemGray4), lineWidth: 1)
                                        )
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 30)
                            
                            // Login button
                            Button(action: {
                                isLoading = true
                                Task {
                                    do {
                                        let (access, refresh) = try await APIService.shared.login(email: email, password: password)
                                        await MainActor.run {
                                            AuthManager.shared.saveTokens(accessToken: access, refreshToken: refresh)
                                            isLoading = false
                                        }
                                    } catch {
                                        await MainActor.run {
                                            errorMessage = "Login failed: \(error.localizedDescription)"
                                            isLoading = false
                                        }
                                    }
                                }
                            }) {
                                Text("Log In")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(
                                        LinearGradient(
                                            colors: [Color.blue, Color.blue.opacity(0.8)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(16)
                                    .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 20)
                            
                            // Register link
                            HStack(spacing: 4) {
                                Text("Don't have an account?")
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                                
                                Button(action: {
                                    showRegister = true
                                }) {
                                    Text("Sign Up")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.bottom, 40)
                        }
                    }
                }
                .sheet(isPresented: $showRegister) {
                    RegisterView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

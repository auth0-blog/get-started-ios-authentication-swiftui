//
//  ContentView.swift
//  SwiftUI Login Demo
//
// Companion project for the Auth0 blog article
// “Get Started with iOS Authentication Using SwiftUI”.
//
// See the end of the file for licensing information.
//


import SwiftUI
import Auth0


struct ContentView: View {
  
  @State private var isAuthenticated = false
  @State var userProfile = Profile.empty


  var body: some View {

    if isAuthenticated {
              
      VStack {
        
        Text("Logged in")
          .padding()
        
        AsyncImage(url: URL(string: userProfile.picture)) { image in
          image
            .frame(maxWidth: 128)
        } placeholder: {
          Image(systemName: "photo.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 128)
            .foregroundColor(.gray)
            .opacity(0.5)
        }
        .padding(40)
        
        VStack {
          Text("Name: \(userProfile.name)")
          Text("Email: \(userProfile.email)")
        }
        .padding()
        
        Button("Log out") {
          logout()
        }
        .padding()
        
      } // VStack
      
    } else {
    
      VStack {
        
        Text("SwiftUI Login Demo")
          .padding()
        
        Button("Log in") {
          login()
        }
        .padding()
        
      } // VStack
      
    } // if isAuthenticated
    
  } // body
  
}


extension ContentView {
  
  func login() {
    Auth0
      .webAuth()
      .start { result in
        switch result {
          case .failure(let error):
            print("Failed with: \(error)")
          
          case .success(let credentials):
            self.isAuthenticated = true
            self.userProfile = Profile.from(credentials.idToken)
            print("Credentials: \(credentials)")
            print("ID token: \(credentials.idToken)")
        }
      }
  }
  
  func logout() {
    Auth0
      .webAuth()
      .clearSession { result in
        switch result {
          case .success:
            self.isAuthenticated = false
    
          case .failure(let error):
            print("Failed with: \(error)")
        }
      }
  }
  
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}


//
// License information
// ===================
//
// Copyright (c) 2021 Auth0 (http://auth0.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

//
//  onboarding.swift
//  Learning Journey
//
//  Created by Nahed Almutairi on 26/04/1446 AH.
//


import SwiftUI

struct onboarding: View {
    @State private var textFieldInput = "" // User's input text
    @State private var navigateToCurrentDay = false // Control navigation to CurrentDay
    @State private var selectedDuration = "Month" // Default selection is "Month"
    
    var body: some View {
        NavigationStack {
            VStack {
                // Fire Emoji inside Circle
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 120)
                    
                    Text("🔥")
                        .font(.system(size: 50))
                }
                .padding(.top, 60)
                .frame(maxWidth: .infinity, alignment: .center)
                
                // Greeting Text
                Text("Hello Learner!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Subheading Text
                Text("This app will help you learn everyday")
                    .font(.system(size: 19))
                    .foregroundColor(Color.gray.opacity(0.5))
                    .padding(.bottom, 30)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // TextField with underline and placeholder
                VStack(alignment: .leading) {
                    Text("I want to learn")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                    
                    ZStack(alignment: .leading) {
                        if textFieldInput.isEmpty {
                            Text("Swift")
                                .foregroundColor(.gray)
                                .padding(.leading,10)
                        }
                        TextField("", text: $textFieldInput)
                            .foregroundColor(.white)
                            .padding(.leading,10)
                    }
                    .padding(.vertical, 5)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3)),
                        alignment: .bottom
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 1)
                
                // Time Selection (Week, Month, Year)
                VStack(alignment: .leading) {
                    Text("I want to learn it in a")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .padding(.leading,-130)
                    
                    HStack {
                        ForEach(["Week", "Month", "Year"], id: \.self) { option in
                            Button(action: {
                                selectedDuration = option // Update selected duration
                            }) {
                                Text(option)
                                    .frame(width: 70, height: 40)
                                    .background(selectedDuration == option ? Color.orange : Color.gray.opacity(0.3))
                                    .foregroundColor(selectedDuration == option ? .black : .orange)
                                    .cornerRadius(8)
                                
                            }
                        }
                    }
                    .padding(.leading,-130)
                }
                .padding(.horizontal, 10)
                .padding(.top, 20)
                
                // Navigation to CurrentDay with Start Button
                Button(action: {
                    if !textFieldInput.isEmpty {
                        navigateToCurrentDay = true
                    }
                }) {
                    HStack {
                        Text("Start")
                        Image(systemName: "arrow.right")
                    }
                    .font(.headline)
                    .frame(width: 160, height: 60)
                    .background(Color.orange)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    .padding(.top, 40)
                }
                
                Spacer()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationDestination(isPresented: $navigateToCurrentDay) {
                CurrentDay(learningGoal: textFieldInput, duration: selectedDuration)
                    .navigationBarBackButtonHidden(true) // إخفاء زر "Back"
                    .navigationBarHidden(true)
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        onboarding()
    }
}

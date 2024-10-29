//
//  Update.swift
//  Learning Journey
//
//  Created by Nahed Almutairi on 26/04/1446 AH.
//


import SwiftUI

struct Update: View {
    var learningGoal: String
    var duration: String
    var onSave: (String, String) -> Void // استدعاء التحديث عند الحفظ
    
    @State private var textFieldInput = ""
    @State private var selectedOption = "Month"
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading) {
            // شريط التنقل مع أزرار "Back" و "Update"
            HStack {
                Button(action: {
                    dismiss() // إغلاق الشاشة الحالية
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.orange)
                }
                
                Spacer()
                
                Text("Learning goal")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    // استدعاء onSave لتحديث القيم
                    onSave(textFieldInput.isEmpty ? learningGoal : textFieldInput, selectedOption)
                    dismiss() // إغلاق الشاشة الحالية
                }) {
                    Text("Update")
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            .navigationBarBackButtonHidden(true) 
            
            // قسم الإدخال
            VStack(alignment: .leading) {
                Text("I want to learn")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .padding(.top, 30)
                
                ZStack(alignment: .leading) {
                    if textFieldInput.isEmpty {
                        Text(learningGoal) // عرض الهدف الحالي كقيمة افتراضية
                            .foregroundColor(.gray)
                            .padding(.leading, 4)
                    }
                    
                    TextField("", text: $textFieldInput)
                        .foregroundColor(.white)
                        .padding(.leading, 4)
                }
                .padding(.vertical, 5)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.3)),
                    alignment: .bottom
                )
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // خيارات الوقت
            VStack(alignment: .leading) {
                Text("I want to learn it in a")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 1)
                
                HStack {
                    // أزرار الاختيار: أسبوع، شهر، سنة
                    ForEach(["Week", "Month", "Year"], id: \.self) { option in
                        Button(action: {
                            selectedOption = option
                        }) {
                            Text(option)
                                .frame(width: 70, height: 40)
                                .background(selectedOption == option ? Color.orange : Color.gray.opacity(0.3))
                                .foregroundColor(selectedOption == option ? .black : .orange)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            // تعيين القيم الحالية عند ظهور الصفحة
            textFieldInput = learningGoal
            selectedOption = duration
        }
    }
}

struct Update_Previews: PreviewProvider {
    static var previews: some View {
        Update(learningGoal: "Swift", duration: "Month") { _, _ in }
    }
}


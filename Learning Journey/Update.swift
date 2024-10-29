import SwiftUI

struct Update: View {
    var learningGoal: String
    var duration: String
    var onSave: (String, String) -> Void // Callback to save updates
    
    @State private var textFieldInput = ""
    @State private var selectedOption = "Month"
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading) {
            // Navigation bar with "Back" and "Update" buttons
            HStack {
                Button(action: {
                    dismiss()
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
                    // Trigger onSave to update values
                    onSave(textFieldInput.isEmpty ? learningGoal : textFieldInput, selectedOption)
                    dismiss()
                }) {
                    Text("Update")
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            .navigationBarBackButtonHidden(true)
            
            // Input field section
            VStack(alignment: .leading) {
                Text("I want to learn")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .padding(.top, 30)
                
                ZStack(alignment: .leading) {
                    if textFieldInput.isEmpty {
                        Text(learningGoal) // Display current goal as placeholder
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
            
            // Duration selection buttons
            VStack(alignment: .leading) {
                Text("I want to learn it in a")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 1)
                
                HStack {
                    ForEach(["Week", "Month", "Year"], id: \.self) { option in
                        durationButton(for: option)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            textFieldInput = learningGoal
            selectedOption = duration
        }
    }
    
    // MARK: - Helper Function
    
    private func durationButton(for option: String) -> some View {
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

struct Update_Previews: PreviewProvider {
    static var previews: some View {
        Update(learningGoal: "Swift", duration: "Month") { _, _ in }
    }
}

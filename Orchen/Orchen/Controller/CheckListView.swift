import SwiftUI

struct CheckListView: View {
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0)) // Golden color

                Text("Premium Feature")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)

                Text("Unlock this feature by upgrading to premium. \nPay Rahul by contacting his lawyer Emil (700% filing charges applied)")
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 30)

                Button(action: {
                    // Action for upgrading
                }) {
                    Text("Upgrade Now")
                        .font(.headline)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 237/255, green: 180/255, blue: 80/255)) // Golden color
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 50)

                Button(action: {
                    // Action for learning more
                }) {
                    Text("Learn More")
                        .font(.subheadline)
                        .underline()
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CheckListView()
}

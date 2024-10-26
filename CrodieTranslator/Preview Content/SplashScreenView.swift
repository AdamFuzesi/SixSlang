//
//  SplashScreenView.swift
//  CrodieTranslator
//
//  Created by Adam Fuzesi on 2024-10-25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var typedText = ""
    private let fullText = "Wagwan Cro"
    private let typingSpeed = 0.1
    // Adjust typing speed here

    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                // Background Gradient filling the entire screen
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.1), Color.black.opacity(3)]),
                               startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                // Foreground Content
                VStack {
                    Spacer()
                    Text(typedText)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                // expand VStack to fill the screen
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear {
                self.startTyping()
            }
        }
    }

    func startTyping() {
        typedText = ""
        var charIndex = 0
        let typingTimer = Timer.scheduledTimer(withTimeInterval: typingSpeed, repeats: true) { timer in
            if charIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: charIndex)
                typedText += String(fullText[index])
                charIndex += 1
            } else {
                timer.invalidate()
                // Delay before transitioning to ContentView
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
        // Ensure the timer runs on the main run loop
        RunLoop.current.add(typingTimer, forMode: .common)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}



//
//  ContentView.swift
//  CrodieTranslator
//
//  Created by Adam Fuzesi on 2024-10-25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var translatedText: String = ""
    let translator = Translator()

    var body: some View {
        ZStack {
            // backgrounds Gradient
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(2.5), Color.white.opacity(0.01)]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Six Slang")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.top, 100)

                Spacer()

                VStack(alignment: .leading, spacing: 15) {
                    Text("Enter a sentence you would like to translate:")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    TextField("Enter sentence", text: $inputText)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Button(action: {
                        self.translatedText = translator.translateSentence(self.inputText)
                    }) {
                        Text("Translate")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    if !translatedText.isEmpty {
                        Text("Translated sentence:")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        Text(translatedText)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            }
        }
    }
}

// portion here jsut leve for now... will change later into a combined file
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

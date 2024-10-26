//
//  Translator.swift
//  CrodieTranslator
//
//  Created by Adam Fuzesi on 2024-10-25.
//

import Foundation
import NaturalLanguage

class Translator {
    private var slangTranslator: [String: [String: String]] = [:]
    private var maxPhraseLength: Int = 1

    init() {
        loadSlangTranslator()
        maxPhraseLength = computeMaxPhraseLength()
    }

    private func loadSlangTranslator() {
        if let url = Bundle.main.url(forResource: "slang_translator", withExtension: "json") {
            // loading in the json file with the translations
            do {
                let data = try Data(contentsOf: url)
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: String]] {
                    slangTranslator = jsonObject
                }
            } catch {
                print("Error loading slang translator JSON: \(error)")
            }
        } else {
            print("Slang translator JSON file not found.")
        }
    }

    private func computeMaxPhraseLength() -> Int {
        var maxLength = 1
        for key in slangTranslator.keys {
            let wordCount = key.split(separator: " ").count
            if wordCount > maxLength {
                maxLength = wordCount
            }
        }
        return maxLength
    }

    func translateWordToToronto(_ word: String) -> String {
        let lowercasedWord = word.lowercased()
        if let translations = slangTranslator[lowercasedWord], let torontoWord = translations["toronto"] {
            return torontoWord
        } else {
            return word
        }
    }

    func translateSentence(_ sentence: String) -> String {
        let words = tokenize(sentence)
        var torontoWords: [String] = []
        var i = 0
        while i < words.count {
            var foundMatch = false
            var n = min(maxPhraseLength, words.count - i)
            while n > 0 && !foundMatch {
                let phraseWords = words[i..<(i + n)]
                let phrase = phraseWords.joined(separator: " ")
                if let translations = slangTranslator[phrase.lowercased()], let torontoPhrase = translations["toronto"] {
                    torontoWords.append(torontoPhrase)
                    i += n
                    foundMatch = true
                } else {
                    n -= 1

                }
                // idea for the algorithm could be to hold the current value insdie of an array or list and then parse that through a graph tree to identify the next value.
                
                // back track this algorithm to see where there are redundancies in the translation for some cases with: ' or a letter off from another word... the main issue really is when the word has specific intricate identities... this solution might be the most optimal t
            }
            if !foundMatch {
                let word = words[i]
                torontoWords.append(translateWordToToronto(word))
                i += 1
            }
        }
        return torontoWords.joined(separator: " ")
    }

    private func tokenize(_ sentence: String) -> [String] {
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.string = sentence
        var tokens: [String] = []
        tokenizer.enumerateTokens(in: sentence.startIndex..<sentence.endIndex) { tokenRange, _ in
            let token = String(sentence[tokenRange])
            tokens.append(token)
            return true
        }
        return tokens
    }
}

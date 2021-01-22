//
//  QuizManager.swift
//  MovieQuiz
//
//  Created by Joao Queiroz on 22/01/21.
//  Copyright © 2021 Joao Queiroz. All rights reserved.
//

import Foundation


class QuizManager{
    
    var quizes: [Quiz]
    var quizOptions: [QuizOption]
    var score: Int
    var round: Round?
    
    typealias Round = (quiz: Quiz, options: [QuizOption])
    
    init(){
        score = 0
        let quizesURL = Bundle.main.url(forResource: "quizes", withExtension: "json")!
        let quizesOptionsURL = Bundle.main.url(forResource: "options", withExtension: "json")!
        do {
            let quizesData = try Data(contentsOf: quizesURL)
            quizes = try JSONDecoder().decode([Quiz].self, from: quizesData)
            
            let quizOptionsData = try! Data(contentsOf: quizesOptionsURL)
            quizOptions = try! JSONDecoder().decode([QuizOption].self, from: quizOptionsData)
            
        } catch {
            print(error.localizedDescription)
            quizes = []
            quizOptions = []
        }
    }
    
    func generateRandomQuiz() -> Round{
        let quizIndex = Int(arc4random_uniform(UInt32(quizes.count)))
        let quiz = quizes[quizIndex]
        var indexes: Set<Int> = [quizIndex]
        
        while indexes.count < 4 {
            let index = Int(arc4random_uniform(UInt32(quizes.count)))
            indexes.insert(index)
        }
        let options = indexes.map({quizOptions[$0]})
        round = (quiz, options)
        return round!
    }
    
    func checkAnswer(_ answer: String){
        guard let round = round else {return}
        if answer == round.quiz.name{
            score += 1
        }
    }
    
}


struct Quiz: Codable {
    let name: String
    let number: Int
}

struct QuizOption: Codable {
    let name: String
}

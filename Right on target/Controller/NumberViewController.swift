//
//  ViewController.swift
//  Right on target
//
//  Created by justSmK on 14.02.2022.
//

import UIKit

class NumberViewController: UIViewController {
    
    var game: Game<SecretNumericValue>!
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var secretValueLabel: UILabel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getNumericGame() as! Game<SecretNumericValue>)
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }
    
    // MARK: - Interaction View - Model
    
    
    @IBAction func checkNumber() {
        var userSecretValue = game.secretValue
        userSecretValue.value = Int(slider.value)
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }
    
    // MARK: - Update View
    
    func updateLabelWithSecretNumber(newText: String ) {
        secretValueLabel.text = newText
    }
    
    private func showAlertWith( score: Int ) {
        let alert = UIAlertController(
            title: "Game over",
            message: "You have earned \(score) points",
            preferredStyle: .alert)
        let alertAction = UIAlertAction(
            title: "Start over",
            style: .default,
            handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}

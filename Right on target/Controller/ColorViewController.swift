//
//  ColorViewController.swift
//  Right on target
//
//  Created by justSmK on 16.02.2022.
//

import UIKit

class ColorViewController: UIViewController {
    
    var game: Game<SecretColorValue>!
    
    var correctButtonTag: Int = 0
    
    @IBOutlet var hexLabel: UILabel!
    
    @IBOutlet var buttonColor1: UIButton!
    @IBOutlet var buttonColor2: UIButton!
    @IBOutlet var buttonColor3: UIButton!
    @IBOutlet var buttonColor4: UIButton!
    
    var buttonsCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getColorGame() as! Game<SecretColorValue>)
        buttonsCollection = [buttonColor1, buttonColor2, buttonColor3, buttonColor4]
        updateScene()
    }
    
    private func updateScene() {
        let secretColorString = game.secretValue.value.getByHEXString()
        updateSecretColorLabel(withText: secretColorString)
        updateButtons(withRightSecretValue: game.secretValue)
    }
    
    // MARK: - Interaction View - Model
    
    @IBAction func compareValue(sender: UIButton) {
        var userValue = game.secretValue
        userValue.value = Color(from: sender.backgroundColor!)
        game.calculateScore(secretValue: game.secretValue, userValue: userValue)
        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        updateScene()
    }
    
    // MARK: - Update View
    
    private func updateSecretColorLabel(withText newHEXColorText: String ) {
        hexLabel.text = "#\(newHEXColorText)"
    }
    
    private func updateButtons(withRightSecretValue secretValue: SecretColorValue) {
        correctButtonTag = Array(1...4).randomElement()!
        buttonsCollection.forEach { button in
            if button.tag == correctButtonTag {
                button.backgroundColor = secretValue.value.getByUIColor()
            } else {
                var copySecretValueForButton = secretValue
                copySecretValueForButton.setRandomValue()
                button.backgroundColor = copySecretValueForButton.value.getByUIColor()
            }
        }
    }
    
    private func showAlertWith( score: Int ) {
        let alert = UIAlertController(
            title: "Game over",
            message: "You have earned \(score) points",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "Start over",
            style: .default,
            handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


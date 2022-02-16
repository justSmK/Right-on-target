//
//  ViewController.swift
//  Right on target
//
//  Created by justSmK on 14.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    var number: Int = 0 //hidden number
    var round: Int = 1 //round num
    var points: Int = 0 //sum of points per round
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        self.number = Int.random(in: 1...50)
        self.label.text = String(self.number)
    }
    
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    @IBAction func checkNumber() {
        
        let numSlider = Int(self.slider.value.rounded())
        if numSlider > self.number {
            self.points += 50 - numSlider + self.number
        } else if numSlider < self.number {
            self.points += 50 - self.number + numSlider
        } else {
            self.points += 50
        }
        if self.round == 5 {
            let alert = UIAlertController(
                title: "Game over",
                message: "You have earned \(self.points) points",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Start over",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.round = 1
            self.points = 0
        } else {
            self.round += 1
        }
        self.number = Int.random(in: 1...50)
        self.label.text = String(self.number)
    }

    lazy var secondViewController: SecondViewController = getSecondViewController()
    private func getSecondViewController() -> SecondViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        return viewController as! SecondViewController
    }
    
    @IBAction func showNextScreen() {
        self.present(secondViewController, animated: true, completion: nil)
    }

}


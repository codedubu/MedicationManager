//
//  MoodSurveyViewController.swift
//  MedicationManager
//
//  Created by River McCaine on 1/20/21.
//

import UIKit

protocol MoodSurveyViewControllerDelegate: AnyObject {
    func emojiSelected(emoji: String)
}

class MoodSurveyViewController: UIViewController {
    // MARK: - Properties
    weak var delegate: MoodSurveyViewControllerDelegate?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - Actions
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func emojiButtonTapped(_ sender: UIButton) {
        guard let emoji = sender.titleLabel?.text else { return }
        
        delegate?.emojiSelected(emoji: emoji)
        dismiss(animated: true, completion: nil)

        
        
// If else way of doing it.
//        if emoji == "😝" {
//            print("BWEEEE")
//        } else if emoji == "🤨" {
//            print("hmmm.")
//        } else {
//            print("naw son...")
//        }
        
    }
    
        
    
    
    
    
    
    
    
    
    
    
}

//
//  MySkillsViewController.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 30/01/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class MySkillsViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var photoView: GradientView!
    @IBOutlet weak var button: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = button.frame.height / 2
        button.clipsToBounds = true
        
        photoView.layer.cornerRadius = photoView.frame.height / 2
        photoView.clipsToBounds = true
        
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        
        containerView.layer.cornerRadius = 25.0
        containerView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        containerView.layer.shadowRadius = 3.0
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowOpacity = 0.6
        containerView.layer.masksToBounds = false
        
//        title = "Minhas Habilidades"
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  KennyOyunu
//
//  Created by ertugrul on 13.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sayacLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hightscoreLabel: UILabel!
    
    var count = 10
    var timer = Timer()
    var score = 0
    var hightscore = 0
    
    let screenSize: CGRect = UIScreen.main.bounds
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sayacLabel.text = "Sayac: \(count)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        
        //UserDefaults.standard.set(hightscore, forKey: "hightscore")
        var exshightScore = UserDefaults.standard.integer(forKey: "hightscore")
        
        if score > exshightScore {
            UserDefaults.standard.removeObject(forKey: "hightscore")
            var exshightScore = UserDefaults.standard.set(score, forKey: "hightscore")
            
        }
        hightscoreLabel.text = "Hightscore: \(exshightScore)"
        
        
    }


    @objc func update() {
    
        if count >= 0 {
            sayacLabel.text = "Sayac: \(count)"
            count -= 1
            location()
            
        }
        if count == -1 {
            timer.invalidate()
            UserDefaults.standard.set(score, forKey: "hightscore")
        }
        
    }
    
    
    func location(){
        
        let randomIntHeight = Int.random(in: 0..<Int(screenSize.height))
        let randomIntWidht = Int.random(in: 0..<Int(screenSize.width))
        let imageName = "kenny.png"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        imageView.isUserInteractionEnabled = true
        
        let gesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(pictureclicked))
        imageView.addGestureRecognizer(gesterRecognizer)
        
        imageView.frame = CGRect(x: randomIntWidht-100, y: randomIntHeight-100, width: 100, height: 100)
        view.addSubview(imageView)
        timer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(removephoto), userInfo: nil, repeats: false)

        
        
    }
    
    @objc func removephoto(){
        imageView.removeFromSuperview()
    }
    
    @objc func pictureclicked(){
        if count != -1{
            score += 1
            scoreLabel.text = "Score: \(score)"
        }
    }
}


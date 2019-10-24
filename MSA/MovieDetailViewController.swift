//
//  MovieDetailViewController.swift
//  MSA
//
//  Created by Mac for Rav on 10/20/19.
//  Copyright © 2019 RayZhang. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var indy : UIActivityIndicatorView = UIActivityIndicatorView()
    var movie : Movie!
    var image : UIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "\(movie.title)"
        view.backgroundColor = UIColor.white
        
        
        let theImageFrame = CGRect(x: view.frame.midX/2 - 24, y: 80, width: image.size.width/2,height: image.size.height/2)
        let imageView = UIImageView(frame: theImageFrame)
        imageView.image = image
        view.addSubview(imageView)
        
        let theTextFrame = CGRect(x: 0, y: image.size.height/2 + 100, width: view.frame.width, height: 30)
        let textView = UILabel(frame: theTextFrame)
        textView.text = "Full Title: \(movie.title)"
        textView.textAlignment = .center
        view.addSubview(textView)
        
        let theTextFrameII = CGRect(x: 0, y: image.size.height/2 + 130, width: view.frame.width, height: 30)
        let textViewII = UILabel(frame: theTextFrameII)
        textViewII.text = "Release Date: \(movie.release_date)"
        textViewII.textAlignment = .center
         view.addSubview(textViewII)
        
        let theTextFrameIII = CGRect(x: 0, y: image.size.height/2 + 160, width: view.frame.width, height: 30)
        let textViewIII = UILabel(frame: theTextFrameIII)
        textViewIII.text = "Voted Average: \(movie.vote_average)"
        textViewIII.textAlignment = .center
        view.addSubview(textViewIII)
        
        let theButtonFrame = CGRect(x: view.frame.midX/2 + 20, y: image.size.height/2 + 220, width: view.frame.width/3, height: 30)
        let button = UIButton(frame: theButtonFrame)
        button.backgroundColor = UIColor.gray
        button.setTitle("Add to Favorite", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)

        indy.color = UIColor.black
        indy.hidesWhenStopped = true
        indy.style = UIActivityIndicatorView.Style.gray
        indy.center = self.view.center
        self.view.addSubview(indy)
//        rating.text = "Voted: \(movie.vote_count)"
        
    }
    @objc func buttonAction(sender: UIButton!) {
        if UserDefaults.standard.array(forKey: "favId") == nil{
            var fav : Array<Int> = []
            fav.append(movie.id)
            UserDefaults.standard.set(fav, forKey: "favId")
        }
        else{
            var favArray = UserDefaults.standard.array(forKey: "favId") as! Array<Int>
            if favArray.contains(movie.id) == false{
                favArray.append(movie.id)
                UserDefaults.standard.set(favArray, forKey: "favId")
            }
        }
        if UserDefaults.standard.array(forKey: "favorites") == nil{
            var fav : Array<String> = []
            fav.append(movie.title)
            UserDefaults.standard.set(fav, forKey: "favorites")
        }
        else{
            var favArray = UserDefaults.standard.array(forKey: "favorites") as! Array<String>
            if favArray.contains(movie.title) == false{
                favArray.append(movie.title)
                UserDefaults.standard.set(favArray, forKey: "favorites")
            }
        }
        
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

//
//  ViewController.swift
//  MSA
//
//  Created by Mac for Rav on 10/20/19.
//  Copyright © 2019 RayZhang. All rights reserved.
//
// UI button Created i  MovieDetailController credit to StackOverflow https://stackoverflow.com/questions/24030348/how-to-create-a-button-programmatically
// All data fetched attributed to the MovieDatabase @ themoviedb.org
// APP Icons copyrights to www.iconbeast.com

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var idPut: UITextField!
    
    var moviesArray : [Movie] = []
    var imagesCacheArray : [UIImage] = []
    var adult : Bool = true
    var language : String = "en"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    @IBAction func searchSim(_ sender: Any) {
        guard let idText = idPut.text else{
            return
        }
        if let id = Int(idText){
            self.indy.startAnimating()
            if id < UserDefaults.standard.array(forKey: "favId")!.count{
                DispatchQueue.global().async {
                    self.moviesArray = []
                    self.imagesCacheArray = []
                    self.fetchSimilarData(id: UserDefaults.standard.array(forKey: "favId")![id] as! Int)
                    self.cacheImage()
                    DispatchQueue.main.async {
                        self.indy.stopAnimating()
                        self.collectionViewOutlet.reloadData()
                    }
                }
            }
        }
        
    }
    
    
    
    
    
    @IBAction func searchTrend(_ sender: Any) {
        self.indy.startAnimating()
        self.moviesArray = []
        self.imagesCacheArray = []
        DispatchQueue.global().async {
            self.adult = UserDefaults.standard.bool(forKey: "adultSwitch")
            self.language = UserDefaults.standard.string(forKey: "languageSelect")!
            let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=c68db2b6ae07df2276df2c27cf365859&language=\(self.language)&adult=\(self.adult)&page=1"
            let url = URL(string: urlString)!
            guard let data = try? Data(contentsOf: url) else{
                return
            }
            let outcome = try! JSONDecoder().decode(APIResults.self, from: data)
            for i in outcome.results{
                if i.poster_path != nil{
                    self.moviesArray.append(i)
                }
            }
            self.cacheImage()
            DispatchQueue.main.async {
                self.indy.stopAnimating()
                self.collectionViewOutlet.reloadData()
            }
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        guard let name = searchInput.text else{
            return
        }
        self.indy.startAnimating()
        DispatchQueue.global().async {
            self.moviesArray = []
            self.imagesCacheArray = []
            self.fetchData(movieN: "\(name)")
            self.cacheImage()
            DispatchQueue.main.async {
                self.indy.stopAnimating()
                self.collectionViewOutlet.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CustomCell
        myCell.movieName.text = moviesArray[indexPath.row].title
        myCell.movieImage.image = imagesCacheArray[indexPath.row]
        return myCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var imageHD : UIImage!
        self.indy.startAnimating()
        do{
            let urlHD = URL(string:"https://image.tmdb.org/t/p/w500/\(self.moviesArray[indexPath.row].poster_path!)" )
            let data = try Data(contentsOf: urlHD!)
            imageHD = UIImage(data: data)
        }
        catch{
            imageHD = UIImage(named: "NA")
        }
        self.indy.stopAnimating()
        let movieDetailVC = MovieDetailViewController()
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
        movieDetailVC.movie = self.moviesArray[indexPath.row]
        movieDetailVC.image = imageHD
    }
    
    var indy : UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(adult, forKey: "adultSwitch")
        UserDefaults.standard.set(language, forKey: "languageSelect")
        self.title = "Movies"
        indy.color = UIColor.black
        indy.hidesWhenStopped = true
        indy.style = UIActivityIndicatorView.Style.gray
        indy.center = self.view.center
        // Do any additional setup after loading the view.
        self.view.addSubview(indy)
        setUpCollectionView()
    }
    //7a0b9213a4ab971221daf319e2e2010e
    
    
    func setUpCollectionView(){
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.delegate = self
    }
    func fetchData(movieN : String){
        adult = UserDefaults.standard.bool(forKey: "adultSwitch")
        language = UserDefaults.standard.string(forKey: "languageSelect")!
        let movieName = movieN.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=7a0b9213a4ab971221daf319e2e2010e&query=\(movieName)&language=\(language)&adult=\(adult)"
        let url = URL(string: urlString)!
        guard let data = try? Data(contentsOf: url) else{
            return
        }
        do{
            let outcome = try JSONDecoder().decode(APIResults.self, from: data)
            for i in outcome.results{
                if i.poster_path != nil{
                    moviesArray.append(i)
                }
            }
        }
        catch{
            moviesArray = []
        }
    }
    func fetchSimilarData(id : Int){
        adult = UserDefaults.standard.bool(forKey: "adultSwitch")
        language = UserDefaults.standard.string(forKey: "languageSelect")!
        let urlString = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=7a0b9213a4ab971221daf319e2e2010e&language=\(language)S&page=1"
        let url = URL(string: urlString)!
        guard let data = try? Data(contentsOf: url) else{
            return
        }
        do{
            let outcome = try JSONDecoder().decode(APIResults.self, from: data)
            for i in outcome.results{
                if i.poster_path != nil{
                    moviesArray.append(i)
                }
            }
        }
        catch{
            moviesArray = []
        }
    }
    
    func cacheImage(){
        for i in moviesArray {
            do {
                let url = URL(string:"https://image.tmdb.org/t/p/w200/\(i.poster_path!)" )
                let data = try Data(contentsOf: url!)
                let image = UIImage(data:data)
                imagesCacheArray.append(image!)
            }catch{
                print("No pic for this movie")
                imagesCacheArray.append(UIImage(named: "NA")!)
            }
        }
    }
    
    
}


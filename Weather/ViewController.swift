//
//  ViewController.swift
//  Weather
//
//  Created by Şükrü Şimşek on 13.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    var backgroundImageView = UIImageView()
    var cityLabel = UILabel()
    var temperatureLabel = UILabel()
    let searchStackView = UIStackView()
    let mainStackView = UIStackView()
    var statusImageView = UIImageView()
    let locationButton = UIButton(type: .system)
    let searchButton = UIButton(type: .system)
    let searchTextField = UITextField()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}
//MARK: - Helpers
extension ViewController{
    private func style(){
        //backgroundImageView style
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "afternoon.jpeg")
        //label style
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.text = "New York"
        cityLabel.font = .boldSystemFont(ofSize: 50)
        cityLabel.textColor = .black
        //temperatureLabel style
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.text = "123"
        temperatureLabel.textColor = .black
        //searchStackView style
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.axis = .horizontal
        searchStackView.spacing = 12
        //mainStackView style
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 12
        mainStackView.alignment = .trailing
        //statusImageView style
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.image = UIImage(systemName: "sun.max")
        statusImageView.tintColor = .black
        //locationButton style
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .black
        locationButton.contentVerticalAlignment = .fill
        locationButton.contentHorizontalAlignment = .fill
        //searchButton style
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .normal)
        searchButton.tintColor = .black
        searchButton.contentVerticalAlignment = .fill
        searchButton.contentHorizontalAlignment = .fill
        searchButton.addTarget(self, action: #selector(getData), for: .touchUpInside)
        //searchTextField style
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Search"
        searchTextField.font = .boldSystemFont(ofSize: 20)
        searchTextField.borderStyle = .roundedRect
        searchTextField.textAlignment = .left
        searchTextField.backgroundColor = .systemFill
        searchTextField.textColor = .black
    }
    private func layout(){
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(searchStackView)
        mainStackView.addArrangedSubview(cityLabel)
        mainStackView.addArrangedSubview(statusImageView)
        mainStackView.addArrangedSubview(temperatureLabel)
        searchStackView.addArrangedSubview(locationButton)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(searchButton)
        
        
        NSLayoutConstraint.activate([
            //background layout
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //locationButton layout with searchStackView
            
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            
            //searchButton layout with searchStackView
            searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -12),
            searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            locationButton.widthAnchor.constraint(equalToConstant: 35),
            locationButton.heightAnchor.constraint(equalToConstant: 35),
            searchButton.widthAnchor.constraint(equalToConstant: 35),
            searchButton.heightAnchor.constraint(equalToConstant: 35),
            
            statusImageView.widthAnchor.constraint(equalToConstant: 50),
            statusImageView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    @objc func getData() {
        //1.Create URL
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?&appid=87de7504b5292a842a4dd070b053577c&units=metric&lang=tr&q=Manisa")
        
        //2.Create a URLSession
        let session = URLSession.shared
        
        //3.Give the session a task
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("error")
                return
            } else {
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                        DispatchQueue.main.async {
                            if let main = jsonResponse!["main"] as? [String:Any] {
                                if let temp = main["temp"] as? Double {
                                    self.temperatureLabel.text = String(Int(temp))
                                }
                                
                            }
                            if let name = jsonResponse!["name"] as? String {
                                    self.cityLabel.text = String(name)
                                    
                                }
                            }
                        
                    } catch {
                        
                    }
                }
            }
        }
        
        //4.Start the task
        task.resume()
}
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Type something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            
        }
    }
}

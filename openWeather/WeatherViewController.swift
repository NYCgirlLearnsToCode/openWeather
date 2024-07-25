//
//  ViewController.swift
//  openWeather
//
//  Created by Lisa J on 7/24/24.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var weatherAttributes: NYWeather?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadData() {
        guard let pathToData = Bundle.main.path(forResource: "NYWeather", ofType: "json") else {
            fatalError("file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            let weatherAttribsFromJson = try NYWeather.getWeather(from: data)
            weatherAttributes = weatherAttribsFromJson
        } catch {
            fatalError("an error occurred:\(error)")
        }
    }
}

extension WeatherViewController: UITableViewDelegate {}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        if let weather = weatherAttributes?.weather.first {
            cell.detailTextLabel?.text = weather.main
        }
        cell.textLabel?.text = weatherAttributes?.name
        return cell
    }
}


//
//  ViewController.swift
//  Itika's Task
//
//  Created by Itika Soni on 19/07/23.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var mobileNo: UILabel!
    @IBOutlet weak var emailId: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getUserDetailsApi()
        getUserListApi()
    }
    
    
    func getUserListApi () {
        // Your API URL goes here
        let apiUrlString = "https://fakestoreapi.com/users?limit=5"
        
        guard let apiUrl = URL(string: apiUrlString) else {
            print("Invalid URL.")
            return
        }
        
        // Create the request object
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "GET"
     
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let userDetails = try JSONDecoder().decode(UserList.self, from: data)
                DispatchQueue.main.async {
                    self.countryCode.text = userDetails[0].address?.city
                }
                
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func getUserDetailsApi () {
        // Your API URL goes here
        let apiUrlString = "http://44.203.191.54:3000/user-details"
        
        guard let apiUrl = URL(string: apiUrlString) else {
            print("Invalid URL.")
            return
        }
        
        // Create the request object 
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        
        let bearerToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzBjOGRlNThhM2Q2NmQ2ZWQ5Njk0MDEiLCJleHAiOjE2Nzg3NzMzOTguMDYzLCJpYXQiOjE2NzM1ODkzOTh9.sHnc46uPsnX14N1hzaL5emmmH3MpoFh_UN91uMNUgYc"
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "id": "7"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let userDetails = try JSONDecoder().decode(UserDetailsModel.self, from: data)
                if let firstData = userDetails.data?.first {
                    DispatchQueue.main.async {
                        // Update the labels with the fetched data
                        self.emailId.text = firstData.email
                        self.userName.text = firstData.username
                        self.countryCode.text = firstData.countryCode
                        self.mobileNo.text = firstData.mobileNumber
                    }

                    let imageUrl = URL(string: firstData.profileImg ?? "")!
                    let staticImgURL = URL(string: "http://44.203.191.54:3000/upload/profile_1688620058495.jpg")!
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageUrl) {
                            DispatchQueue.main.async {
                                let image = UIImage(data: imageData)
                                self.profileImg.image = image
                            }
                        } else if let imageData = try? Data(contentsOf: staticImgURL) {
                            DispatchQueue.main.async {
                                let image = UIImage(data: imageData)
                                self.profileImg.image = image
                            }
                        }
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}

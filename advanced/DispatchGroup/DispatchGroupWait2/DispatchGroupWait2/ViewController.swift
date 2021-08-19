//
//  ViewController.swift
//  DispatchGroupWait2
//
//  Created by jrasmusson on 2021-08-18.
//

import UIKit

struct Profile: Codable {
    let id: String
    let name: String
}

struct Entitlement: Codable {
    let id: String
    let entitlement: String
}

struct Preference: Codable {
    let id: String
    let vehicle: String
}

class ViewController: UIViewController {
    @IBOutlet var profileLabel: UILabel!
    @IBOutlet var entitlementLabel: UILabel!
    @IBOutlet var preferenceLabel: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: Networking
extension ViewController {
    
    func fetchProfile(_ completion: @escaping (Preference?) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/preference/1")!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard err == nil, let data = data else { return }
            do {
                let preference = try JSONDecoder().decode(Preference.self, from: data)
                DispatchQueue.main.async {
                    completion(preference)
                }
            } catch let err {
                print(err)
            }
        }.resume()
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        fetchProfile { maybePreference in
            guard let preference = maybePreference else { return }
            self.preferenceLabel.text = preference.vehicle
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.loginButton.isEnabled = true
        }
    }
    

}

// MARK: Actions
extension ViewController {
    @IBAction func goTapped(_ sender: Any) {
        fetchData()
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        profileLabel.text = ""
        entitlementLabel.text = ""
        preferenceLabel.text = ""
        loginButton.isEnabled = false
    }
}

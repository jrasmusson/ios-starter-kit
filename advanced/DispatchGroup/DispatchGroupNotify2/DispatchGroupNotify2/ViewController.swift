//
//  ViewController.swift
//  DispatchGroupNotify2
//
//  Created by jrasmusson on 2021-08-21.
//

import UIKit

struct Profile: Codable {
    let id: String
    let name: String
}

struct Entitlement: Codable {
    let id: String
    let access: String
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


// MARK: DispatchGroup
extension ViewController {
    private func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        print("Enter")
        fetchProfile { optionalProfile in
            guard let profile = optionalProfile else { return }
            self.profileLabel.text = profile.name
            group.leave()
            print("Leave")
        }

        group.enter()
        print("Enter")
        fetchEntitlement { optionalEntitlement in
            guard let entitlement = optionalEntitlement else { return }
            self.entitlementLabel.text = entitlement.access
            group.leave()
            print("Leave")
        }

        group.enter()
        print("Enter")
        fetchPreference { optionalEntitlement in
            guard let entitlement = optionalEntitlement else { return }
            self.preferenceLabel.text = entitlement.vehicle
            group.leave()
            print("Leave")
        }

        group.notify(queue: .main) {
            print("Notify")
            self.loginButton.isEnabled = true
        }
    }
}

// MARK: Networking
extension ViewController {
    
    func fetchProfile(_ completion: @escaping (Profile?) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/profile/1")!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard err == nil, let data = data else { return }
            do {
                let profile = try JSONDecoder().decode(Profile.self, from: data)
                DispatchQueue.main.async {
                    completion(profile)
                }
            } catch let err {
                print(err)
            }
        }.resume()
    }

    func fetchEntitlement(_ completion: @escaping (Entitlement?) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/entitlement/1")!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard err == nil, let data = data else { return }
            do {
                let entitlement = try JSONDecoder().decode(Entitlement.self, from: data)
                DispatchQueue.main.async {
                    completion(entitlement)
                }
            } catch let err {
                print(err)
            }
        }.resume()
    }

    func fetchPreference(_ completion: @escaping (Preference?) -> Void) {
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

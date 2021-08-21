//
//  ViewController.swift
//  DispatchGroupWait
//
//  Created by jrasmusson on 2021-08-21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
    }
    
    var hasDuplicatePayment = false
    
    var group = DispatchGroup()
    
    @IBAction func send(_ sender: Any) {
        group.enter()
        
        fetchCheckDuplicate() { hasDuplicate in
            self.hasDuplicatePayment = hasDuplicate
            self.group.leave()
        }
        
        // Because we don't want to block the main UI thread
        // We put our synchronous wait on a low priority non-UI
        // backgroun thread.
        DispatchQueue.global(qos: .default).async {
            self.group.wait() // synchronous wait
            
            // When we are ready to update the UI, we can put
            // ourselves back onto the main thread.
            DispatchQueue.main.async {
                self.showAlert(self.hasDuplicatePayment) // on main thread
            }
        }
    }
        
    func showAlert(_ hasDuplicatePayment: Bool) {
        let message: String
        if self.hasDuplicatePayment {
            message = "Duplicate payment detected"
        } else {
            message = "Money sent"
        }

        let alert = UIAlertController(title: "Send Money Transfer",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: Networking
extension ViewController {
    func fetchCheckDuplicate(_ completion: @escaping (Bool) -> Void) {
        let url = URL(string: "https://reqres.in/api/users?delay=3")! // 3 sec
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            DispatchQueue.main.async {
                let hasDuplicate = false
                completion(hasDuplicate)
            }
        }.resume()
    }
}

// MARK: Misc
extension ViewController {
    private func startTimer() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    @objc func updateClock() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .long
        timerLabel.text = "\(dateFormatter.string(from: Date()))"
    }
}


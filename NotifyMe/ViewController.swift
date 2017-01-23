//
//  ViewController.swift
//  NotifyMe
//
//  Created by Jonathan Archille on 1/22/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import UIKit
import UserNotifications
import AppusCircleTimer

class ViewController: UIViewController, AppusCircleTimerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selectedTime = 0.0
    
    @IBOutlet weak var timerPickerView: UIPickerView!
    @IBOutlet weak var circleTimer: AppusCircleTimer!
    @IBOutlet weak var timerActionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleTimer.delegate = self
        circleTimer.totalTime = 0

    }
    
    // MARK: - Notification Trigger
    
    func circleCounterTimeDidExpire(circleTimer: AppusCircleTimer) {
        timerActionButton.isSelected = false
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Do stuff"
        content.badge = 1
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Reminder", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: { error in
            
            if let theError = error
            {
                print(theError.localizedDescription)
            }
            else
            {
                print("user notification scheduled successfully.")
            
            }
        
        })
    }
    
    
    @IBAction func startStopTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        circleTimer.totalTime = selectedTime
        
        if (sender.isSelected)
        {
            if (circleTimer?.didStart)!
            {
                circleTimer?.resume()
            }
                else
                {
                    circleTimer?.start()
                }
        } else
        {
            circleTimer?.stop()
        }
        
    }
    
    // MARK: - Picker delegate + data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0
        {
            return 60
        }
        else
        {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if component == 0
        {
            let seconds = "\(row + 1)"
            return NSAttributedString(string: seconds, attributes: [NSForegroundColorAttributeName:UIColor.orange])
        } else
        {
            return NSAttributedString(string: "sec", attributes: [NSForegroundColorAttributeName:UIColor.orange])
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTime = Double(row) + 1
    }
    
}


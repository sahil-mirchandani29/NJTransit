//
//  ViewController.swift
//  NJTransist
//
//  Created by Sahil Mirchandani on 7/22/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var expiryTimeLabel: UILabel!
    @IBOutlet weak var blinkingView: UIImageView!
    var minutesRemaining = 58
    var secondsRemaining = 58
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = Date().getDateLabel()
        expiryTimeLabel.text = getExpiryLabelText()
    }

    override func viewDidAppear(_ animated: Bool) {
        blink()
    }

    func blink() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.blinkingView.isHidden.toggle()
            self?.updateTime()
            self?.blink()
        }
    }

    func getExpiryLabelText() -> String {
        secondsRemaining -= 1
        if secondsRemaining == 0 {
            minutesRemaining -= 1
            secondsRemaining = 58
        }
        return "00:00:\(minutesRemaining):\(secondsRemaining)"
    }

    func updateTime() {
        timeLabel.text = Date().getTimeLabel()
        expiryTimeLabel.text = getExpiryLabelText()
    }
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }

    func dayOfWeek() -> String {
        let number = dayNumberOfWeek()
        switch number {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Sunday"
        }
    }

    func getDateLabel() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        return "\(dayOfWeek()), \(dateFormatter.string(from: self))"
    }

    func getTimeLabel() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
    }
}

//
//  NewActivityViewController.swift
//  Notedy
//
//  Created by Nuntapat Hirunnattee on 30/7/2565 BE.
//

import UIKit

class NewActivityViewController: UIViewController {

    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var timeLabel: UITextField!
    
    var activeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Activity"
        
        dateLabel.delegate = self
        
        timeLabel.delegate = self
        
        
        dateLabel.text = formatDate(date: Date())
        
        timeLabel.text = formatTime(time: Date())
        
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - TextFieldDelegate
extension NewActivityViewController: UITextFieldDelegate{
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
            openDatePicker(dateTextField: dateLabel)
        
            openTimePicker(timeTextField: timeLabel)
    }
}

//MARK: - DatePicker
extension NewActivityViewController{
    
    func openDatePicker(dateTextField: UITextField){
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateLabel.inputView = datePicker
        
        dateLabel.inputAccessoryView = setUpToolBar(with: dateTextField)
    }
    
    func openTimePicker(timeTextField: UITextField){

        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)

        timePicker.frame.size = CGSize(width: 0, height: 300)
        timePicker.preferredDatePickerStyle = .wheels

        timeLabel.inputView = timePicker

        timeLabel.inputAccessoryView = setUpToolBar(with: timeTextField)
    }

    
    
    @objc func dateChange(datePicker: UIDatePicker){
        dateLabel.text = formatDate(date: datePicker.date)
        timeLabel.text = formatTime(time: datePicker.date)
    }
    
    
    func formatDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func formatTime(time: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: time)
    }
}




//MARK: - ToolBar
extension NewActivityViewController{
    
    func setUpToolBar(with textField: UITextField) -> UIToolbar{
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelBtnPressed))
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBtnPressed))
        let flexibelBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.barTintColor = .systemBackground
        
        toolBar.setItems([cancelBtn, flexibelBtn, doneBtn], animated: false)
        
        return toolBar
    }
    
    @objc func cancelBtnPressed(){
        dateLabel.resignFirstResponder()
        timeLabel.resignFirstResponder()
    }
    
    @objc func doneBtnPressed(){
        
        if let datePicker = dateLabel.inputView as? UIDatePicker{
            dateLabel.text = formatDate(date: datePicker.date)
        }
        
        if let datePicker = timeLabel.inputView as? UIDatePicker{
            timeLabel.text = formatTime(time: datePicker.date)
        }
        view.endEditing(true)
    }
}

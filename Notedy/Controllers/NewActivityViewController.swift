//
//  NewActivityViewController.swift
//  Notedy
//
//  Created by Nuntapat Hirunnattee on 30/7/2565 BE.
//

import UIKit
import RealmSwift

class NewActivityViewController: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var detailTF: UITextField!
    
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    let realm = try! Realm()
    let picker = UIDatePicker()
    var tempTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Activity"
        
        dateTF.delegate = self
        timeTF.delegate = self
        titleTF.delegate = self
        
        dateTF.text = formatDate(date: Date(), .date)
        timeTF.text = formatDate(date: Date(), .time)
        
        picker.frame.size = CGSize(width: 0, height: 300)
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "TH")
        
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        if titleTF.text != ""{
            saveActivity()
        } else {
            let alert = UIAlertController(title: "Alert", message: "Title cannot be empty.", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
//MARK: - Data Data Manipulation Methods
    func saveActivity(){
        
        let newActivity = Activity()
        
        newActivity.title = titleTF.text!
        
        if let location = locationTF.text{
            newActivity.location = location
        }
        
        if let detail = detailTF.text{
            newActivity.detail = detail
        }
        
        newActivity.time = timeTF.text!
        newActivity.date = dateTF.text!
        
        do{
            try realm.write {
                realm.add(newActivity)
                navigationController?.popViewController(animated: true)
            }
        } catch {
            print("Error saving data. \(error)")
        }
    }
    
    
}


//MARK: - TextFieldDelegate Methods
extension NewActivityViewController: UITextFieldDelegate{
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateTF{
            openPicker(with: textField, mode: .date)
        }
        if textField == timeTF{
            openPicker(with: textField, mode: .time)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        //open datePicker with valued textField
        let dateFormatter = DateFormatter()
        if textField == dateTF{
            dateFormatter.dateStyle = .medium
            picker.date = dateFormatter.date(from: textField.text!)!
        }
        
        if textField == timeTF{
            dateFormatter.dateFormat = "HH:mm"
            picker.date = dateFormatter.date(from: textField.text!)!
        }
        return true
    }
    
}

//MARK: - DatePicker
extension NewActivityViewController{
    
    func openPicker(with textField: UITextField, mode: UIDatePicker.Mode) {
        tempTextField = textField
        picker.datePickerMode = mode
        picker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        textField.inputView = picker
        textField.inputAccessoryView = setUpToolBar()
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        tempTextField.text = formatDate(date: datePicker.date, datePicker.datePickerMode)
    }
    
    func formatDate(date: Date, _ mode: UIDatePicker.Mode) -> String{
        let formatter = DateFormatter()
        if mode == .date { formatter.dateStyle = .medium }
        if mode == .time { formatter.dateFormat = "HH:mm" }
        return formatter.string(from: date)
    }
}




//MARK: - ToolBar
extension NewActivityViewController{
    
    func setUpToolBar() -> UIToolbar{
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelBtnPressed))
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBtnPressed))
        let flexibelBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelBtn, flexibelBtn, doneBtn], animated: false)
        toolBar.barTintColor = UIColor(named: "PrimaryColor")
        return toolBar
    }
    
    @objc func cancelBtnPressed(){
        tempTextField.resignFirstResponder()
        tempTextField = UITextField()
    }
    
    @objc func doneBtnPressed(){
        if let datePicker = tempTextField.inputView as? UIDatePicker{
            tempTextField.text = formatDate(date: datePicker.date, datePicker.datePickerMode)
            tempTextField = UITextField()
        }
        view.endEditing(true)
    }
}


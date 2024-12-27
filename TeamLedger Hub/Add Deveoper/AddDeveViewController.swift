//
//  AddDeveViewController.swift
//  TeamLedger Hub
//
//  Created by ucf 2 on 23/12/2024.
//

import UIKit

class AddDeveViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var AddressTF: UITextField!
    @IBOutlet weak var GenderTF: DropDown!
    @IBOutlet weak var ContactTF: UITextField!
    @IBOutlet weak var DateodbirthTF: UITextField!
    @IBOutlet weak var JoiningdateTF: UITextField!
    @IBOutlet weak var Save_btn: UIButton!
    @IBOutlet weak var MianView: UIView!
    
    private var datePicker: UIDatePicker?
    var pickedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyCornerRadiusToBottomCorners(view: MianView, cornerRadius: 35)
        
        // Gender Dropdown Configuration
        GenderTF.optionArray = ["Male", "Female"]
        GenderTF.didSelect { (selectedText, index, id) in
            self.GenderTF.text = selectedText
        }
        GenderTF.delegate = self
        
        // Dismiss keyboard on tap
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture2.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture2)
        
        // Setup Date Pickers
        setupDatePicker(for: DateodbirthTF, target: self, doneAction: #selector(donePressed))
        setupDatePicker(for: JoiningdateTF, target: self, doneAction: #selector(donePressed2))
        
        // Style Save Button
        Save_btn.layer.cornerRadius = 8
        applyGradientToButton(button: Save_btn, colors: [UIColor(hex: "FF6A5A"), UIColor(hex: "FF9B90")])
    }
    
    func applyGradientToButton(button: UIButton, colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5) // Start from left
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)   // End at right
        gradientLayer.cornerRadius = button.layer.cornerRadius
        
        // Remove existing gradient layers
        button.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        
        button.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func donePressed() {
        if let datePicker = DateodbirthTF.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            DateodbirthTF.text = dateFormatter.string(from: datePicker.date)
        }
        DateodbirthTF.resignFirstResponder()
    }
    
    @objc func donePressed2() {
        if let datePicker = JoiningdateTF.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            JoiningdateTF.text = dateFormatter.string(from: datePicker.date)
        }
        JoiningdateTF.resignFirstResponder()
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func clearTextFields() {
        NameTF.text = ""
        AddressTF.text = ""
        GenderTF.text = ""
        ContactTF.text = ""
        DateodbirthTF.text = ""
        JoiningdateTF.text = ""
    }
    
    func saveData(_ sender: Any) {
        guard let eName = NameTF.text, !eName.isEmpty,
              let Address = AddressTF.text,
              let Gender = GenderTF.text, !Gender.isEmpty,
              let Contact = ContactTF.text, !Contact.isEmpty,
              let DateoFBirth = DateodbirthTF.text,
              let Joiningdate = JoiningdateTF.text, !Joiningdate.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all fields.")
            return
        }
      
        let randomCharacter = generateRandomCharacter()
        let newDetail = Developer(
            id: "\(randomCharacter)",
            name: eName,
            Address: Address,
            gender: Gender,
            contact: Contact,
            dateofbirth: DateoFBirth,
            joiningdate: Joiningdate
        )
        saveUserDetail(newDetail)
    }
    
    func saveUserDetail(_ employee: Developer) {
        var employees = UserDefaults.standard.object(forKey: "DevDetails") as? [Data] ?? []
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(employee)
            employees.append(data)
            UserDefaults.standard.set(employees, forKey: "DevDetails")
            clearTextFields()
        } catch {
            print("Error encoding medication: \(error.localizedDescription)")
        }
        showAlert(title: "Done", message: "Developer Detail has been Saved successfully.")
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        saveData(sender)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 1)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)
    }
}


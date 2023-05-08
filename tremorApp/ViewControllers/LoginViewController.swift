
import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let genderSegmentedControl = UISegmentedControl(items: ["Мужской", "Женский"])
    let birthdatePicker = UIDatePicker()
    let heightTextField = UITextField()
    let weightTextField = UITextField()
    let button = UIButton(type: .system)
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Создание профиля"
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        heightTextField.delegate = self
        weightTextField.delegate = self
        setupUI()
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        // Добавляем текстовые поля и сегментированный контрол на экран
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(genderSegmentedControl)
        
        // Устанавливаем ограничения для текстовых полей
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        firstNameTextField.placeholder = "Имя"
        firstNameTextField.borderStyle = .roundedRect
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 16).isActive = true
        lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        lastNameTextField.placeholder = "Фамилия"
        lastNameTextField.borderStyle = .roundedRect
        
        // Устанавливаем ограничения для сегментированного контрола
        genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        genderSegmentedControl.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 16).isActive = true
        genderSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        genderSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        genderSegmentedControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
        genderSegmentedControl.selectedSegmentIndex = 0
        
        // Добавляем выбор даты рождения
        view.addSubview(birthdatePicker)
        birthdatePicker.translatesAutoresizingMaskIntoConstraints = false
        birthdatePicker.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 16).isActive = true
        birthdatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        birthdatePicker.datePickerMode = .date
        
        heightTextField.placeholder = "Рост (см)"
        heightTextField.keyboardType = .numberPad
        heightTextField.borderStyle = .roundedRect
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heightTextField)

        heightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        heightTextField.topAnchor.constraint(equalTo: birthdatePicker.bottomAnchor, constant: 20).isActive = true
        heightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        heightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true


        weightTextField.placeholder = "Вес (кг)"
        weightTextField.keyboardType = .numberPad
        weightTextField.borderStyle = .roundedRect
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weightTextField)

        weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weightTextField.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 20).isActive = true
        weightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        weightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
        let attributedString = NSAttributedString(string: NSLocalizedString("Сохранить", comment: ""), attributes:[
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16.0),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.underlineStyle: 0
        ])
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.borderWidth = 0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 150),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension LoginViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          view.endEditing(true)
      }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}

extension LoginViewController {
    @objc func buttonTapped() {
        if firstNameTextField.text != "", lastNameTextField.text != "", weightTextField.text != "", heightTextField.text != "" {
            let profile = Profile(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, gender: "Мужской", birthdate: Date(timeIntervalSince1970: 2000), weight: weightTextField.text!, height: heightTextField.text!)
            UserStorage.shared.saveUser(profile)
            let tabBarVC = TabBarController()
            navigationController?.pushViewController(tabBarVC, animated: true)
        } else {
            let successColor = UIColor.green
               let failureColor = UIColor.red
               
               if let name = firstNameTextField.text, !name.isEmpty {
                   firstNameTextField.backgroundColor = successColor
                   firstNameTextField.transform = CGAffineTransform(translationX: 10, y: 0)
                   UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                       self.firstNameTextField.transform = CGAffineTransform.identity
                   }, completion: nil)
               } else {
                   firstNameTextField.backgroundColor = failureColor
                   firstNameTextField.transform = CGAffineTransform(translationX: -10, y: 0)
                   UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                       self.firstNameTextField.transform = CGAffineTransform.identity
                   }, completion: nil)
               }
            
            if let lastName = lastNameTextField.text, !lastName.isEmpty {
                lastNameTextField.backgroundColor = successColor
                lastNameTextField.transform = CGAffineTransform(translationX: 10, y: 0)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                    self.lastNameTextField.transform = CGAffineTransform.identity
                }, completion: nil)
            } else {
                lastNameTextField.backgroundColor = failureColor
                lastNameTextField.transform = CGAffineTransform(translationX: -10, y: 0)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                    self.lastNameTextField.transform = CGAffineTransform.identity
                }, completion: nil)
            }
               
               if let height = heightTextField.text, !height.isEmpty {
                   heightTextField.backgroundColor = successColor
                   heightTextField.transform = CGAffineTransform(translationX: 10, y: 0)
                   UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                       self.heightTextField.transform = CGAffineTransform.identity
                   }, completion: nil)
               } else {
                   heightTextField.backgroundColor = failureColor
                   heightTextField.transform = CGAffineTransform(translationX: -10, y: 0)
                   UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                       self.heightTextField.transform = CGAffineTransform.identity
                   }, completion: nil)
               }
               
               if let weight = weightTextField.text, !weight.isEmpty {
                   weightTextField.backgroundColor = successColor
                   weightTextField.transform = CGAffineTransform(translationX: 10, y: 0)
                   UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                       self.weightTextField.transform = CGAffineTransform.identity
                   }, completion: nil)
               } else {
                   weightTextField.backgroundColor = failureColor
                   weightTextField.transform = CGAffineTransform(translationX: -10, y: 0)
                   UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                       self.weightTextField.transform = CGAffineTransform.identity
                   }, completion: nil)
               }

        }
    }
}

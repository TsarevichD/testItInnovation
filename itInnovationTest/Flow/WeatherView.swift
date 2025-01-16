//
//  WeatherView.swift


import UIKit
import SnapKit

class WeatherView: UIView {
    
    private(set) var firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private(set) var oneLabel: UILabel = {
        let label = UILabel()
        label.text = "Координати для прогнозу\nпогоди"
        label.font = .customFont(font: .roboto, style: .bold, size: 20)
        label.numberOfLines = 0
        label.textColor = .cDark
        label.textAlignment = .left
        return label
    }()
    
    private(set) var lonLabel: UILabel = {
        let label = UILabel()
        label.text = "Довгота"
        label.font = .customFont(font: .roboto, style: .regular, size: 12)
        label.textColor = .cDarkBlue
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private(set) var errorlonLabel: UILabel = {
        let label = UILabel()
        label.text = "Неправильно введені координати"
        label.font = .customFont(font: .roboto, style: .regular, size: 12)
        label.textColor = .cRed
        label.numberOfLines = 0
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    private(set) var latLabel: UILabel = {
        let label = UILabel()
        label.text = "Широта"
        label.font = .customFont(font: .roboto, style: .regular, size: 12)
        label.textColor = .cDarkBlue
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private(set) var errorlatLabel: UILabel = {
        let label = UILabel()
        label.text = "Неправильно введені координати"
        label.font = .customFont(font: .roboto, style: .regular, size: 12)
        label.textColor = .cRed
        label.numberOfLines = 0
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    private(set) var textFieldLon: UITextField = {
        let textField = UITextField()
        let font = UIFont.customFont(font: .roboto, style: .regular, size: 16)
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.cGrey
        ]
        
        let placeholderText = NSAttributedString(string: "Введіть координати", attributes: placeholderAttributes)
        textField.attributedPlaceholder = placeholderText
        
        
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
        ]
        textField.font = UIFont.customFont(font: .roboto, style: .regular, size: 16)
        textField.textColor = .cDark
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.returnKeyType = .done
        textField.keyboardType = .decimalPad
        textField.becomeFirstResponder()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.cDarkBlue.cgColor
        textField.layer.cornerRadius = 5
        
        let paddingLeft = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingLeft
        textField.leftViewMode = .always
        
        let paddingRight = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightView = paddingRight
        textField.rightViewMode = .always
        return textField
    }()
    
    private(set) var textFieldLat: UITextField = {
        let textField = UITextField()
        let font = UIFont.customFont(font: .roboto, style: .regular, size: 16)
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.cGrey
        ]
        
        let placeholderText = NSAttributedString(string: "Введіть координати", attributes: placeholderAttributes)
        textField.attributedPlaceholder = placeholderText
        
        
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
        ]
        textField.font = UIFont.customFont(font: .roboto, style: .regular, size: 16)
        textField.textColor = .cDark
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.returnKeyType = .done
        textField.becomeFirstResponder()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.cDarkBlue.cgColor
        textField.layer.cornerRadius = 5
        textField.keyboardType = .decimalPad

        let paddingLeft = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingLeft
        textField.leftViewMode = .always
        
        let paddingRight = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightView = paddingRight
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private(set) var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Скинути", for: .normal)
        btn.setTitleColor(.cBlue, for: .normal)
        btn.titleLabel?.font = .customFont(font: .roboto, style: .medium, size: 16)
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.cDarkBlue.cgColor
        return btn
    }()
    
    private(set) var sendBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .cDarkBlue
        btn.setTitle("Застосувати", for: .normal)
        btn.titleLabel?.font = .customFont(font: .roboto, style: .medium, size: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 20
        btn.setBackgroundColor(.cBlue, for: .highlighted)
        btn.clipsToBounds = true
        return btn
    }()

    
    private(set) var chooseLabel: UILabel = {
        let label = UILabel()
        label.text = "Оберіть координати"
        label.font = .customFont(font: .roboto, style: .semiBold, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cDark
        label.isHidden = false
        return label
    }()
    
    private(set) var lastDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Останнє оновлення даних"
        label.font = .customFont(font: .roboto, style: .regular, size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cGrey
        label.isHidden = true
        return label
    }()
    
    private(set) var dataLabel: UILabel = {
        let label = UILabel()
        label.text = "25.06.2024 10:00"
        label.font = .customFont(font: .roboto, style: .bold, size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cDark
        label.isHidden = true
        return label
    }()
    
    private(set) var secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.isHidden = true
        return view
    }()
    
    private(set) var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Прогноз"
        label.font = .customFont(font: .roboto, style: .semiBold, size: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cDark
        return label
    }()
    
    private(set) var temperaturesLabel: UILabel = {
        let label = UILabel()
        label.text = "t° повітря"
        label.font = .customFont(font: .roboto, style: .regular, size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cGrey
        return label
    }()
    
    private(set) var iconTempIV: UIImageView = {
        let iv = UIImageView()
        iv.image  = .imgTemp
        return iv
    }()
    
    private(set) var countTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Nan"
        label.font = .customFont(font: .roboto, style: .regular, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cDark
        return label
    }()
    
    private(set) var dewPointsLabel: UILabel = {
        let label = UILabel()
        label.text = "t° відчувається як"
        label.font = .customFont(font: .roboto, style: .regular, size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cGrey
        return label
    }()
    
    private(set) var iconDevIV: UIImageView = {
        let iv = UIImageView()
        iv.image  = .imgDev
        return iv
    }()
    
    private(set) var countDevLabel: UILabel = {
        let label = UILabel()
        label.text = "Nan"
        label.font = .customFont(font: .roboto, style: .regular, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cDark
        return label
    }()
    
    private(set) var pressureLabel: UILabel = {
        let label = UILabel()
        label.text = "Атмосферний тиск"
        label.font = .customFont(font: .roboto, style: .regular, size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cGrey
        return label
    }()
    
    private(set) var iconPresIV: UIImageView = {
        let iv = UIImageView()
        iv.image  = .imgPress
        return iv
    }()
    
    private(set) var countPresLabel: UILabel = {
        let label = UILabel()
        label.text = "Nan"
        label.font = .customFont(font: .roboto, style: .regular, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cDark
        return label
    }()
    
    private(set) var humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "Відносна вологість"
        label.font = .customFont(font: .roboto, style: .regular, size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cGrey
        return label
    }()
    
    private(set) var iconHumIV: UIImageView = {
        let iv = UIImageView()
        iv.image  = .imgHum
        return iv
    }()
    
    private(set) var countHumLabel: UILabel = {
        let label = UILabel()
        label.text = "Nan"
        label.font = .customFont(font: .roboto, style: .regular, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .cDark
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        configureCancelButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureCancelButton() {
        cancelBtn.addTarget(self, action: #selector(buttonHighlighted), for: [.touchDown, .touchDragInside])
        cancelBtn.addTarget(self, action: #selector(buttonUnhighlighted), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }

    @objc private func buttonHighlighted() {
        cancelBtn.layer.borderWidth = 2 // Увеличиваем ширину границы при нажатии
    }

    @objc private func buttonUnhighlighted() {
        cancelBtn.layer.borderWidth = 1 // Возвращаем к стандартной ширине
    }

    private func setupUI() {
        self.backgroundColor = .cBg
        [firstView, cancelBtn, sendBtn, chooseLabel, lastDataLabel, dataLabel, secondView] .forEach(addSubview(_:))
        firstView.addSubview(oneLabel)
        firstView.addSubview(lonLabel)
        firstView.addSubview(latLabel)
        firstView.addSubview(textFieldLon)
        firstView.addSubview(textFieldLat)
        
        firstView.addSubview(errorlatLabel)
        firstView.addSubview(errorlonLabel)

        secondView.addSubview(weatherLabel)
        
        secondView.addSubview(temperaturesLabel)
        secondView.addSubview(iconTempIV)
        secondView.addSubview(countTempLabel)
        
        secondView.addSubview(dewPointsLabel)
        secondView.addSubview(iconDevIV)
        secondView.addSubview(countDevLabel)
        
        secondView.addSubview(pressureLabel)
        secondView.addSubview(iconPresIV)
        secondView.addSubview(countPresLabel)
        
        secondView.addSubview(humidityLabel)
        secondView.addSubview(iconHumIV)
        secondView.addSubview(countHumLabel)
        
    }
    
    private func setupConstraints() {
        
        firstView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(332)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(16)
        }
        
        lonLabel.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(28)
            make.left.equalToSuperview().offset(16)
        }
        
        textFieldLon.snp.makeConstraints { make in
            make.top.equalTo(lonLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        errorlonLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldLon.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
        }
        
        latLabel.snp.makeConstraints { make in
            make.top.equalTo(lonLabel.snp.bottom).offset(76)
            make.left.equalToSuperview().offset(16)
        }
        
        textFieldLat.snp.makeConstraints { make in
            make.top.equalTo(latLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        errorlatLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldLat.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(textFieldLat.snp.centerX).offset(-8)
            make.top.equalTo(textFieldLat.snp.bottom).offset(32)
            make.width.equalTo(148)
            make.height.equalTo(44)
        }
        
        sendBtn.snp.makeConstraints { make in
            make.left.equalTo(textFieldLat.snp.centerX).offset(8)
            make.top.equalTo(textFieldLat.snp.bottom).offset(32)
            make.width.equalTo(148)
            make.height.equalTo(44)
        }
        
        chooseLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstView.snp.bottom).offset(48)
        }
        
        lastDataLabel.snp.makeConstraints { make in
            make.top.equalTo(firstView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(firstView.snp.bottom).offset(24)
            make.right.equalToSuperview().offset(-16)
        }
        
        secondView.snp.makeConstraints { make in
            make.top.equalTo(lastDataLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(194)
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(16)
        }
        
        temperaturesLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(weatherLabel.snp.bottom).offset(32)
        }
        
        iconTempIV.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(temperaturesLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
        }
        
        countTempLabel.snp.makeConstraints { make in
            make.left.equalTo(iconTempIV.snp.right).offset(8)
            make.centerY.equalTo(iconTempIV)
        }
        
        dewPointsLabel.snp.makeConstraints { make in
            make.left.equalTo(secondView.snp.centerX).offset(8)
            make.top.equalTo(weatherLabel.snp.bottom).offset(32)
        }
        
        iconDevIV.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(dewPointsLabel.snp.bottom).offset(4)
            make.left.equalTo(secondView.snp.centerX).offset(8)
        }
        
        countDevLabel.snp.makeConstraints { make in
            make.left.equalTo(iconDevIV.snp.right).offset(8)
            make.centerY.equalTo(iconDevIV)
        }
        
        pressureLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(iconTempIV.snp.bottom).offset(20)
        }
        
        iconPresIV.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(pressureLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
        }
        
        countPresLabel.snp.makeConstraints { make in
            make.left.equalTo(iconPresIV.snp.right).offset(8)
            make.centerY.equalTo(iconPresIV)
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.left.equalTo(secondView.snp.centerX).offset(8)
            make.top.equalTo(iconTempIV.snp.bottom).offset(20)
        }
        
        iconHumIV.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(humidityLabel.snp.bottom).offset(4)
            make.left.equalTo(secondView.snp.centerX).offset(8)
        }
        
        countHumLabel.snp.makeConstraints { make in
            make.left.equalTo(iconHumIV.snp.right).offset(8)
            make.centerY.equalTo(iconHumIV)
        }
    }
    
    // MARK: - UITextFieldDelegate
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Разрешенные символы
            let allowedCharacters = CharacterSet(charactersIn: "0123456789.-,")
            let characterSet = CharacterSet(charactersIn: string)
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
            
            // Заменить запятую на точку
            if string == "," {
                if let text = textField.text {
                    textField.text = text + "."
                }
                return false
            }
            
            // Убедиться, что точка присутствует только одна
            if string == "." {
                if let text = textField.text, text.contains(".") {
                    return false
                }
            }
            
            // Убедиться, что знак минус только в начале строки
            if string == "-" {
                if let text = textField.text, !text.isEmpty {
                    return false
                }
            }
            
            return true
        }
           
    // MARK: - UITextFieldDelegate
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.layer.borderColor = UIColor.cDarkBlue.cgColor
            if textField == textFieldLat {
                textFieldLon.layer.borderColor = UIColor.cGrey.cgColor
            } else if textField == textFieldLon {
                textFieldLat.layer.borderColor = UIColor.cGrey.cgColor
            }
        }
        
}

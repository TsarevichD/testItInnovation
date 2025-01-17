//
//  WeatherVC.swift

import Foundation
import UIKit
import SnapKit

class WeatherVC: UIViewController {
    
    private var lon = Double()
    private var lat = Double()
    private var apiKey = "dea03e5c5bd3208545c0a5a99c58241e"
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private var contentView: WeatherView {
        view as? WeatherView ?? WeatherView()
    }
    
    override func loadView() {
        view = WeatherView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapBtn()
        configureTextFields()
        configureBtn()
        setupActivityIndicator()
    }
    
    private func tapBtn() {
        contentView.sendBtn.addTarget(self, action: #selector(sendService), for: .touchUpInside)
        contentView.cancelBtn.addTarget(self, action: #selector(hiddenWeather), for: .touchUpInside)
    }
    
    private func configureTextFields() {
        contentView.textFieldLat.delegate = self
        contentView.textFieldLon.delegate = self

        let tapLatGesture = UITapGestureRecognizer(target: self, action: #selector(handleLatTap))
        contentView.textFieldLat.addGestureRecognizer(tapLatGesture)
        
        let tapLonGesture = UITapGestureRecognizer(target: self, action: #selector(handleLonTap))
        contentView.textFieldLon.addGestureRecognizer(tapLonGesture)

        contentView.textFieldLat.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        contentView.textFieldLon.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        updateCancelButtonState()
    }

    @objc private func showKeyboard(for textField: UITextField) {
        textField.becomeFirstResponder()
    }

    @objc private func handleLatTap() {
        showKeyboard(for: contentView.textFieldLat)
    }

    @objc private func handleLonTap() {
        showKeyboard(for: contentView.textFieldLon)
    }

    @objc private func textFieldDidChange() {
        updateCancelButtonState()
        
    }
    
    private func configureBtn() {
        contentView.sendBtn.isEnabled = false
        contentView.sendBtn.alpha = 0.5
        
    }
    
    
    private func setupActivityIndicator() {
        activityIndicator.color = .cBlue
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc func sendService() {
        view.endEditing(true)
        fetchWeatherData()
        openWeather()
    }
    
    @objc func hiddenWeather() {
        contentView.textFieldLon.text = ""
        contentView.textFieldLat.text = ""
        closeWeather()
        contentView.cancelBtn.isEnabled = false
        contentView.cancelBtn.alpha = 0.5
        contentView.textFieldLat.layer.borderColor = UIColor.cGrey.cgColor
        contentView.textFieldLon.layer.borderColor = UIColor.cGrey.cgColor
        contentView.latLabel.textColor = .cBlue
        contentView.lonLabel.textColor = .cBlue
        
    }
    
    private func fetchWeatherData() {
          guard
              let latText = contentView.textFieldLat.text,
              let lonText = contentView.textFieldLon.text,
              let lat = Double(latText),
              let lon = Double(lonText)
          else {
              print("Ошибка: некорректные координаты")
              return
          }
          
          activityIndicator.startAnimating() // Показываем лоадер перед запросом
          
          let weatherService = WeatherService()
          weatherService.fetchWeather(lat: lat, lon: lon) { [weak self] result in
              DispatchQueue.main.async {
                  self?.activityIndicator.stopAnimating() // Останавливаем лоадер после завершения запроса
              }
              switch result {
              case .success(let weather):
                  print("Данные о погоде: \(weather)")
                  self?.updateWeatherView(with: weather)
                  self?.updateLastRequestDate()
              case .failure(let error):
                  print("Ошибка загрузки погоды: \(error.localizedDescription)")
                  self?.showErrorAlert(message: "Немає доступу до сервера. Спробуйте пізніше.")
              }
          }
      }
      
      private func updateWeatherView(with weather: WeatherResponse) {
          DispatchQueue.main.async {
              let roundedTemp = Int(round(weather.main.temp))
              let fellsTemp = Int(round(weather.main.feelsLike))
              
              self.contentView.countTempLabel.text = "\(roundedTemp)°C"
              self.contentView.countDevLabel.text = "\(fellsTemp)°C"
              self.contentView.countPresLabel.text = "\(weather.main.pressure) мм рт. ст."
              self.contentView.countHumLabel.text = "\(weather.main.humidity)%"
          }
      }
      
      private func updateLastRequestDate() {
          let formatter = DateFormatter()
          formatter.dateFormat = "dd.MM.yyyy HH:mm"
          let currentDate = Date()
          let formattedDate = formatter.string(from: currentDate)
          
          DispatchQueue.main.async {
              self.contentView.dataLabel.text = formattedDate
          }
      }
      
      private func showErrorAlert(message: String) {
          DispatchQueue.main.async {
              let alertController = UIAlertController(title: "Помилка", message: message, preferredStyle: .alert)
              let okAction = UIAlertAction(title: "ОК", style: .default)
              alertController.addAction(okAction)
              self.present(alertController, animated: true)
          }
      }
    
    private func openWeather() {
        contentView.chooseLabel.isHidden = true
        contentView.lastDataLabel.isHidden = false
        contentView.dataLabel.isHidden = false
        contentView.secondView.isHidden = false
    }
    
    private func closeWeather() {
        contentView.chooseLabel.isHidden = false
        contentView.lastDataLabel.isHidden = true
        contentView.dataLabel.isHidden = true
        contentView.secondView.isHidden = true
    }
    
    private func updateCancelButtonState() {
        let latText = contentView.textFieldLat.text ?? ""
        let lonText = contentView.textFieldLon.text ?? ""
        
        let isLatEntered = !latText.isEmpty
        let isLonEntered = !lonText.isEmpty
        
        if isLatEntered {
            if isValidLatitude(latText) {
                contentView.textFieldLat.layer.borderColor = UIColor.cBlue.cgColor
                contentView.latLabel.textColor = .cBlue
                contentView.errorlatLabel.isHidden = true
                
            } else {
                contentView.textFieldLat.layer.borderColor = UIColor.cRed.cgColor
                contentView.latLabel.textColor = .cRed
                contentView.errorlatLabel.isHidden = false
            }
        } else {
            contentView.textFieldLat.layer.borderColor = UIColor.cGrey.cgColor
            contentView.latLabel.textColor = .cBlue
            contentView.errorlatLabel.isHidden = true
        }
        
        if isLonEntered {
            if isValidLongitude(lonText) {
                contentView.textFieldLon.layer.borderColor = UIColor.cBlue.cgColor
                contentView.lonLabel.textColor = .cBlue
                contentView.errorlonLabel.isHidden = true
            } else {
                contentView.textFieldLon.layer.borderColor = UIColor.cRed.cgColor
                contentView.lonLabel.textColor = .cRed
                contentView.errorlonLabel.isHidden = false
                
            }
        } else {
            // Если поле пустое, сбрасываем цвет
            contentView.textFieldLon.layer.borderColor = UIColor.cGrey.cgColor
            contentView.lonLabel.textColor = .cBlue
            contentView.errorlonLabel.isHidden = true
        }
        
        // Обновляем состояние cancelBtn
        if !isLatEntered && !isLonEntered {
            contentView.cancelBtn.isEnabled = false
            contentView.cancelBtn.alpha = 0.5
        } else {
            contentView.cancelBtn.isEnabled = true
            contentView.cancelBtn.alpha = 1.0
        }
        
        // Проверяем, валидны ли оба поля для sendBtn
        if isLatEntered && isLonEntered && isValidLatitude(latText) && isValidLongitude(lonText) {
            contentView.sendBtn.isEnabled = true
            contentView.sendBtn.alpha = 1
        } else {
            contentView.sendBtn.isEnabled = false
            contentView.sendBtn.alpha = 0.5
        }
    }
}

extension WeatherVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == contentView.textFieldLat {
            if isValidLatitude(textField.text) {
                contentView.textFieldLat.layer.borderColor = UIColor.cBlue.cgColor
                contentView.latLabel.textColor = .cBlue
            } else {
                contentView.textFieldLat.layer.borderColor = UIColor.cRed.cgColor
                contentView.latLabel.textColor = .cRed
            }
        } else if textField == contentView.textFieldLon {
            if isValidLongitude(textField.text) {
                contentView.textFieldLon.layer.borderColor = UIColor.cBlue.cgColor
                contentView.lonLabel.textColor = .cBlue
            } else {
                contentView.textFieldLon.layer.borderColor = UIColor.cRed.cgColor
                contentView.lonLabel.textColor = .cRed
            }
        }
    }

    private func isValidLatitude(_ text: String?) -> Bool {
        guard let text = text, let value = Double(text) else { return false }
        return value >= -90 && value <= 90
    }
    
    private func isValidLongitude(_ text: String?) -> Bool {
        guard let text = text, let value = Double(text) else { return false }
        return value >= -180 && value <= 180
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.-,")
        let characterSet = CharacterSet(charactersIn: string)
        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }
        if string == "," {
            if let text = textField.text {
                textField.text = text + "."
            }
            return false
        }
        if string == "." {
            if let text = textField.text, text.contains(".") {
                return false
            }
        }
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
        
    }
}

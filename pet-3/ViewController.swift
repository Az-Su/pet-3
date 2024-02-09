//
//  ViewController.swift
//  pet-3
//
//  Created by Sailau Almaz Maratuly on 08.02.2024.
//

import UIKit

class ViewController: UIViewController {
    var rectPointY: Int = 100
    var rectSize: CGFloat = 50.0
    var rectPadding: Int = 20
    var maxRectScale: CGFloat = 0.0
    var endPoint: CGFloat = UIScreen.main.bounds.width
    var rawRectXCoordinate: CGFloat = 0.0
    
    let rectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var slider: UISlider = {
        let view = UISlider()
        view.value = 0
        view.minimumValue = 0
        view.maximumValue = 1
        view.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        view.addTarget(self, action: #selector(sliderReleased(_:)), for: .touchUpInside)
        view.addTarget(self, action: #selector(sliderReleased(_:)), for: .touchUpOutside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(slider)
        view.addSubview(rectangle)
        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        rectangle.frame.origin.x = CGFloat(rectPadding)
        rectangle.frame.origin.y = CGFloat(rectPointY)
        rectangle.frame.size = CGSize(width: rectSize, height: rectSize)
        maxRectScale = rectSize * 0.5
        rawRectXCoordinate = endPoint-rectSize-CGFloat(rectPadding*2)-maxRectScale
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let scale = 1 + 0.5 * value
        let temp = view.bounds.width - (rectSize*scale)-CGFloat(rectPadding*2)
        UIView.animate(withDuration: 0.3) {
            self.rectangle.frame.origin.x = temp*value + CGFloat(self.rectPadding)
            self.rectangle.bounds.size = CGSize(width: self.rectSize*scale, height: self.rectSize*scale)
            self.rectangle.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2 * value)
        }

    }
    
    @objc func sliderReleased(_ sender: UISlider) {
        sender.setValue(1, animated: true)
        let value = CGFloat(sender.value)
        let temp = self.view.bounds.width - (self.rectSize*1.5)-CGFloat(self.rectPadding*2)

        UIView.animate(withDuration: 0.5) {
            self.rectangle.frame.origin.x = temp*value + CGFloat(self.rectPadding)
            self.rectangle.bounds.size = CGSize(width: self.rectSize*1.5, height: self.rectSize*1.5)
            self.rectangle.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2 * value)
        }
        
    }
}

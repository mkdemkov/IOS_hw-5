//
//  ColorPaletteView.swift
//  mkdemkov-3
//
//  Created by Михаил Демков on 31.10.2022.
//

import Foundation
import UIKit

final class ColorPaletteView: UIControl {
    private let stackView = UIStackView()
    private(set) var chosenColor: UIColor = .systemGray6
    init() {
        super.init(frame: .zero)
        setupView()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        let redControl = ColorSliderView(colorName: "R", value: Float(chosenColor.rgba.red)) // mb gg
        let greenControl = ColorSliderView(colorName: "G", value: Float(chosenColor.rgba.green)) // mb gg
        let blueControl = ColorSliderView(colorName: "B", value: Float(chosenColor.rgba.blue)) // mb gg
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        
        [redControl, greenControl, blueControl].forEach {
            $0.addTarget(self, action: #selector(sliderMoved(slider:)), for: .touchDragInside)
        }
        addSubview(stackView)
        stackView.pin(to: self, [.left: 12, .right: 12, .top: 12, .bottom: 12])
    }
    
    @objc
    private func sliderMoved(slider: ColorSliderView) {
        switch slider.tag { case 0:
            self.chosenColor = UIColor(
                red: CGFloat(slider.value),
                green: chosenColor.rgba.green, blue: chosenColor.rgba.blue, alpha: chosenColor.rgba.alpha
            ) case 1:
            self.chosenColor = UIColor(
                red: chosenColor.rgba.red, green: CGFloat(slider.value), blue: chosenColor.rgba.blue, alpha: chosenColor.rgba.alpha
            ) default:
            self.chosenColor = UIColor(
                red: chosenColor.rgba.red, green: chosenColor.rgba.green, blue: CGFloat(slider.value), alpha: chosenColor.rgba.alpha
            ) }
        sendActions(for: .touchDragInside)
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

extension ColorPaletteView {
    private final class ColorSliderView: UIControl {
        private let slider = UISlider()
        private let colorLabel = UILabel()
        
        private(set) var value: Float
        
        init(colorName: String, value: Float) {
            self.value = value
            super.init(frame: .zero)
            
            slider.value = value
            colorLabel.text = colorName
            setupView()
            slider.addTarget(self, action: #selector(sliderMoved(_:)), for: .touchDragInside)
        }
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupView() {
            let stackView = UIStackView(arrangedSubviews: [colorLabel, slider])
            stackView.axis = .horizontal
            stackView.spacing = 8
            
            addSubview(stackView)
            stackView.pin(to: self, [.left: 12, .right: 12, .top: 12, .bottom: 12])
        }
        @objc
        private func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            sendActions(for: .touchDragInside)
        }
    }
}


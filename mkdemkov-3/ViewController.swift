//
//  ViewController.swift
//  mkdemkov_3
//
//  Created by Михаил Демков on 31.10.2022.
//

import UIKit

extension CALayer {
    func applyShadow() {
        self.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 180)
        self.shadowOpacity = 0.8
        self.shadowRadius = 12
        self.shadowOffset = CGSize(width: 0, height: 0)
    }
}

class ViewController: UIViewController {
    
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private var value = 0
    private let incrementButton = UIButton()
    let commentView = UIView()
    let generator = UIImpactFeedbackGenerator(style: .light)
    let colorPaletteView = ColorPaletteView()
    var buttonsSV = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        colorPaletteView.isHidden = true
        
        setupIncrementButton()
        setupValueLabel()
        setupMenuButtons()
        setupCommentView()
        setupColorControlSV()
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.applyShadow()
        
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.setHeight(Int(self.view.frame.size.height / 20))
        valueLabel.pinBottom(to: self.view, Int(self.view.frame.size.height / 2 + incrementButton.frame.size.height + 10))
        valueLabel.pinCenter(to: self.view)
    }
    
    @objc
    func incrementButtonPressed() {
        value += 1
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        UIView.animate(withDuration: 0.07, delay: 0, options: .curveEaseInOut, animations: {
            self.incrementButton.layer.position.y -= 4
        }, completion: {_ in })
        
        UIView.animate(withDuration: 1) {
            self.updateUI()
        }
        generator.prepare()
        generator.impactOccurred()
    }
    
    @objc
    func showNotesController() {
        let notesViewController = NotesViewController()
        self.navigationController?.pushViewController(notesViewController, animated: true)
    }
    
    func updateUI() {
        updateCommentLabel(value: value)
        updateValueLabel()
    }
    
    func updateValueLabel() {
        valueLabel.text = String(value)
    }
    
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "! ! ! ! ! ! ! ! ! "
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐"
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }
    
    private func setupCommentView() {
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        commentView.pinTop(to:
                            self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top: 16, .left: 16, .bottom: 16, .right: 16])
    }
    
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
        let notesButton = makeMenuButton(title: "📝")
        notesButton.addTarget(self, action: #selector(showNotesController), for: .touchUpInside)
        let newsButton = makeMenuButton(title: "📰")
        buttonsSV.addArrangedSubview(colorsButton)
        buttonsSV.addArrangedSubview(notesButton)
        buttonsSV.addArrangedSubview(newsButton)
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        self.view.addSubview(buttonsSV)
        buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to: self.view, 24)
    }
    
    private func setupColorControlSV() {
        view.addSubview(colorPaletteView)
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        colorPaletteView.pinTop(to: incrementButton.bottomAnchor, 8)
        colorPaletteView.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 12)
        colorPaletteView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 12)
        colorPaletteView.pinBottom(to: buttonsSV.topAnchor, 8)
        colorPaletteView.addTarget(self, action: #selector(changeColor), for: .touchDragInside)
    }
    
    
    
    @objc
    private func changeColor() {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = self.colorPaletteView.chosenColor
        }
    }
    
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    
    //    @objc
    //    private func changeColor() {
    //        UIView.animate(withDuration: 0.5) {
    //            self.view.backgroundColor = self.colorPaletteView.chosenColor
    //        }
    //    }
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
}

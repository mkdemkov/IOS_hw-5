//
//  AddNoteCell.swift
//  mkdemkov-3
//
//  Created by Михаил Демков on 22.11.2022.
//
import Foundation
import UIKit

final class AddNoteCell: UITableViewCell, UITextViewDelegate {
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var delegate: AddNoteDelegate?
    public var addButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupView()
    }
    
    // стековерфлоу
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        textView.text = "Enter your note"
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.backgroundColor = .clear
        textView.setHeight(140)
        textView.delegate = self
        addButton.setTitle("Add Note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(44)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)),
        for: .touchUpInside)
        addButton.isEnabled = false
        addButton.alpha = 0.5
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray5
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .tertiaryLabel {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        delegate?.newNoteAdded(note: ShortNote(text: textView.text))
        textView.text = ""
        addButton.isEnabled = false
        addButton.backgroundColor = .label
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter your note"
            textView.textColor = .tertiaryLabel
            addButton.isEnabled = false
            addButton.backgroundColor = .label
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            addButton.isEnabled = false
            addButton.backgroundColor = .label
        } else {
            addButton.isEnabled = true
            addButton.backgroundColor = .blue
        }
    }

}

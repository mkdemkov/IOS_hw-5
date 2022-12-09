//
//  NoteCell.swift
//  mkdemkov-3
//
//  Created by Михаил Демков on 22.11.2022.
//
import Foundation
import UIKit

final class NoteCell: UITableViewCell {
    
    public static let reuseIdentifier = "NoteCell"
    private var textlabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    // я не понял зачем это нужно, но компилятор ругался на его отсутствие. Нашел на стековерфлоу
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        textlabel.font = .systemFont(ofSize: 16, weight: .regular)
        textlabel.textColor = .label
        textlabel.numberOfLines = 0
        textlabel.backgroundColor = .clear
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(textlabel)
        textlabel.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
    }
        
    public func configure(_ note: ShortNote) {
        textlabel.text = note.text
    }
}

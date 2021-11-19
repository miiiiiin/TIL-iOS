//
//  ViewController.swift
//  DelaysContentTouchesSample
//
//  Created by Running Raccoon on 2021/11/19.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: UIScreen.main.bounds)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
//        view.delaysContentTouches = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemBackground
        return view
    }()
    
    lazy var inputTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "입력해주세요"
        tf.textColor = .white
        tf.font = .systemFont(ofSize: 14)
        tf.clearButtonMode = .whileEditing
        tf.contentVerticalAlignment = .center
        tf.layer.cornerRadius = 5
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.white.cgColor
        return tf
    }()
    
    let disposeBag = DisposeBag()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [inputTextField].forEach(contentView.addSubview(_:))
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.equalTo(view.snp.leadingMargin)
            make.trailing.equalTo(view.snp.trailingMargin)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }
        
        textFIeldHandler()
    }
    
    func textFIeldHandler() {
        
        inputTextField.rx.controlEvent(.touchDown)
            .bind { [unowned self] _ in
                inputTextField.layer.borderColor = UIColor.red.cgColor
            }
            .disposed(by: disposeBag)
        
        inputTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [unowned self] _ in
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = contentView.frame.size
    }
}

extension ViewController: UIScrollViewDelegate {}

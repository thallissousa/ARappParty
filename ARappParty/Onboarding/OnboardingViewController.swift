//
//  OnboardingViewController.swift
//  ARappParty
//
//  Created by Thallis Sousa on 09/06/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var comoUsar: UILabel!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelSubtitulo: UILabel!
    @IBOutlet weak var onboardingImage: UIImageView!
    @IBOutlet weak var comecarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255, green: 249, blue: 242, alpha: 1)
        
        comoUsar.textColor = .black
        comoUsar.text = "Como usar"
        comoUsar.textAlignment = .center
        comoUsar.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        view.addSubview(comoUsar)
        
        
        labelTitulo.textColor = .darkGray
        labelTitulo.text = "Apenas aponte a câmera para seu rosto, faça sua melhor pose"
        labelTitulo.textAlignment = .center
        labelTitulo.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        view.addSubview(labelTitulo)
        
        labelSubtitulo.textColor = .darkGray
        labelSubtitulo.text = "e comece a festejar!"
        labelSubtitulo.textAlignment = .center
        labelSubtitulo.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        view.addSubview(labelSubtitulo)
    
        
        comecarButton.layer.cornerRadius = 8
        comecarButton.tintColor = .black
        comecarButton.setTitle("Começar", for: .normal)
        comecarButton.frame.size = CGSize(width: 230, height: 60)
        comecarButton.backgroundColor = UIColor(named: "laranjinha")

        
        view.addSubview(comecarButton)
        view.addSubview(onboardingImage)
        setupOnboardingConstraints()
    }
    
    @IBAction func comecarButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "viewController") as? ViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func setupOnboardingConstraints() {
        comoUsar.translatesAutoresizingMaskIntoConstraints = false
        let labelTituloConstraints:[NSLayoutConstraint] = [
            comoUsar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            comoUsar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            comoUsar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(labelTituloConstraints)
        
        //
        labelTitulo.translatesAutoresizingMaskIntoConstraints = false
        let labelConstraints:[NSLayoutConstraint] = [
            labelTitulo.topAnchor.constraint(equalTo: comoUsar.bottomAnchor,constant: 30),
            labelTitulo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            labelTitulo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(labelConstraints)
        
        //
        onboardingImage.contentMode = .scaleAspectFit
        onboardingImage.translatesAutoresizingMaskIntoConstraints = false
        let imgConstrainsts:[NSLayoutConstraint] = [
            onboardingImage.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 250),
            onboardingImage.heightAnchor.constraint(equalToConstant: 300),
            onboardingImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            onboardingImage.topAnchor.constraint(equalTo: labelTitulo.bottomAnchor, constant: 50)
        ]
        NSLayoutConstraint.activate(imgConstrainsts)

        //
        labelSubtitulo.translatesAutoresizingMaskIntoConstraints = false
        let labelSubtituloConstraints:[NSLayoutConstraint] = [
            labelSubtitulo.topAnchor.constraint(equalTo: onboardingImage.bottomAnchor,constant: 30),
            labelSubtitulo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            labelSubtitulo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(labelSubtituloConstraints)
        
        //
        
        comecarButton.translatesAutoresizingMaskIntoConstraints = false
        let comecarBotaoConstraints: [NSLayoutConstraint] = [
            comecarButton.topAnchor.constraint(equalTo: labelSubtitulo.bottomAnchor, constant: 50),
            comecarButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -120),
            comecarButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80),
            comecarButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -80)
        ]
        NSLayoutConstraint.activate(comecarBotaoConstraints)
    }
}

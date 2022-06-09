//
//  ViewController.swift
//  ARApp
//
//  Created by Thallis Sousa on 02/06/22.
//

import UIKit
import ARKit
//import SceneKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var myLabel: UILabel!
    let fogueirinhaImage = UIImage(named: "fogueirinha")
    let bandeirinhaImage = UIImage(named: "bandeirinha")

    
    @IBAction func takePhotoButton(_ sender: Any) {
//        let image = sceneView.snapshot()
        let image = self.view.takeScreenshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        myLabel.text = "Salvo!"
        myLabel.backgroundColor = .red
    
            myLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.myLabel.isHidden = true
            }
    }
    
    @IBOutlet var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        let fogueirinhaImageView = UIImageView(image: fogueirinhaImage)
        fogueirinhaImageView.frame = CGRect(x: 0.03,
                                            y: 600,
                                            width: 227/1.5,
                                            height: 191/1.5)
        
        let bandeirinhaImageView = UIImageView(image: bandeirinhaImage)
        bandeirinhaImageView.frame = CGRect(x: -0.03 ,
                                            y: -40,
                                            width: 647/1.5,
                                            height: 329/1.5)

        
        
        
        view.addSubview(fogueirinhaImageView)
        view.addSubview(bandeirinhaImageView)
        
        guard ARFaceTrackingConfiguration.isSupported
        else {
            fatalError("Dispositivo não suportado.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARFaceTrackingConfiguration()
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    //MARK: - Renderizar a região do rosto com os nós
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        if let device = sceneView.device {
            let faceMeshGeometry = ARSCNFaceGeometry(device: device)
            let node = SCNNode(geometry: faceMeshGeometry)
            node.geometry?.firstMaterial?.fillMode = .lines
            node.geometry?.firstMaterial?.transparency = 0.0
            
//            ambientObjects().forEach({node.addChildNode($0)})
            node.addChildNode(createHat())
            
            return node
            
        } else {
            fatalError("Nenhum dispositivo encontrado.")
        }
    }
    
    //MARK: - Dando update
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry {
            faceGeometry.update(from: faceAnchor.geometry)
        }
    }
    
    func  createHat() -> SCNNode {
        
        //adicionar um node com imagem acima do node ja existe
        let hat = SCNNode(geometry: SCNPlane(width: 0.2,
                                             height: 0.1))
        hat.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "caipiraHat")
        hat.name = "Chapéu de caipira"
        hat.position = SCNVector3(x: 0.0,
                                  y: 0.13,
                                  z: 0.0)
        
        return hat
        }
    
    
//    func ambientObjects() -> [SCNNode] {
//
//        //MARK: - Festa junina
//        let bandeirinha = SCNNode(geometry: SCNPlane(width: 0.25,
//                                                     height: 0.15))
//        bandeirinha.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "bandeirinha")
//        bandeirinha.name = "Bandeirinha junina"
//        bandeirinha.position = SCNVector3(x: 0.0,
//                                          y: 0.25,
//                                          z: 0.0)
//
//
//        let fogueirinha = SKSpriteNode(imageNamed: "fogueirinha")
////        fogueirinha.frame = CGRect(x: 0, y: 0, width: 0.15, height: 0.15)
//        fogueirinha.position = CGPoint(x: 0, y: 0)
//        fogueirinha.size = CGSize(width: 200, height: 200)
//
////        sceneView.overlaySKScene = SKScene(size: CGSize(width: 500, height: 500))
//        sceneView.overlaySKScene?.size = CGSize(width: 500, height: 500)
//
//
//        sceneView.overlaySKScene?.addChild(fogueirinha)
//
//        return [bandeirinha]
//    }
}

extension UIView {

    func takeScreenshot() -> UIImage {

        // Pega o contexto inicial da cena
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Desenha a view que está inserida nesse contexto
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // Pega a imagem
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        //Caso a imagem não seja nula, retorna a imagem (image!)
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}

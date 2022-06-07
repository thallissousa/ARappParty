//
//  ViewController.swift
//  ARApp
//
//  Created by Thallis Sousa on 02/06/22.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController, ARSCNViewDelegate {
    let bandeirinhaScenario = "bandeirinha.png"
    let fogueirinhaScenario = "fogueirinha"
    let bandeirinhaImage = UIImage(named: "bandeirinha")
    let fogueirinhaImage = UIImage(named: "fogueirinha")
    
    
    @IBAction func takePhotoButton(_ sender: Any) {
        let image = sceneView.snapshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    @IBOutlet var sceneView: ARSCNView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let bandeirinhaImageView = UIImageView(image: bandeirinhaImage)
        bandeirinhaImageView.frame = CGRect(x: 0, y: 0, width: 329, height: 155)
        
        
        let bandeirinhaImageView2 = UIImageView(image: bandeirinhaImage)
        bandeirinhaImageView2.frame = CGRect(x: 0, y: 0, width: 329, height: 155)
        
        
        let fogueirinhaImageView = UIImageView(image: fogueirinhaImage)
        fogueirinhaImageView.frame = CGRect(x: 0.03, y: 600, width: 227, height: 191)
        
        self.view.addSubview(bandeirinhaImageView)
        self.view.addSubview(fogueirinhaImageView)
        sceneView.delegate = self
        
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
    
    var appActive = false {
        didSet {
            UIApplication.shared.isIdleTimerDisabled = self.appActive
        }
    }
    
    //MARK: - Renderizar a região do rosto com os nós
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        if let device = sceneView.device {
            let faceMeshGeometry = ARSCNFaceGeometry(device: device)
            let node = SCNNode(geometry: faceMeshGeometry)
            node.geometry?.firstMaterial?.fillMode = .lines
            node.geometry?.firstMaterial?.transparency = 0.0
            
            //adicionar um node com imagem acima do node ja existe
            let image = UIImage(named: "caipiraHat")
            let hat = SCNNode(geometry: SCNPlane(width: 0.2, height: 0.1))
            hat.geometry?.firstMaterial?.diffuse.contents = image
            hat.position = SCNVector3(x: 0.0, y: 0.13, z: 0.0)
            node.addChildNode(hat)
            
            
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
}

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
    let imageName = "bandeirinha.png"
    let image = UIImage(named: "bandeirinha")

    @IBOutlet var sceneView: ARSCNView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        
        self.view.addSubview(imageView)
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
    
    //Renderizar a região do rosto com os nós
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
            
//            let image2 = UIImage(named: "fogueirinha")
//            let fogueirinha = SCNNode(geometry: SCNPlane(width: 0.2, height: 0.16))
//            fogueirinha.geometry?.firstMaterial?.diffuse.contents = image2
//            fogueirinha.position = SCNVector3(x: -0.00, y: -0.3, z: 0.0)
//            node.addChildNode(fogueirinha)
//
//            let image3 = UIImage(named: "bandeirinha")
//            let bandeirinhaLeft = SCNNode(geometry: SCNPlane(width: 0.2, height: 0.16))
//            bandeirinhaLeft.geometry?.firstMaterial?.diffuse.contents = image3
//            bandeirinhaLeft.position = SCNVector3(x: -0.1, y: 0.25, z: 0.0)
//            node.addChildNode(bandeirinhaLeft)
//
//            let image4 = UIImage(named: "bandeirinha")
//            let bandeirinhaRight = SCNNode(geometry: SCNPlane(width: 0.2, height: 0.16))
//            bandeirinhaRight.geometry?.firstMaterial?.diffuse.contents = image4
//            bandeirinhaRight.position = SCNVector3(x: 0.1, y: 0.25, z: 0.0)
//            node.addChildNode(bandeirinhaRight)
//
            return node
        } else {
            fatalError("Nenhum dispositivo encontrado.")
        }
    }
    
    //Renderizando e dando update
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry {
            faceGeometry.update(from: faceAnchor.geometry)
            }
    }
}


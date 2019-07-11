//
//  ViewController.swift
//  Merlin
//
//  Created by Salvador Martí Solsona on 08/07/2019.
//  Copyright © 2019 Salvador Martí Solsona. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //Definición de variables - atributos
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appSubTitle: UILabel!
    @IBOutlet weak var appQuestion: UILabel!
    @IBOutlet weak var askButton: UIButton!
    @IBOutlet weak var emoji: UIImageView!
    
    //Variables inmutables (let) y sin inicializar. Hay que hacerlo en el required init?
    
    //Todas las posibles contestaciones afirmativas de Merlín en un [String]
    let respSi : [String]
    //Todas las posibles contestaciones negativas de Merlín en un [String]
    let respNo : [String]
    //Todas las posibles contestaciones ambiguas de Merlín en un [String]
    let respMaybe: [String]
    
    //Variable para almacenar la longitud final del los [String] (.count)
    let nRespSi : UInt32
    let nRespNo : UInt32
    let nRespMaybe : UInt32
    //--------------------------------------------------------------------
    
    //Siempre tendremos 3 Tipos de respuestas (SI,NO,QUIZAS)
    let tipoRespuestas : UInt32 = 3
    //--------------------------------------------------------------------
    
    // Variables mutables (int) y inicializadas.
    var randomAnswer : Int = 0
    
    //Funcionalidad que necesitamos al arrancar la app
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //Muy importante este init. Es como el constructor en JAVA.
    required init?(coder aDecoder: NSCoder) {
        //volver a acostumbrarme a utilizar el prefijo self. para las variables
        self.respSi = ["Si", "Seguro", "Pasará", "Muy probable"]
        self.respNo = ["No", "Complicado", "Dificil", "Imposible", "Olvídate"]
        self.respMaybe = ["Es posible", "No creo", "Tal vez si", "Tal vez no"]
        
        // el método .count devuelve el tamaño del vector
        self.nRespSi = UInt32(self.respSi.count)
        self.nRespNo = UInt32(self.respNo.count)
        self.nRespMaybe = UInt32(self.respMaybe.count)
        
        //acabamos el método llamando a método padre. (siempre igual)
        super.init(coder: aDecoder)
    }
    
    
    //Funciones del controller
    
    // Creo la función con la forma estándar para acostumbrarme pero podría obviar el -> void
    func generarRespuestaMagica() -> Void {
        
        //func arc4random_uniform -> funcion para generar números aleatorios.
        //Cuidado porque devuelve un UInt32, necesario casting a INT
        
        // Set Si, Set No ó Set Mayby
        self.randomAnswer = Int(arc4random_uniform(tipoRespuestas))
        
        // Si Merlín dice SI
        if (self.randomAnswer == 0) {
            
            //Hacemos un random del vector de posibles contestaciones positivas
            self.randomAnswer = Int(arc4random_uniform(self.nRespSi))
            //Cambiamos por el emoji LIKE
            self.emoji.image = UIImage(named: "like")
            //Actualizamos la UILabel por la respuesta
            self.appQuestion.text = self.respSi[self.randomAnswer]
            
            //Animación para el cambio de emoji, efecto aumento de la imagen con Transform > 1
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: UIView.AnimationOptions.curveEaseOut,
                animations: {
                    
                    self.emoji.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
                    
            }) { (completed) in
                //Volvemos la imagen al estado inicial (.identity)
                self.emoji.transform = CGAffineTransform.identity
                
            }

        }
        //Si Merlín dice NO
        else if (self.randomAnswer == 1) {
            
            //Hacemos un random del vector de posibles contestaciones negativas
            self.randomAnswer = Int(arc4random_uniform(self.nRespNo))
            //Cambiamos por el emoji dislike
            self.emoji.image = UIImage(named: "dislike")
            //Actualizamos la UILabel por la respuesta
            self.appQuestion.text = self.respNo[self.randomAnswer]
            
            //Animación para el cambio de emoji, efecto translacion y rotación
            UIView.animate(
                withDuration: 0.8,
                delay: 0,
                options: UIView.AnimationOptions.curveEaseOut,
                animations: {
                    
                    self.emoji.transform = CGAffineTransform(translationX: 20, y: 0).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi/4))
                    
            }) { (completed) in
                
                self.emoji.transform = CGAffineTransform.identity
                
            }
            
        }
        //Si Merlín dice QUIZÁS
        else {
            self.randomAnswer = Int(arc4random_uniform(self.nRespMaybe))
            self.emoji.image = UIImage(named: "thinking")
            self.appQuestion.text = self.respMaybe[self.randomAnswer]
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: UIView.AnimationOptions.curveEaseOut,
                animations: {
                    
                self.emoji.transform = CGAffineTransform(scaleX: 0.9, y: 1.4)
                    
            }) { (completed) in
                
                self.emoji.transform = CGAffineTransform.identity
                
            }
            
        }
    }
    
    //Eventos
    @IBAction func pressAskButton(_ sender: Any) {
        self.generarRespuestaMagica()
    }
    
    
    //SHAKE DEL DISPOSITIVO (TRUE)-----------------------------------------------------
    
    //Preparamos el dispositivo para que acepte el shake en la app. (true)
    override func becomeFirstResponder() -> Bool {
        return true
    }
    //Al acabar el gesto --> si es motionshake --> generateRandomNumbersDices()
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.generarRespuestaMagica()
        }
    }
    
    //-----------------------------------------------------------------------------------
    
    
    
}


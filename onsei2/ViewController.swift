//
//  ViewController.swift
//  onsei new
//
//  Created by 原 あゆみ on 2017/02/18.
//  Copyright © 2017年 原 あゆみ. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,AVSpeechSynthesizerDelegate,UITextFieldDelegate,UITextViewDelegate {
    /** 話す内容を入力するテキストフィールド */
    @IBOutlet weak var speechText: UITextView!
    //    @IBOutlet weak var languagePickerView: UIPickerView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet var languagePickerView: UIPickerView? = UIPickerView()
    @IBOutlet weak var soundslider: UISlider!
    @IBOutlet weak var soundlabel: UILabel!
    @IBOutlet weak var speedslider: UISlider!
    @IBOutlet weak var speedlabel: UILabel!
    @IBOutlet weak var toneslider: UISlider!
    @IBOutlet weak var tonelabel: UILabel!
    @IBOutlet weak var playpausebutton: UIButton!
//    @IBOutlet weak var stopbutton: UIButton!
//    @IBOutlet weak var startbutton: UIButton!
    @IBOutlet weak var playpauseimage: UIImageView!
    @IBOutlet weak var stopimage: UIImageView!
    @IBOutlet weak var startimage: UIImageView!
    @IBOutlet weak var placeFoldertext : UILabel!
    
        
    
    
    /** SpeechSynthesizerクラス */
    var talker = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance()
    static var push : Int!
    static var text2 :String = "قم بإدخال النص"
    static var tone2 :Double = 0.0
    static var volume2 :Double = 0.0
    static var speed2 :Double = 0.0
    static var languageX :Int!
    static var flagName : String = "SaudiArabia.png"
    
    static var tag:Int = 0
    static var id:String = "0"
    
    static var language3 :String! = "Arabic(SaudiArabia)"
    static var textdefault :String! = "قم بإدخال النص"
    var miteruka :Int! = 0
    static var flagImage : UIImage! = UIImage(named : "Saudi Arabia.png" )
    var friends : Int = TableViewController.sugoi
    var textTag : Int = 0
   
    let realm = try! Realm()
    
    

    
    
     dynamic var list=["Arabic(SaudiArabia)","English(SouthAfrica)","Thai(Thailand)","Dutch(Belgium)","German (Germany)","English(Australia)","English(UnitedStates)","Portuguese(Brazil)","Polish(Poland)","English(Ireland)","Greek(Greece)","Indonesian(Indonesia)","Swedish(Sweden)","Turkish(Turkey)","Portuguese(Portugal)","Japanese(Japan)","Korean(Korea)","Hungarian(Hungary)","Czech(CzechRepublic)","Danish(Denmark)","Spanish(Mexico)","French(Canada)","Dutch(Netherlands)","Finnish(Finland)","Spanish(Spain)","Italian(Italy)","Romanian(Romania)","Norwegian(Norway)","Chinese(HongKong)","Chinese(Taiwan)","Slovak(Slovakia)","Chinese(China)","Russian(Russia)","English(UnitedKingdom)","French(France)","Hindi (India)"]
    
    dynamic var language2 = ["ar-SA","en-ZA","th-TH","nl-BE","en-AU","de-DE","en-US","pt-BR","pl-PL","en-IE","el-GR","id-ID","sv-SE","tr-TR","pt-PT","ja-JP","ko-KR","hu-HU","cs-CZ","da-DK","es-MX","fr-CA","nl-NL","fi-FI","es-ES","it-IT","ro-RO","no-NO","zh-HK","zh-TW","sk-SK","zh-CN","ru-RU","en-GB","fr-FR","hi-IN"]
    
    dynamic var languagetext = ["قم بإدخال النص","enter the text","รุณากรอกข้อความ","Typ tekst","Bitte geben Sie den Text","enter the text","enter the text","digite o texto","wpisz tekst","enter the text","Πληκτρολογήστε κείμενο","Teks Masukkan","Skriv text","metin girin","Digite o texto","テキストを入力","텍스트를 입력하십시오","Kérjük írja be a képen","Prosím zadejte text","Indtast teksten","Por favor introduzca el texto","S’il vous plaît entrer le texte","Typ tekst","Ole hyvä ja kirjoita teksti","Por favor  introduzca el texto","Inserisci il testo","Vă rugăm să introduceți textul","Vennligst skriv inn teksten","请输入文字","请输入文字","Prosím zadajte text","请输入文字","Пожалуйста  введите текст","enter the text","S’il vous plaît entrer le texte","अपना पाठ दर्ज करें"]
    
    dynamic var flaglist = ["Saudi Arabia.png","SouthA frica.png","Thailand.png","Belgium.png","Germany.png","Australia.png","United States.png","Brazil.png","Poland.png","Ireland.png","Greece.png","Indonesia.png","Sweden.png","Turkey.png","Portugal.png","Japan.png","Korea.png","Hungary.png","Czech Republic.png","Denmark.png","Mexico.png","Canada.png","Netherlands.png","Finland.png","Spain.png","Italy.png","Romania.png","Norway.png","Hong Kong.png","Taiwan.png","Slovakia.png","China.png","Russia.png","United Kingdom.png","France.png","India.png"]

    

    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        talker.speak(utterance)
        ViewController.push = 0
        playpauseimage.image = UIImage(named: "iconDownload.cgi.png")
    

        print("最初は\(ViewController.flagImage)")

        
        /*      // 話す速度を設定（0.0〜1.0）
         utterance.rate = 0.5
         */
        languagePickerView?.dataSource = self
        languagePickerView?.delegate = self
        self.view.addSubview(languagePickerView!)
        
        
        // UISliderの最大値・最小値を指定
        soundslider.minimumValue = 0.0
        soundslider.maximumValue = 1.0
        
        speedslider.minimumValue = 0.0
        speedslider.maximumValue = 1.0
        
        toneslider.minimumValue = 0.5
        toneslider.maximumValue = 2.0
        // UISliderの初期値を指定
        soundslider.setValue(0.5, animated: true)
        speedslider.setValue(0.5, animated: true)
        toneslider.setValue(1.25, animated: true)
        self.talker.delegate = self
        speechText?.delegate = self
       
        
        // 仮のサイズでツールバー生成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ViewController.commitButtonTapped))
        
        
        kbToolBar.items = [spacer, commitButton]
        
        
        speechText.inputAccessoryView = kbToolBar
        
        
        
        placeFoldertext.text = String(ViewController.textdefault)
        placeFoldertext.textColor = UIColor.gray

        print("tag:" + String(ViewController.tag))
        print("id:" + String(ViewController.id))
        
        if ViewController.tag == 1{
            languagePickerView?.selectRow(friends, inComponent: 0, animated: true)
            ViewController.volume2 = TableViewController.onryou
            ViewController.speed2 = TableViewController.hayasa
            ViewController.tone2 = TableViewController.ontei
                       
        }
        
                
    }
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row] as String
        return language2[row] as String
        ViewController.language3 = String(language2[row])

        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("列: \(row)")
        print("値: \(list[row])")
        print("言語\(language2[row])")
        print("textTag",textTag)
        miteruka = Int(row)
        ViewController.language3 = String(language2[row])
        ViewController.textdefault = String(languagetext[row])
        ViewController.flagName = String(flaglist[row])
        ViewController.flagImage = UIImage(named: ViewController.flagName)
        print("見てるか\(miteruka)")
        print("旗\(flaglist[row])")
        print(ViewController.flagName)
        if textTag == 0 {
            placeFoldertext.text = String(ViewController.textdefault)
                   }
        
        if speechText.text == "" {
            placeFoldertext.text = String(ViewController.textdefault)
                   }
        
     


        
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance)
    {
        print("***終了***")
        ViewController.push = 0
        
    }
    
    
    
    func commitButtonTapped(){
        self.view.endEditing(true)
        textTag = 1
        print("閉じてる？")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        placeFoldertext.isHidden = true
        print("隠れました")
        return true
        
    }
    
    //textviewからフォーカスが外れて、TextViewが空だったらLabelを再び表示
     func textViewDidEndEditing(_ textView: UITextView) {
        
        if(speechText.text.isEmpty){
            placeFoldertext.isHidden = false
        }
        print("空です")
    }
    
    
  
    
  //MARK: - button
      @IBAction func stopbutton(sender: UIButton){
        talker.stopSpeaking(at: AVSpeechBoundary.immediate)
        ViewController.push = 0
        print("ストップ\(ViewController.push)")
    //    stopimage.image = UIImage(named: "iconDownload.cgi-4.png")
        
    }
    
    @IBAction func startbutton(sender: UIButton){
        talker.stopSpeaking(at: AVSpeechBoundary.immediate)
       ViewController.push = 0
        print("スタート\(ViewController.push)")
    //    startimage.image = UIImage(named: "iconDownload.cgi-6.png")
    }
    
    
    @IBAction func playbutton(){
        print("プレイ\(ViewController.push)")
        if ViewController.push < 1 {
            
            // 話す内容をセット
            let utterance = AVSpeechUtterance(string:self.speechText.text!)
            print(speechText.text)
            // 言語を設定
            utterance.voice = AVSpeechSynthesisVoice(language:ViewController.language3)
            print("話している内容は",ViewController.language3)
            // 実行
            utterance.rate = speedslider.value
            utterance.volume = soundslider.value
            utterance.pitchMultiplier = toneslider.value
            self.talker.speak(utterance)
            ViewController.push = ViewController.push + 1
            
            print("ハゲ\(ViewController.push)")
            
            
        } else if talker.isSpeaking && !talker.isPaused{
            
            talker.pauseSpeaking(at: AVSpeechBoundary.immediate)
            playpauseimage.image = UIImage(named: "iconDownload.cgi-7.png")
            
            print("アホ\(ViewController.push)")
            
        }else if talker.isPaused && talker.isSpeaking
        {
            talker.continueSpeaking()
            playpauseimage.image = UIImage(named: "iconDownload.cgi.png")
            print("バカ\(ViewController.push)")
            
            
        print("---------")
        print(talker.isSpeaking)
        print(talker.isPaused)
        }
    }
    
    

    
    
      @IBAction func speedsliderChanged(_ sender: UISlider) {
   
     //UILabelの値を更新
     //sender.valueでUISliderの値が取得可能
     utterance.rate = sender.value
     print(sender.value)
     //soundlabel.text = "value: \(sender.value)"
     
     
     //ちなみに、sliderを使って音量や再生速度を調節するには、sender.valueの値をutterance.rate に代入すればよい
     //utterance.rate = sender.value
     
     //補足
     //声のボリュームを指定するには以下のコード
     //utterance.volume =　sender.value
     }
     
     @IBAction func soundSliderChanged(_ sender: UISlider){
     utterance.volume = sender.value
     print(sender.value)
     }
     
     @IBAction func tonesliderChanged(_ sender: UISlider){
     utterance.pitchMultiplier = sender.value
     print(sender.value)
     
     }
    
    @IBAction func save(sender: AnyObject) {
        let newText = UserData()
        
        
        // textFieldに入力したデータをnewTodoのtitleに代入
        newText.text = speechText.text!
        newText.speed = Double(utterance.rate)
        newText.volume = Double(utterance.volume)
        newText.tone = Double(utterance.pitchMultiplier)
        newText.language = miteruka
         print("これ\(ViewController.flagImage)")
        newText.flag = UIImagePNGRepresentation(ViewController.flagImage)! as NSData
                
        print(newText.text)
        print(newText.volume)
        print(newText.speed)
        print(newText.tone)
        print(newText.language)
                
        // 上記で代入したテキストデータを永続化するための処理
        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(newText)
                print("ToDo Saved")
            })
        }catch{
            print("Save is Faild")
        }
        //  self.navigationController?.popToRootViewController(animated: true)
    }
    
    
 
    
}

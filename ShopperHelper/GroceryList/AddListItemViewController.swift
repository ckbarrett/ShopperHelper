//
//  AddCriteriaViewController.swift
//  BarrettChristianFinalProject
//
//  Created by Student on 12/1/21.
//

import UIKit

class AddListItemViewController: UIViewController, UITextFieldDelegate {
    let groceryModel = GroceryModel.shared
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var TextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SaveButton.isEnabled = false
        TextField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SaveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TextField.resignFirstResponder()
    }
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        if let name = TextField.text {
            SaveButton.isEnabled = name.count > 0
        }
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        resetView()
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        // Create new criteria before leaving
        if let name = TextField.text {
            groceryModel.addGrocery(name)
        }
        resetView()
    }
    func resetView(){
        TextField.text = nil
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ScreenTapped(_ sender: UITapGestureRecognizer) {
        TextField.resignFirstResponder()
    }
}

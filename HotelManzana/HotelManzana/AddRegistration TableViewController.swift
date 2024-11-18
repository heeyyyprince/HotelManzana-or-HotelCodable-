//
//  AddRegistration TableViewController.swift
//  HotelManzana
//
//  Created by Prince  on 18/11/24.
//

import UIKit

class AddRegistration_TableViewController: UITableViewController,SelectRoomTypeTableViewControllerDelegate {
    
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var CheckInDateLabel: UILabel!
    @IBOutlet var CheckInDatePicker: UIDatePicker!
    @IBOutlet var CheckOutDateLabel: UILabel!
    @IBOutlet var CheckOutDatePicker: UIDatePicker!
    
    
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet var wifiSwitch: UISwitch!
    
    @IBOutlet var roomTypeLabel: UILabel!
    var roomType: RoomType?
    
    
    var registration : Registration? {
        guard let roomType = roomType else {
            return nil
    }
    let firstName = firstNameTextField.text ?? ""
    let lastName = lastNameTextField.text ?? ""
    let email = emailTextField.text ?? ""
    let checkingInDate = CheckInDatePicker.date
    let checkingOutDate = CheckOutDatePicker.date
    
    let numberOfAdults = Int(numberOfAdultsStepper.value)
    let numberOfChildren = Int(numberOfChildrenStepper.value)
    let haswifi = wifiSwitch.isOn
    
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkingInDate, checkOutDate: checkingOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, wifi: haswifi,roomType: roomType)

        
    }
    
  
    
    let checkInDateLabelCellIndexPath = IndexPath(row: 0 , section: 1)
    let checkInDatePickerCellIndexPath = IndexPath(row: 1 , section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2 , section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3 , section: 1)
    
    var isCheckInDatePickerVisible: Bool = false {
        didSet{
            CheckInDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    
    var isCheckOutDatePickerVisible: Bool = false {
        didSet{
            CheckOutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == checkInDateLabelCellIndexPath && isCheckInDatePickerVisible == false {
            isCheckInDatePickerVisible.toggle()
            
        }else if indexPath == checkOutDateLabelCellIndexPath && isCheckOutDatePickerVisible == false {
            isCheckOutDatePickerVisible.toggle()
            
        }else if indexPath == checkInDateLabelCellIndexPath || indexPath == checkOutDateLabelCellIndexPath{
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        }else{
            return
        }
            
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let midNightToday = Calendar.current.startOfDay(for: Date())
        CheckInDatePicker.minimumDate = midNightToday
        CheckInDatePicker.date = midNightToday
        updateDtaeViews()
        updateNumberOfGuests()
        upadteRoomType()

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath where isCheckInDatePickerVisible == false:
            return 0
            
        case checkOutDatePickerCellIndexPath where isCheckOutDatePickerVisible == false:
            return 0
        default :
            return UITableView.automaticDimension
        
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            return 190
        case checkOutDatePickerCellIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    func updateDtaeViews() {
        CheckOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1 ,to: CheckInDatePicker.date)
        CheckInDateLabel.text=CheckInDatePicker.date.formatted(date: .abbreviated,time: .omitted)
        CheckOutDateLabel.text=CheckOutDatePicker.date.formatted(date: .abbreviated,time: .omitted)
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(numberOfAdultsStepper.value)"
        numberOfChildrenLabel.text = "\(numberOfChildrenStepper.value)"
    }
    func SelectRoomTypeTableViewController(_contoller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        upadteRoomType()
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDtaeViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchValueChanged(_ sender: UISwitch) {
        
    }
    
    func upadteRoomType() {
        if let roomType = roomType{
            roomTypeLabel.text = roomType.name
        }else{
            roomTypeLabel.text = "Not Set"
        }
        
    }

    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        let selectRoomTypeController = HotelManzana.SelectRoomTypeTableViewController(coder: coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        return selectRoomTypeController
        
    }
    
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true,completion: nil)
    }
    
    
}

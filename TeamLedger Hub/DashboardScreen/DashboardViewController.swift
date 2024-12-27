//
//  DashboardViewController.swift
//  TeamLedger Hub
//
//  Created by ucf 2 on 23/12/2024.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daylb: UILabel!
    @IBOutlet weak var MianView: UIView!
    @IBOutlet weak var timeOfDayLabel: UILabel!
    @IBOutlet weak var CollectionView: UICollectionView!

    private func displayCalendarInfo() {
        let currentDate = Date()
        
        // Set up the dateFormatter for the full date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let formattedDate = dateFormatter.string(from: currentDate)
        
        // Set up the dateFormatter for the day of the week
        dateFormatter.dateFormat = "EEEE" // "EEEE" gives full weekday name like "Monday"
        let dayOfWeek = dateFormatter.string(from: currentDate)
        
        // Set up the calendar to determine the time of day
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        let timeOfDay: String
        
        switch hour {
        case 6..<12:
            timeOfDay = "Morning"
        case 12..<17:
            timeOfDay = "Afternoon"
        case 17..<21:
            timeOfDay = "Evening"
        default:
            timeOfDay = "Night"
        }
        
        // Update the labels
        dateLabel.text = formattedDate // Display only the date (e.g., "December 27, 2024")
        daylb.text = dayOfWeek // Display the day of the week (e.g., "Thursday")
        timeOfDayLabel.text = "Good \(timeOfDay)!" // Show the time of day message (e.g., "Good Morning!")
    }

      
//        var orderDetails: [ordersBooking] = []
        var type = [String]()
        var Imgs: [UIImage] = [UIImage(named: "1")!,
            UIImage(named: "2")!,
            UIImage(named: "4")!,
            UIImage(named: "3")!,
            UIImage(named: "5")!,
            UIImage(named: "6")!]

        override func viewDidLoad() {
            super.viewDidLoad()
            displayCalendarInfo()
            
            type =  ["Add Developer","Developer","Create Task","Assigned Task","Setting","History"]
            
            CollectionView.dataSource = self
            CollectionView.delegate = self
            CollectionView.collectionViewLayout = UICollectionViewFlowLayout()
            applyCornerRadiusToBottomCorners(view: MianView, cornerRadius: 35)
            
        }
     
       
    }
extension DashboardViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DashbordCollectionViewCell
        
        cell.Label.text = type [indexPath.item]
        cell.images.image? =  Imgs [indexPath.item]
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 12
        let availableWidth = collectionViewWidth - (spacing * 3)
        let width = availableWidth / 2
        let height = width * 0.8 // Adjust this multiplier to control the height
        return CGSize(width: width + 3, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10) // Adjust as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
                    if indexPath.row == 0
                    {
                      let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                      let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddDeveViewController") as! AddDeveViewController
                      newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                      newViewController.modalTransitionStyle = .crossDissolve
                      self.present(newViewController, animated: true, completion: nil)
                    }
        
                    if indexPath.row == 1
                    {
        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ShowDeveViewController") as! ShowDeveViewController
        
                        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        newViewController.modalTransitionStyle = .crossDissolve
                        self.present(newViewController, animated: true, completion: nil)
        
                    }
        
                    if indexPath.row == 2
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CreateTaskViewController") as! CreateTaskViewController
        
                        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        newViewController.modalTransitionStyle = .crossDissolve
                       self.present(newViewController, animated: true, completion: nil)
        
                    }
                    if indexPath.row == 3
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RecordsViewController") as! RecordsViewController
                        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        newViewController.modalTransitionStyle = .crossDissolve
                        self.present(newViewController, animated: true, completion: nil)
                    }
                    if indexPath.row == 4
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
                        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        newViewController.modalTransitionStyle = .crossDissolve
                        self.present(newViewController, animated: true, completion: nil)
                    }
        
                    if indexPath.row == 5
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewSalesViewController") as! ViewSalesViewController
                        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        newViewController.modalTransitionStyle = .crossDissolve
                        self.present(newViewController, animated: true, completion: nil)
                    }
        
        
                }
    }
    




//
//  UserallViewController.swift
//  TeamLedger Hub
//
//  Created by ucf 2 on 24/12/2024.
//

    import UIKit

    class UserallViewController: UIViewController {

        @IBOutlet weak var TableView: UITableView!
        @IBOutlet weak var MianView: UIView!
        @IBOutlet weak var YourBounce: UILabel!
        @IBOutlet weak var TotalSalesAmount: UILabel!
        @IBOutlet weak var commessionView: UIView!
        @IBOutlet weak var noDataLabel: UILabel!  // Add this outlet for the label

        var tittleName = String()
        
        var Users_Detail: [Developer] = []
        var selectedCustomerDetail: Developer?
        
        var selectedOrderDetail: Project?
        var order_Detail: [Project] = []
        
        var currency: String = "$"
        
        var percentageSet = String()

        override func viewDidLoad() {
            super.viewDidLoad()

            applyCornerRadiusToBottomCorners(view: MianView, cornerRadius: 35)

            TableView.delegate = self
            TableView.dataSource = self
            applyCornerRadiusToBottomCorners(view: MianView, cornerRadius: 35)

            
            
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // Set the currency
            currency = UserDefaults.standard.value(forKey: "currencyISoCode") as? String ?? "$"

            // Check for saved project data
            if let savedData = UserDefaults.standard.array(forKey: "ProjectDetails") as? [Data] {
                let decoder = JSONDecoder()
                order_Detail = savedData.compactMap { data in
                    do {
                        let order = try decoder.decode(Project.self, from: data)
                        return order
                    } catch {
                        print("Error decoding order: \(error.localizedDescription)")
                        return nil
                    }
                }

                // Filter orders based on the selected customer (if available)
                if let selectedCustomer = selectedCustomerDetail {
                    order_Detail = order_Detail.filter { $0.developerName == selectedCustomer.name }
                }

                // Check if there is data to display
                if order_Detail.isEmpty {
                    noDataLabel.isHidden = false // Show the "no data" label
                    noDataLabel.text = "Please enter your records first."
                    TableView.isHidden = true // Hide the TableView
                } else {
                    noDataLabel.isHidden = true // Hide the "no data" label
                    TableView.isHidden = false // Show the TableView
                }

                TableView.reloadData() // Reload the table view with the filtered data
            } else {
                // If there is no saved data
                noDataLabel.isHidden = false
                noDataLabel.text = "Please enter your records first."
                TableView.isHidden = true
            }
        }



        func makeImageViewCircular(imageView: UIImageView) {
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
        }

        func convertDateToString(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }

        func showAlert(_ title: String, _ message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

      
        
        @IBAction func backButton(_ sender: Any) {
            self.dismiss(animated: true)
        }
    }


    extension UserallViewController: UITableViewDelegate, UITableViewDataSource {
        
        // Number of rows in the table view
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return order_Detail.count
        }
        
        // Configure the cell for each row
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath) as! UserallTableViewCell
         
            let order = order_Detail[indexPath.row]
            
            // Set the product information to the cell labels
            cell.TittleName.text = order.developerName
            cell.TitleLabel.text = "Project.Title: \(order.title)"
            cell.nameLabel.text = "Project Manager: \(order.projectmanager)"
//            cell.Projectmanger.text = "Dev Name: \(order.developerName)"
            cell.dateLabe.text = "Start Date: \(order.startdate) - End Date: \(order.enddate)"

            
            return cell
        }
        
      
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 185  // Adjust as per your design
        }
        
    }



import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!

    struct RegUserModel: Decodable, Encodable {
        let login: String
        let pasword: String
        let name: String
        let genre: Int
    }

    struct RegUserResp: Decodable {
        let token: String
    }



    @IBAction func didLoginBtnTap(_ sender: Any) {

        let username = loginTextField.text ?? ""
        let passw = passTextField.text ?? ""

        if (username == "" || passw == "") {
            let alert = UIAlertController(title: "Wrong data", message: "Fields cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }

        let userData =  UserLoginReq(login: username, password: passw)
        do {
            let jsonUserData = try UrlAPI.encoder.encode(userData)

            UrlAPI.instance.login(jsonUserData) { user in
                print(user.token)

                DataAPI.instance.saveUser(login: username, password: passw, pabKey: user.token)

                DispatchQueue.main.async {
                    let view = TabsViewController(nibName: "TabsViewController", bundle: nil)
                    view.modalPresentationStyle = .fullScreen
                    self.present(view, animated: true, completion: nil)
                }
            }
        } catch {
            print("error: unpacking json")
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        selfInit()
    }


    private func fetchUserData() {
        loginTextField.text = DataAPI.instance.getKey(nameOfKey: DataAPI.userName) ?? ""
        passTextField.text = DataAPI.instance.getKey(nameOfKey: DataAPI.userPassword) ?? ""
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func selfInit() {
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backBtn
    }

}

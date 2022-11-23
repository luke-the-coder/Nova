import AuthenticationServices
import Foundation

class ViewController: UIViewController {
    var session: ASWebAuthenticationSession?
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    func startSignIn() {
        let STATE = String((0..<20).map{ _ in letters.randomElement()!})
        let CLIENT_ID = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String
        let authURL = URL(string: "https://www.reddit.com/api/v1/authorize?client_id=" + (CLIENT_ID!) + "&response_type=code&state=" + (STATE) + "&redirect_uri=novaClient://oauth-callback&duration=permanent&scope=identity,vote")
        let scheme = "novaClient"
        
        self.session = ASWebAuthenticationSession.init(url: authURL!, callbackURLScheme: scheme, completionHandler: { callbackURL, error in
            guard error == nil, let successURL = callbackURL else {
                return
            }
            let code = URLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "code"}).first
            let error = URLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "error"}).first
            let stateReturned = URLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "state"}).first
            if ((error) != nil){
                return
            }
            if (stateReturned?.value != STATE){
                return
            }
            print(error ?? "No errors")
            print(stateReturned ?? "No state returned")
            print(code ?? "No Code returned")

            //Parameters
            var requestBodyComponents = URLComponents()
            requestBodyComponents.queryItems = [URLQueryItem(name: "grant_type", value: "authorization_code"),
                                                URLQueryItem(name: "code", value: code?.value),
                                                URLQueryItem(name: "redirect_uri", value:"novaClient://oauth-callback")]

            let url = URL(string: "https://www.reddit.com/api/v1/access_token")!
            
            //create the session object
            let session = URLSession.shared
            
            //now create the Request object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "POST" //set http method as POST
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            //HTTP Auth Header
            let username = CLIENT_ID
            let password = ""
            let loginString = String(format: "%@:%@", username!, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            
            //set body with parameters
            request.httpBody = requestBodyComponents.query?.data(using: .utf8)

            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                guard error == nil else {
                    print(error)
                    return
                }
                guard let data = data else {
                    print(data)
                    return
                }
                do {
                    //create json object from data
                    guard let redditResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                        print("ERROR")
                        return
                    }
                    print(redditResponse)
                    UserDefaults.standard.set(redditResponse["access_token"], forKey: "token")
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        })
        session?.presentationContextProvider = self
        self.session?.start()
        self.session?.prefersEphemeralWebBrowserSession = true
    }
}

extension ViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}

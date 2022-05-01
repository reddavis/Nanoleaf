@testable import Nanoleaf

struct MockHTTPSessionDataTask {
    let request: URLRequest
    let session: MockHTTPSession
    let stub: MockHTTPSession.Stub?
    let completionHandler: (Data?, URLResponse?, Error?) -> Void
}

// MARK: HTTPSessionDataTask

extension MockHTTPSessionDataTask: HTTPSessionDataTask {
    public func cancel() { }
    
    public func resume() {
        var response: HTTPURLResponse?
        if let statusCode = self.stub?.statusCode,
           let url = self.request.url
        {
            response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        }
        
        // Check if response is a redirect
        if let unwrappedResponse = response,
           let statusCode = self.stub?.statusCode,
           300...399 ~= statusCode,
           let redirectURL = self.stub?.redirectURL,
           let delegate = self.session.taskDelegate
        {
            let request = URLRequest(url: redirectURL)
            
            let defaultSession = URLSession(configuration: .default)
            let task = defaultSession.dataTask(with: redirectURL)
            
            delegate.urlSession?(
                defaultSession,
                task: task,
                willPerformHTTPRedirection: unwrappedResponse,
                newRequest: request,
                completionHandler: { (request) in
                    guard let request = request else
                    {
                        self.completionHandler(self.stub?.data, response, nil)
                        return
                    }
                    
                    // Start redirected request
                    self.session.sessionDataTask(with: request, completionHandler: self.completionHandler).resume()
                }
            )
            
            return
        }
        
        self.completionHandler(self.stub?.data, response, nil)
    }
}

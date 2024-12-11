To create a macOS application with a WebView that runs the JavaScript code you’ve provided, you’ll need to integrate a WebView in a macOS application. You can achieve this by using WKWebView (WebKit) in a native macOS application built with Swift. Here’s how to set it up and run the provided JavaScript code in a WebView.

Step-by-Step Guide to Build macOS Application with WebView
	1.	Create a New macOS Project in Xcode
	•	Open Xcode and create a new macOS project using the App template.
	•	Select Swift as the programming language.
	•	Name your project (e.g., MacWebViewApp).
	2.	Add WKWebView to the Interface
You’ll use WKWebView to load the HTML page and run JavaScript within it.
a. Open Main.storyboard:
	•	Drag a WebView (or WKWebView if using the code) to your window in the interface builder.
	•	If using the interface builder, you will need to connect the WebView to your code.
b. Alternatively, Set Up WKWebView Programmatically:
First, import the WebKit framework:

import WebKit
import Cocoa


	3.	Write Swift Code to Load the HTML File in the WebView
Add the following code to the ViewController.swift to load the HTML content into the WebView.

import Cocoa
import WebKit

class ViewController: NSViewController {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a WKWebView instance
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: self.view.frame, configuration: webConfiguration)
        
        // Add the WebView to the view
        self.view.addSubview(webView)
        
        // Load the HTML file (or JavaScript code)
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

In this example, the HTML file is assumed to be named index.html and is located in your Xcode project’s resources folder.

	4.	Create the HTML File
Create a new HTML file that will hold the structure for the WebView to load. In Xcode:
	•	Right-click on the Resources folder (or wherever you want to store it) and select New File.
	•	Choose HTML File and name it index.html.
	5.	Embed JavaScript into the HTML File
In index.html, you can embed your JavaScript code directly, or load it from external files.
Example index.html:

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebView Example</title>
</head>
<body>
    <h1>Welcome to the WebView App</h1>

    <!-- Your custom JavaScript code -->
    <script src="mt_ui.js"></script>
    <script src="mt_utils.js"></script>

    <script>
        // Sample JavaScript interaction
        updateProgressBar("Initializing", 50);
        LogData("Device initialized.");
    </script>
</body>
</html>

Important Notes:
	•	Make sure to include your JavaScript files (e.g., mt_ui.js, mt_utils.js) in the project as well and ensure they are added to the Copy Bundle Resources in the build settings.
	•	You can also load external JavaScript files if needed.

	6.	Handle JavaScript Interactions (Optional)
If you want to interact with the JavaScript code (e.g., run JavaScript functions from Swift), you can do so by evaluating JavaScript in the WebView using evaluateJavaScript:
Example:

webView.evaluateJavaScript("updateProgressBar('Updated from Swift', 75)") { (result, error) in
    if let error = error {
        print("Error running JavaScript: \(error.localizedDescription)")
    }
}


	7.	Build and Run the Application
	•	After adding the necessary code and ensuring your HTML and JavaScript are loaded correctly, you can build and run the macOS app using Xcode.
	•	The WebView should display the content from your HTML file and execute the JavaScript commands.

Summary
	1.	Set up a macOS app using Xcode with Swift.
	2.	Add WKWebView to the main interface (either in the storyboard or programmatically).
	3.	Create an HTML file that contains your JavaScript logic.
	4.	Load the HTML file in the WebView and execute JavaScript.
	5.	(Optional) Use evaluateJavaScript to interact with the JavaScript from Swift.

Final Notes:
	•	If you are using local JavaScript files (mt_ui.js, mt_utils.js), make sure they are included in the project and correctly linked to the HTML file.
	•	For additional interaction between Swift and JavaScript, you can explore WKScriptMessageHandler for message passing from JavaScript to Swift.

Let me know if you need further details or help with any specific part!

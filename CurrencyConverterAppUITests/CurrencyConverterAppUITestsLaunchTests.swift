<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebView App</title>
    <!-- Include JavaScript files in the correct order -->
    <script src="mt_utils.js"></script>
    <script src="mt_ui.js"></script>
    <script src="mt_events.js"></script>
    <script src="mt_hid.js"></script>
    <script src="mt_mms.js"></script>
    <script src="mt_rms_api.js"></script>
    <script src="mt_rms_mms.js"></script>
    <script src="mmsdemo.js"></script>
</head>
<body>
    <h1>Welcome to the WebView App</h1>

    <!-- HTML content goes here -->
    <textarea id="LogData" rows="10" cols="50"></textarea>
    <input type="text" id="sendData" placeholder="Send data...">
    <button onclick="sendData()">Send Command</button>

    <button onclick="clearLogs()">Clear Logs</button>
    <button onclick="toggleUSB()">Toggle USB</button>

    <div id="device-links"></div>

    <script>
        // Example usage of functions from the JavaScript files
        window.onload = function() {
            // Initialize page elements
            updateProgressBar("Initializing", 50);
            LogData("Starting process...");
            setUSBConnected("opened");
            updateQRCode();
        };
    </script>
</body>
</html>



The JavaScript code you’ve shared appears to provide various functions for UI updates and interacting with device-related information in the context of a web application. To integrate this into your macOS app with a WebView, I’ll walk you through how to load and execute this code correctly using a WebView in a macOS app.

Steps to Integrate JavaScript into macOS WebView
	1.	Ensure All Dependencies Are Loaded: Make sure all the JavaScript files (like mt_utils.js) are loaded before your main JavaScript (mt_ui.js), especially if there are interdependencies.
	2.	Load the HTML into the WebView: The WebView in macOS will load an HTML file that references these JavaScript files.
	3.	Invoke JavaScript Functions from Swift: Use the evaluateJavaScript method to invoke JavaScript functions from your Swift code after the page is loaded.

Full Code Example for macOS WebView Integration

1. HTML File (index.html)

This is the HTML file that will be loaded in the WebView. Ensure that it includes all the necessary JavaScript files and has the required elements like updDeviceContainer, progressContainer, progressBar, and so on.

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebView Example</title>

    <!-- Include mt_ui.js and mt_utils.js -->
    <script src="mt_utils.js"></script>
    <script src="mt_ui.js"></script>
</head>
<body>
    <h1>Welcome to the WebView App</h1>

    <!-- Example HTML elements for UI updates -->
    <div id="updDeviceContainer" style="visibility: hidden;">
        <p></p>
    </div>
    <div id="progressContainer" style="visibility: hidden;">
        <div id="progressBar" style="width: 0%;"></div>
    </div>
    <textarea id="LogData" rows="10" cols="50"></textarea>

    <!-- Device links container -->
    <div id="device-links"></div>

    <!-- QR Code container -->
    <img id="QRCode" src="" alt="QR Code">

    <script>
        window.onload = function() {
            // Example usage of functions from mt_ui.js
            updateProgressBar("Initializing", 50);
            LogData("Starting process...");
            DeviceDisplay("Device Connected");

            // Example function call
            AddDeviceLink("device", "Device 1", "connected", "#");
            UpdateQRCode("SampleQRCodeData");
        };
    </script>
</body>
</html>

2. Swift Code to Load HTML into WebView

Here’s how you can load this HTML file into the WebView and call JavaScript functions from Swift.

ViewController.swift:

import Cocoa
import WebKit

class ViewController: NSViewController {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the WebView
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: self.view.frame, configuration: webConfiguration)

        // Add the WebView to the current view
        self.view.addSubview(webView)

        // Load the HTML file from the app's resources
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("HTML file not found!")
        }

        // Wait for the WebView to finish loading
        webView.navigationDelegate = self
    }
}

// Extend WKNavigationDelegate to handle page load events
extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // JavaScript call after page load
        webView.evaluateJavaScript("updateProgressBar('Loading...', 70)") { (result, error) in
            if let error = error {
                print("Error executing JavaScript: \(error.localizedDescription)")
            } else {
                print("JavaScript executed successfully!")
            }
        }

        // Example: Log data to the log
        webView.evaluateJavaScript("LogData('Page loaded successfully.')") { (result, error) in
            if let error = error {
                print("Error executing LogData function: \(error.localizedDescription)")
            }
        }
    }
}

Explanation:
	1.	HTML Structure:
	•	The HTML file contains elements like updDeviceContainer, progressContainer, progressBar, LogData, and so on, which are updated dynamically by JavaScript functions.
	•	The JavaScript files (mt_utils.js, mt_ui.js) are loaded into the HTML <head> to make sure they are available when the page is loaded.
	2.	WebView Setup:
	•	The WKWebView is created and added to the view hierarchy in the viewDidLoad method of the Swift view controller.
	•	The HTML file (index.html) is loaded into the WebView using the load method. Make sure the HTML file is added to the Xcode project and bundled with the app.
	3.	Interacting with JavaScript from Swift:
	•	After the WebView finishes loading (didFinish navigation), we can call JavaScript functions using evaluateJavaScript.
	•	In this example, we are calling updateProgressBar and LogData from JavaScript to interact with the WebView content.
	4.	Using JavaScript Functions:
	•	The JavaScript functions (updateProgressBar, LogData, DeviceDisplay, etc.) are defined in the mt_ui.js and mt_utils.js files, which are loaded in the HTML file before execution.

Debugging and Testing:
	•	Web Inspector: Open Safari, go to Develop > [Your App Name], and inspect the WebView console for any JavaScript errors. This will help you identify if there are any issues with the JavaScript functions not being executed properly.
	•	Testing JavaScript Calls: Use evaluateJavaScript in Swift to call specific functions and check for errors.

By following these steps, you should be able to load your HTML and JavaScript content in a WebView within a macOS app, and call JavaScript functions dynamically from Swift.




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebView Example</title>
    <!-- Load JavaScript files -->
    <script src="mt_utils.js"></script>
    <script src="mt_ui.js"></script>
    <script src="mt_events.js"></script>
    <script src="mt_hid.js"></script>
    <script src="mt_mms.js"></script>
    <script src="mt_rms_api.js"></script>
    <script src="mt_rms_mms.js"></script>
</head>
<body>
    <h1>Welcome to the WebView App</h1>

    <!-- Call JavaScript Functions -->
    <script>
        // Example: Calling a function from mt_ui.js
        updateProgressBar('Initializing', 50);
        LogData('Device initialized.');
    </script>
</body>
</html>




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

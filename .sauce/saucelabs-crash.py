
from appium import webdriver
from appium.webdriver.common.appiumby import AppiumBy
import time
import argparse

parser = argparse.ArgumentParser(description='dispatch an appium script to target')
parser.add_argument('--sauce-url', help='collector address to use, host name or ip acceptable.', default="http://localhost:4723")

args = parser.parse_args()

url = args.sauce_url

caps = {}
caps['platformName'] = "iOS"
caps['appium:deviceName'] = "iPhone Simulator"
caps['appium:deviceOrientation'] = "portrait"
caps['appium:platformVersion'] = "16.2"
caps['appium:automationName'] = "XCUITest"
caps['appium:app'] = "/Users/brycebuchanan/Desktop/opbeans-swift.zip"

driver = webdriver.Remote(url, caps)

el5 = driver.find_element(by=AppiumBy.XPATH, value="//XCUIElementTypeNavigationBar[@name=\"Opbeans Coffee\"]/XCUIElementTypeOther[1]")
el5.click()
el6 = driver.find_element(by=AppiumBy.XPATH, value="//XCUIElementTypeStaticText[@name=\"Customers\"]")
el6.click()
el8 = driver.find_element(by=AppiumBy.XPATH, value="//XCUIElementTypeApplication[@name=\"opbeans-swift\"]/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeCell[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeOther")
el8.click()


driver.launch_app()
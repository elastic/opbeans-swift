from appium import webdriver
from appium.webdriver.common.appiumby import AppiumBy
import time
import argparse

parser = argparse.ArgumentParser(description='dispatch an appium script to target')
parser.add_argument('--sauce-url', help='collector address to use, host name or ip acceptable.', default="http://localhost/wd/hub")

args = parser.parse_args()

url = args.sauce_url


caps = {}
caps['platformName'] = "iOS"
caps['appium:deviceName'] = "iPhone Simulator"
caps['appium:deviceOrientation'] = "portrait"
caps['appium:platformVersion'] = "15.4"
caps['appium:automationName'] = "XCUITest"
caps['appium:app'] = "storage:filename=opbeans-swift-sim.ipa"
caps['sauce:options'] = {}
caps['sauce:options']['build'] = 'test'
caps['sauce:options']['name'] = 'opbeans-swift'

driver = webdriver.Remote(url, caps)
el1 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Brazil Verde, Italian Roast, Dark Roast Coffee")
el1.click()
el2 = driver.find_element(by=AppiumBy.XPATH, value="//XCUIElementTypeButton[@name=\"CartToggle\"]")
el2.click()
el3 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Opbeans Coffee")
el3.click()
el4 = driver.find_element(by=AppiumBy.XPATH, value="//XCUIElementTypeNavigationBar[@name=\"Opbeans Coffee\"]/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeButton")
el4.click()
el5 = driver.find_element(by=AppiumBy.XPATH, value="//XCUIElementTypeButton[@name=\"Checkout\"]")
el5.click()
time.sleep(30)
driver.quit()

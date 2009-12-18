package au.com.sensis.mobile.web.component.clicktocall.showcase.selenium;

import org.apache.log4j.Logger;
import org.junit.Test;

import au.com.sensis.mobile.web.component.clicktocall.showcase.selenium.fixture.HomePage;

/**
 * Tests the home page.
 *
 * TODO
 *
 * In order to run this test start tomcat, then start the selenium server, run this as a JUnit test.
 *
 * @author Adrian.Koh2@sensis.com.au (based on Heather's work in Whereis Mobile)
 */
public class HomePageIntegrationTestCase extends AbstractSeleniumIntegrationTestCase {

    private static Logger logger = Logger.getLogger(HomePageIntegrationTestCase.class);

    /**
     * Opens the map page for an address.
     */
    @Test
    public void testCallPhoneNumber() throws Exception {
        getSelenium().setContext("testCallPhoneNumber()");
        getSelenium()
                .addCustomRequestHeader(
                        "user-agent",
                        "BlackBerry9000/4.6.0.266 Profile/MIDP-2.0 "
                                + "Configuration/CLDC-1.1 VendorID/122 UP.Link/6.5.1.3.0px");
        openHome();

        final HomePage homePage =
                (HomePage) getPageFixtureFactory().createPageFixture(
                        HomePage.class);
//        final File file = new File("testCallPhoneNumber-homePage.png");
//        getSelenium().captureEntirePageScreenshot(file.getAbsolutePath(), "background=#FFFFFF");
        // homePage.clickOnGetMap();

    }

    /**
     * Opens the map page for an address.
     *
     * TODO: dummy test to see what logging-selenium reporting in the superclass does
     * with multiple tests.
     */
    @Test
    public void testCallPhoneNumber2() throws Exception {
        getSelenium().setContext("testCallPhoneNumber2()");
        getSelenium()
        .addCustomRequestHeader(
                "user-agent",
                "BlackBerry9000/4.6.0.266 Profile/MIDP-2.0 "
                + "Configuration/CLDC-1.1 VendorID/122 UP.Link/6.5.1.3.0px");
        openHome();

        final HomePage homePage =
            (HomePage) getPageFixtureFactory().createPageFixture(
                    HomePage.class);
//        final File file = new File("testCallPhoneNumber-homePage.png");
//        getSelenium().captureEntirePageScreenshot(file.getAbsolutePath(), "background=#FFFFFF");
        // homePage.clickOnGetMap();

    }
}

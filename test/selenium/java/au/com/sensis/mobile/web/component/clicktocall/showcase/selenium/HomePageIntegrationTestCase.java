package au.com.sensis.mobile.web.component.clicktocall.showcase.selenium;

import java.io.File;

import org.apache.log4j.Logger;
import org.junit.Test;

import au.com.sensis.mobile.web.component.clicktocall.showcase.selenium.fixture.HomePage;

/**
 * Tests the home page.
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

        // TODO: setting of the user agent does not work, even if you start selenium RC
        // using "-proxyInjectionMode". If we can't get tihs to work, we can't really write
        // any meaningful selenium tests for this click to call component.
        // Maybe an alternative would be to start our own inprocess proxy (maybe via Jetty)
        // can proxy the HTTP requests but override the user agent header.
        getSelenium()
                .addCustomRequestHeader(
                        "user-agent",
                        "BlackBerry9000/4.6.0.266 Profile/MIDP-2.0 "
                                + "Configuration/CLDC-1.1 VendorID/122 UP.Link/6.5.1.3.0px");
        openHome();

        final HomePage homePage =
                (HomePage) getPageFixtureFactory().createPageFixture(
                        HomePage.class);

        // TODO: temporary code to see if the user agent setting worked (see TODO above).
        final File file = new File("testCallPhoneNumber-homePage.png");
        getSelenium().captureEntirePageScreenshot(file.getAbsolutePath(), "background=#FFFFFF");
    }

}

package au.com.sensis.mobile.web.component.clicktocall.showcase.selenium.fixture;

import static junit.framework.Assert.assertTrue;

import com.thoughtworks.selenium.Selenium;

/**
 * Assertions and actions for the Home Page.
 *
 * @author Adrian.Koh2@sensis.com.au (based on Heather's work in Whereis Mobile)
 */
public class HomePage extends AbstractPageFixture {

    /**
     * Default constructor.
     *
     * @param selenium {@link Selenium} instance being used.
     */
    public HomePage(final Selenium selenium) {
        super(selenium);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    protected void assertBody() {
        assertTrue(getBrowser().isTextPresent("Phone and fax numbers"));
        assertTrue(getBrowser().isTextPresent("(03) 9001 0001"));
        assertTrue(getBrowser().isTextPresent("(02) 8001 0001"));
        assertTrue(getBrowser().isTextPresent("(03) 9001 0002"));
        assertTrue(getBrowser().isTextPresent("(02) 8001 0002"));
    }
}

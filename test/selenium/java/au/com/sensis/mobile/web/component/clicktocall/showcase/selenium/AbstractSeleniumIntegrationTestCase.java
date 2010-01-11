package au.com.sensis.mobile.web.component.clicktocall.showcase.selenium;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;

import org.apache.log4j.Logger;

import com.thoughtworks.selenium.HttpCommandProcessor;
import com.thoughtworks.selenium.Selenium;
import com.unitedinternet.portal.selenium.utils.logging.HtmlResultFormatter;
import com.unitedinternet.portal.selenium.utils.logging.LoggingCommandProcessor;
import com.unitedinternet.portal.selenium.utils.logging.LoggingDefaultSelenium;
import com.unitedinternet.portal.selenium.utils.logging.LoggingResultsFormatter;
import com.unitedinternet.portal.selenium.utils.logging.LoggingUtils;

/**
 * Super class for all selenium test cases.
 *
 * @author Adrian.Koh2@sensis.com.au (based on Heather's work in Whereis Mobile)
 *
 * TODO: finish experimenting with use of logging-selenium.
 */
public abstract class AbstractSeleniumIntegrationTestCase
        extends
        au.com.sensis.wireless.test.selenium.AbstractSeleniumIntegrationTestCase {

    private static Logger logger = Logger.getLogger(AbstractSeleniumIntegrationTestCase.class);

    protected BufferedWriter loggingWriter;

    private static final String RESULT_FILE_ENCODING = "UTF-8";

    private static final String SCREENSHOT_PATH = "screenshots";

    private final String RESULTS_BASE_PATH =
            "build" + File.separator + "publish" + File.separator + "logging-selenium";

    private final String resultsBasePathAbsolute =
            new File(RESULTS_BASE_PATH).getAbsolutePath();

    private final String screenshotsResultsPathAbsolute =
            new File(RESULTS_BASE_PATH + File.separator + SCREENSHOT_PATH)
                    .getAbsolutePath();

    /**
     * TODO: shouldn't have to override.
     */
    @Override
    protected void openHome() {
        openUrl("/clicktocall-component-showcase/home.action");
    }

    @Override
    public void tearDown() {
        super.tearDown();
        try {
            if (null != loggingWriter) {
                loggingWriter.close();
            }
        } catch (final IOException e) {
            logger.error("Could not close loggingWriter", e);
        }
    }

    /**
     * @see au.com.sensis.wireless.test.selenium.AbstractSeleniumIntegrationTestCase#createSelenium()
     *
     * TODO: experimenting with using logging selenium to capture detailed report of each step in the test, including screenshots
     * when failures occur. Roughly works but see limitations in TODO below, plus the fact that as of 11 Jan 2010, there has been
     * no update of logging selenium since Jan 2009 (!!!). Still, may be useful to put this in the base
     * class anyway? Shouldn't hurt performance too much?
     */
    @Override
    protected Selenium createSelenium() {
        if (!new File(screenshotsResultsPathAbsolute).exists()) {
            new File(screenshotsResultsPathAbsolute).mkdirs();
        }
        // to keep every result use a timestamped filename like this
        // final String resultHtmlFileName = resultsBasePathAbsolute
        // + File.separator
        // + "autorunResult"
        // + LoggingUtils.timeStampForFileName()
        // + ".html";
        // TODO: need to generate timestamp better. logging-selenium's implementation only does it to the "second"
        // granularity which can cause a test to overwrite a report of the previous test.
        // TODO: there is also no way to name the result file after the test being executed unless
        // every test case is responsible for calling createSelenium instead of the setup method doing it.
        final String resultHtmlFileName =
                resultsBasePathAbsolute + File.separator + "autorunResult"
                        + LoggingUtils.timeStampForFileName() + ".html";
        if (logger.isInfoEnabled()) {
            logger.info("resultHtmlFileName=" + resultHtmlFileName);
        }

        loggingWriter =
                LoggingUtils
                        .createWriter(
                                resultHtmlFileName,
                                AbstractSeleniumIntegrationTestCase.RESULT_FILE_ENCODING,
                                true);

        final LoggingResultsFormatter htmlFormatter =
                new HtmlResultFormatter(
                        loggingWriter,
                        AbstractSeleniumIntegrationTestCase.RESULT_FILE_ENCODING);
        htmlFormatter
                .setScreenShotBaseUri(AbstractSeleniumIntegrationTestCase.SCREENSHOT_PATH
                        + "/"); // has to be "/" as this is a URI
        htmlFormatter
                .setAutomaticScreenshotPath(screenshotsResultsPathAbsolute);
        final LoggingCommandProcessor myProcessor =
                new LoggingCommandProcessor(new HttpCommandProcessor(getHost(),
                        getSeleniumPort(), "*chrome", getBrowserUrl()),
                        htmlFormatter);
        myProcessor.setExcludedCommands(new String[] {});
        return new LoggingDefaultSelenium(myProcessor);

    }
}

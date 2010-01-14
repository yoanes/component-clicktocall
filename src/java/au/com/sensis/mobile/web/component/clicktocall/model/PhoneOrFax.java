package au.com.sensis.mobile.web.component.clicktocall.model;

/**
 * Simple wrapper for a phone or fax number.
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class PhoneOrFax {

    private final String displayFormattedNumber;
    private final String callFormattedNumber;
    private final boolean faxNumber;

    /**
     * Default constructor.
     *
     * @param displayFormattedNumber The display formatted number. eg. (03) 9001 0001
     * @param callFormattedNumber The number in a callable format. eg. +61390010001.
     * @param faxNumber True if the number is a fax number. False otherwise.
     */
    public PhoneOrFax(final String displayFormattedNumber,
            final String callFormattedNumber, final boolean faxNumber) {
        this.displayFormattedNumber = displayFormattedNumber;
        this.callFormattedNumber = callFormattedNumber;
        this.faxNumber = faxNumber;
    }

    /**
     * @return  true if this is a fax number, otherwise it is just a phone number.
     */
    public boolean isFaxNumber() {
        return faxNumber;
    }

    /**
     * @return the displayFormattedNumber
     */
    public String getDisplayFormattedNumber() {
        return displayFormattedNumber;
    }

    /**
     * @return the callFormattedNumber
     */
    public String getCallFormattedNumber() {
        return callFormattedNumber;
    }
}


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


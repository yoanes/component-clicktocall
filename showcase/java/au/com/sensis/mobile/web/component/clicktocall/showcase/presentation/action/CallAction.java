package au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action;

import org.apache.log4j.Logger;

import au.com.sensis.mobile.web.component.clicktocall.model.PhoneOrFax;
import au.com.sensis.mobile.web.component.clicktocall.showcase.business.PhoneOrFaxFactory;
import au.com.sensis.mobile.web.testbed.presentation.common.DumbAction;

/**
 * Simple showcase action that indexes into a List of {@link PhoneOrFax} objects
 * and exposes the found object to the current page.
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class CallAction extends DumbAction {

    private static Logger logger = Logger.getLogger(CallAction.class);

    private int index;
    private PhoneOrFaxFactory phoneOrFaxFactory;

    /**
     * Returns the {@link PhoneOrFax} corresponding to {@link #getIndex()}.
     *
     * @return the {@link PhoneOrFax} corresponding to {@link #getIndex()}.
     */
    public PhoneOrFax getPhoneOrFax() {
        return getPhoneOrFaxFactory().createPhoneOrFaxList().get(getIndex());
    }

    /**
     * @return the phoneOrFaxFactory
     */
    private PhoneOrFaxFactory getPhoneOrFaxFactory() {
        return phoneOrFaxFactory;
    }


    /**
     * @param phoneOrFaxFactory the phoneOrFaxFactory to set
     */
    public void setPhoneOrFaxFactory(final PhoneOrFaxFactory phoneOrFaxFactory) {
        this.phoneOrFaxFactory = phoneOrFaxFactory;
    }

    /**
     * @return the index
     */
    public int getIndex() {
        return index;
    }

    /**
     * @param index the index to set
     */
    public void setIndex(final int index) {
        this.index = index;
    }

}

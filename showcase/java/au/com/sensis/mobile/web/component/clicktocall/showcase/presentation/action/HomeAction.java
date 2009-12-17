package au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action;

import java.util.List;

import org.apache.log4j.Logger;

import au.com.sensis.mobile.web.component.clicktocall.model.PhoneOrFax;
import au.com.sensis.mobile.web.component.clicktocall.showcase.business.PhoneOrFaxFactory;
import au.com.sensis.mobile.web.testbed.presentation.common.DumbAction;

/**
 * Simple showcase home action exposes a List of {@link PhoneOrFax} objects to the page.
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class HomeAction extends DumbAction {

    private static Logger logger = Logger.getLogger(HomeAction.class);

    private PhoneOrFaxFactory phoneOrFaxFactory;

    /**
     * @return the phoneOrFaxList
     */
    public List<PhoneOrFax> getPhoneOrFaxList() {
        return getPhoneOrFaxFactory().createPhoneOrFaxList();
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

}

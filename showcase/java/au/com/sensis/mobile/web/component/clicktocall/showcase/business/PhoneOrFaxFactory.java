package au.com.sensis.mobile.web.component.clicktocall.showcase.business;

import java.util.ArrayList;
import java.util.List;

import au.com.sensis.mobile.web.component.clicktocall.model.PhoneOrFax;

/**
 * Simple factory for showcase data.
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class PhoneOrFaxFactory {

    public List<PhoneOrFax> createPhoneOrFaxList() {
        final List<PhoneOrFax> phoneOrFaxList = new ArrayList<PhoneOrFax>();
        phoneOrFaxList.add(createPhone1());
        phoneOrFaxList.add(createFax1());
        phoneOrFaxList.add(createPhone2());
        phoneOrFaxList.add(createFax2());
        return phoneOrFaxList;
    }

    private PhoneOrFax createPhone1() {
        return new PhoneOrFax("(03) 9001 1001", "+6139001001", false);
    }

    private PhoneOrFax createPhone2() {
        return new PhoneOrFax("(03) 9001 1002", "+6139001002", false);
    }

    private PhoneOrFax createFax1() {
        return new PhoneOrFax("(02) 8001 1001", "+6128001001", true);
    }

    private PhoneOrFax createFax2() {
        return new PhoneOrFax("(02) 8001 1001", "+6128001001", true);
    }

}

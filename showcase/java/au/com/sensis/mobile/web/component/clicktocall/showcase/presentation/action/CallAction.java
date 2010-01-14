package au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;

import au.com.sensis.mobile.web.component.clicktocall.model.PhoneOrFax;
import au.com.sensis.mobile.web.component.clicktocall.showcase.business.PhoneOrFaxFactory;
import au.com.sensis.mobile.web.testbed.presentation.common.DumbAction;

/**
 * Simple showcase action that indexes into a List of {@link PhoneOrFax} objects
 * and exposes the found object to the current page.
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class CallAction extends DumbAction implements ServletRequestAware {

    private static Logger logger = Logger.getLogger(CallAction.class);

    /**
     * Result name for a successful ajax request.
     */
    public static final String AJAX_SUCCESS_RESULT = "ajaxSuccess";

    private int index;

    /**
     * JavaScript relies on this being on the request url.
     */
    private String phoneNumber;

    private String xrw;

    private PhoneOrFaxFactory phoneOrFaxFactory;
    private HttpServletRequest httpServletRequest;


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

    /**
     * @see {@link ServletRequestAware#setServletRequest(HttpServletRequest)}
     */
    public void setServletRequest(final HttpServletRequest httpServletRequest) {
        this.httpServletRequest = httpServletRequest;

        if (logger.isDebugEnabled()) {
            logger.debug("headers for request: "
                    + httpServletRequest.getRequestURL());
            final Enumeration<String> headerNames =
                    httpServletRequest.getHeaderNames();
            while (headerNames.hasMoreElements()) {
                final String headerName = headerNames.nextElement();
                logger.debug(headerName + ": "
                        + httpServletRequest.getHeader(headerName));
            }
        }
    }

    /**
     * @return the httpServletRequest
     */
    public HttpServletRequest getHttpServletRequest() {
        return httpServletRequest;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String execute() {
        if (isAjaxRequest()) {
            if (logger.isInfoEnabled()) {
                logger.info("AJAX reporting call - in a real app, reporting would occur here ...");
            }
            return AJAX_SUCCESS_RESULT;
        } else {
            return super.execute();
        }
    }

    /**
     * @return true if the current request is an AJAX request.
     */
    private boolean isAjaxRequest() {
        return isAjaxRequestHeaderSet() || isAjaxRequestParamSet();
    }

    /**
     * @return
     */
    private boolean isAjaxRequestHeaderSet() {
        return "XMLHttpRequest".equalsIgnoreCase(getHttpServletRequest()
                .getHeader("X-Requested-With"));
    }

    /**
     * @return
     */
    private boolean isAjaxRequestParamSet() {
        return "xhr".equalsIgnoreCase(getXrw());
    }

    /**
     * @return the phoneNumber
     */
    public String getPhoneNumber() {
        return phoneNumber;
    }

    /**
     * @param phoneNumber the phoneNumber to set
     */
    public void setPhoneNumber(final String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    /**
     * Shorthand for {@link #setPhoneNumber(String)}.
     *
     * @param clickToCallPhoneNumber The number being called, in callable format, eg. +61390010001
     * @see #setPhoneNumber(String)
     */
    public void setCtcpn(final String clickToCallPhoneNumber) {
        setPhoneNumber(clickToCallPhoneNumber);
    }

    /**
     * @return the xrw
     */
    public String getXrw() {
        return xrw;
    }

    /**
     * @param xrw the xrw to set
     */
    public void setXrw(final String xrw) {
        this.xrw = xrw;
    }



}

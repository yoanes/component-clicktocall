package au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.Action;

import au.com.sensis.mobile.web.component.clicktocall.model.PhoneOrFax;
import au.com.sensis.mobile.web.component.clicktocall.showcase.business.PhoneOrFaxFactory;
import au.com.sensis.mobile.web.component.core.util.XmlHttpRequestDetector;
import au.com.sensis.mobile.web.testbed.presentation.common.DumbAction;

/**
 * Simple showcase action that indexes into a List of {@link PhoneOrFax} objects
 * and exposes the found object to the current page.
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class TelephoneProtocolHandlerAction extends DumbAction implements ServletResponseAware {

    private static Logger logger = Logger.getLogger(TelephoneProtocolHandlerAction.class);
    
    /**
     * Href that was clicked.
     */
    private String href;
    
    /**
     * {@link HttpServletResponse} for the request.
     */
    private HttpServletResponse httpServletResponse;

	/**
     * {@inheritDoc}
     */
    @Override
    public String execute() {
        if (logger.isInfoEnabled()) {
            logger.info("TelephoneProtocolHandlerAction invoked for href: '"
                    + getHref() + "'");
        }
        
    	getHttpServletResponse().setStatus(HttpServletResponse.SC_NO_CONTENT);
    	return Action.NONE;
    }
    
    public String getHref() {
    	return href;
    }
    
    public void setHref(String href) {
    	this.href = href;
    }

    /**
     * {@inheritDoc}
     */
	public void setServletResponse(HttpServletResponse httServletResponse) {
		this.httpServletResponse = httServletResponse;
    }

	private HttpServletResponse getHttpServletResponse() {
    	return httpServletResponse;
    }
}

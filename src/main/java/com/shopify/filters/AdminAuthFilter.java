package com.shopify.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shopify.models.UserModel;

public class AdminAuthFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		// getting the request URI
		String uri = req.getRequestURI();
		boolean admin = uri.contains("admin"); // checking for the admin page
		if (admin) {
			HttpSession session = req.getSession(false);
			if (session != null) {
				// checking if the user is logged in or not
				boolean isLoggedIn = session.getAttribute("user") != null;
				if (isLoggedIn) {
					UserModel user = (UserModel) req.getSession(false).getAttribute("user");
					// preventing from unauthorized access
					if (user.getIsadmin() == 1) {
						chain.doFilter(request, response);
					} else {
						req.setAttribute("message", "Not Authorized");
						res.sendRedirect(req.getContextPath() + "/Pages/index.jsp");
					}
				} else {
					req.setAttribute("message", "Please Login");
					res.sendRedirect(req.getContextPath() + "/Pages/Login.jsp");
				}
			} else {
				req.setAttribute("message", "Please Login");
				res.sendRedirect(req.getContextPath() + "/Pages/Login.jsp");
			}

		}

	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

}

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

public class LogInFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession(false);
		if (session != null) {
			// checking if the user is logged or not
			boolean isLogedIn = session.getAttribute("user") == null;
			if (isLogedIn) {
				req.getSession(false).setAttribute("errormessage", "Please Login");
				req.getSession(false).setAttribute("page", "login");
				res.sendRedirect(req.getContextPath() + "/Pages/Login.jsp");
			} else {
				chain.doFilter(request, response);
			}
		} else {
			// sending back to the login page
			req.getSession(false).setAttribute("page", "login");
			req.getSession(false).setAttribute("errormessage", "Please Login");
			res.sendRedirect(req.getContextPath() + "/Pages/Login.jsp");
		}

	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
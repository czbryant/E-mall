package ustc.sse.water.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

/**
 * Servlet Filter implementation class LoginFilter
 */
/**
 * 登录过滤器. <br>
 * 有些页面是要求用户登陆后才有权限访问，如果不登陆，则没有权限访问.
 * <p>
 * Copyright: Copyright (c) 2014年3月1日 下午2:21:08
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author wangytao@mail.ustc.edu.cn
 * @version 1.0.0
 */
public class LoginFilter extends OncePerRequestFilter {

	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		String[] toFilter = new String[] {"buyer"};
		
		String requestUri = request.getRequestURI();
		//判断买家是否登录
		boolean dofilter = false;
		for (String s : toFilter) {
			if (requestUri.indexOf(s) != -1) {
				//包含该目录下需要过滤的
				dofilter = true;
			}
		}
		
		if (dofilter) {
			Object object = request.getSession().getAttribute("current_user");
			
			if (object == null) {
				request.setCharacterEncoding("UTF-8");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                StringBuilder builder = new StringBuilder();
                builder.append("<script type=\"text/javascript\">");
                builder.append("alert('网页已过期，请重新登录');");
                builder.append("window.top.location.href='/E-Mall/tologin';");
                builder.append("</script>");
                out.print(builder.toString());
			} else {
				filterChain.doFilter(request, response);
			}
		} else {
			filterChain.doFilter(request, response);
		}
	}

}

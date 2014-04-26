package ustc.sse.water.utils;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HistoryCookieUtil {
	private final static String HISTORY_PRE  = "history_";//历史浏览cookie名
	private final static String HISTORY_PATH = "/";//cookie路径
	
	//清除所有的历史记录
	public static void removeAllHistoryCookie (HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		
		if (null == cookies || cookies.length == 0) {
			return;
		}
		
		for (Cookie cookie : cookies) {
			if (cookie.getName().startsWith(HISTORY_PRE)) {
				cookie.setMaxAge(0);
				cookie.setPath(HISTORY_PATH);
				response.addCookie(cookie);
			}
		}
	}
	
	//删除单个商品
	public static void removeHistoryCookie (HttpServletRequest request, HttpServletResponse response, String productId) {
		if (productId == null) {
			return;
		}
		
		Cookie[] cookies = request.getCookies();
		if (null == cookies || cookies.length == 0) {
			return;
		}
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(HISTORY_PRE + productId)) {
				cookie.setMaxAge(0);
				cookie.setPath(HISTORY_PATH);
				response.addCookie(cookie);
			}
		}
	}
	
	//添加单个商品到cookie，保存时间30天
	public static void setHistoryCookie (HttpServletRequest request, HttpServletResponse response, String productId) {
		if (productId == null) {
			return;
		}
		
		String cookieName = HISTORY_PRE + productId;
		Cookie cookie = new Cookie(cookieName, productId);
		cookie.setPath(HISTORY_PATH);
		cookie.setMaxAge(3600 * 24 * 30);
		response.addCookie(cookie);
	}
	
	public static void addHistoryCookie (HttpServletRequest request, HttpServletResponse response, String productId) {
		if (productId == null) {
			return;
		}
		int viewNum = 5;//显示个数
		String cookieName = HISTORY_PRE + productId;
		Cookie[] cookies = request.getCookies();
		int historyCookieNum = 0;
		if (cookies != null && cookies.length > 0) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().startsWith(HISTORY_PRE)) {
					historyCookieNum++;
				}
			}
		}
		
		if (historyCookieNum < viewNum) {
			boolean existFlag = false;
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(cookieName)) {
					removeHistoryCookie(request, response, productId);
					setHistoryCookie(request, response, productId);
					existFlag = true;
					break;
				}
			}
			if (!existFlag) {
				setHistoryCookie(request, response, productId);
			}
		}
		
		if (historyCookieNum == viewNum) {//去掉一个浏览时间距离现在时间最长的
			List<String> list = new ArrayList<String>();
			for (Cookie cookie : cookies) {
				if (cookie.getName().startsWith(HISTORY_PRE)) {
					list.add(cookie.getValue());
				}
			}
			if (list.contains(productId.toString())) {
				removeHistoryCookie(request, response, productId);
				setHistoryCookie(request, response, productId);
			} else {
				for (Cookie cookie : cookies) {
					if (cookie.getName().startsWith(HISTORY_PRE)) {
						String oldId = cookie.getValue();
						removeHistoryCookie(request, response, oldId);
						setHistoryCookie(request, response, productId);
						break;
					}
				}
			}
		}
		
		if (historyCookieNum > viewNum) {
			removeAllHistoryCookie(request, response);
			int addNewNum = 0;
			for (int i = cookies.length-1; i > 0; i--) {
				if (viewNum == addNewNum) {
					break;
				}
				if (cookies[i].getName().startsWith(HISTORY_PRE)) {
					String getNewProductId = cookies[i].getValue();
					if (null != getNewProductId && getNewProductId.length()>0) {
						setHistoryCookie(request, response, getNewProductId);
						addNewNum++;
					}
				}
			}
		}
	}
	
	public static List<String> getHistoryList (HttpServletRequest request) {
		List<String> list = new ArrayList<String>();
		Cookie[] cookies = request.getCookies();
		if (null == cookies || cookies.length == 0) {
			return null;
		}
		
		for(int i=cookies.length-1; i>0; i--) {
			if (cookies[i].getName().startsWith(HISTORY_PRE)) {
				String productId = cookies[i].getValue();
				if (productId != null && productId.trim().length()>0) {
					list.add(productId);
				}
			}
		}
		return list;
	}
}

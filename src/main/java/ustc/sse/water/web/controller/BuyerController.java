package ustc.sse.water.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import ustc.sse.water.constants.CommonConstant;
import ustc.sse.water.pojo.Addr;
import ustc.sse.water.pojo.BasketItem;
import ustc.sse.water.pojo.Buyer;
import ustc.sse.water.pojo.Evaluate;
import ustc.sse.water.pojo.OrderItem;
import ustc.sse.water.pojo.OrderJson;
import ustc.sse.water.pojo.Product;
import ustc.sse.water.service.BuyerService;
import ustc.sse.water.service.ProductService;
import ustc.sse.water.utils.SecurityUtil;
import ustc.sse.water.utils.SingleSignOnUtil;
import ustc.sse.water.utils.TimeUtil;

/**
 * 买家控制. <br>
 * 买家控制的方法.
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午9:02:20
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author wangytao@mail.ustc.edu.cn
 * @version 1.0.0
 */
@Controller
@RequestMapping("/BuyerController")
public class BuyerController {
	
	@Resource(name="BuyerService")
	protected BuyerService service;
	
	@Resource(name="ProductService")
	protected ProductService productService;
	/**
	 * 登录方法 
	 * @author WangYita0
	 * @param request
	 * @param response
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws NoSuchAlgorithmException, UnsupportedEncodingException{
		request.setCharacterEncoding("utf-8");
		ModelAndView mav=new ModelAndView();
		String name = request.getParameter("username");
		String password = request.getParameter("password");
		String pwd = SecurityUtil.AESCode(password);
		Buyer buyer = service.findBuyer(name, pwd);
		if(buyer!=null){
			request.getSession().setAttribute("current_user", buyer);
			
			Set<BasketItem> items = (Set<BasketItem>) request.getSession().getAttribute("myCart");
			request.getSession().removeAttribute("myCart");
			if(items != null){
				for (BasketItem basketItem : items) {
					basketItem.setBuyer(buyer);
				}
				productService.saveItemsIntoCart(buyer, items);
			}
			
			List<Product> newPros = new ArrayList<Product>();
			newPros = productService.getNewProducts();
			
			request.getSession().setAttribute("newPros", newPros);
			
			SingleSignOnUtil.setCookie(request, response, CommonConstant.WWW_COOKIE_NAME, buyer.getUsername());
			mav.setViewName("/main/welcome");
		} else{
			mav.addObject("msg", "登录出错，用户名或者密码错误！");
			mav.setViewName("/main/login");
		}
		return mav;
	}
	
	
	/**
	 * 重新登录方法 
	 * @author WangYita0
	 * @param request
	 * @param response
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/reLogin")
	@ResponseBody
	public String reLogin(HttpServletRequest request, HttpServletResponse response) throws NoSuchAlgorithmException, UnsupportedEncodingException{
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("username");
		String password = request.getParameter("password");
		String pwd = SecurityUtil.AESCode(password);
		Buyer buyer = service.findBuyer(name, pwd);
		if(buyer!=null){
			request.getSession().setAttribute("current_user", buyer);
			
			Set<BasketItem> items = (Set<BasketItem>) request.getSession().getAttribute("myCart");
			request.getSession().removeAttribute("myCart");
			if(items != null){
				for (BasketItem basketItem : items) {
					basketItem.setBuyer(buyer);
				}
				productService.saveItemsIntoCart(buyer, items);
			}
			
			//request.getSession().setAttribute("dbCart", buyer.getBasket());
			SingleSignOnUtil.setCookie(request, response, CommonConstant.WWW_COOKIE_NAME, buyer.getUsername());
			return "1";
		} else{
			return "0";
		}
	}
	
	@RequestMapping("/checkLogin")
	public String checkLogin(HttpServletRequest request,HttpServletResponse response) throws NoSuchAlgorithmException{
		String name = request.getParameter("username");
		String password = request.getParameter("password");
		String pwd = SecurityUtil.AESCode(password);
		Cookie cookie = SingleSignOnUtil.getCookie(request, "buyer");
		if(cookie!=null&&cookie.getValue()!=null){
			Buyer buyer = service.findBuyer(name, pwd);	
			request.setAttribute("buyer", buyer);
			return "/buyer/buyer_login_success";
		}else{
			return "/main/login";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession(false);
		if (session == null) {
			return "";
		} else {
			session.removeAttribute("buyerSmallCart");
			session.removeAttribute("myCart");
			session.removeAttribute("current_user");//移除session中的登录信息
			return "/main/welcome";
		}
		
	}
	
	@RequestMapping("/ajaxLogout")
	@ResponseBody
	public String ajaxLogout(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession(false);
		if (session == null) {
			return "0";
		} else {
			session.removeAttribute("buyerSmallCart");
			session.removeAttribute("myCart");
			session.removeAttribute("current_user");//移除session中的登录信息
			return "1";
		}
		
	}
	
	/**
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/toBuyerMgr")
	public String toBuyerMgr(HttpServletRequest request, HttpServletResponse response){
		return "/buyer/buyerMgr";
	}
	
	@RequestMapping("/gotoOrder")
	public String gotoOrder(){
		return "/buyer/order_assure";
	}
	
	@RequestMapping("/loadLeft")
	public String loadLeftPage(){
		return "/buyer/left";
	}
	
	@RequestMapping("/addAddr")
	public String addAddress(HttpServletRequest request, String receiveName, String state, String road,
				String postCode, String blanket, String tel) {
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		if (buyer != null) {
			Addr addr = new Addr();
			addr.setReceiveName(receiveName);
			addr.setArea(state);
			addr.setStreet(road);
			addr.setPostcode(postCode);
			addr.setBlanket(blanket);
			addr.setTelNumber(tel);
			addr.setFlag("0");
			buyer.getAddrs().add(addr);
			service.update(buyer);
			return "/buyer/addAddrSuccess";
		} else {
			return "/main/login";
		}
	}
	
	
	@RequestMapping("/register")
	public ModelAndView buyerRegiser(HttpServletRequest request, HttpServletResponse response) throws NoSuchAlgorithmException, UnsupportedEncodingException{
		request.setCharacterEncoding("utf-8");//时间:2013/12/26 20:20 从前台获取的数据按utf-8编码后处理
		ModelAndView mav = new ModelAndView();
		String code = request.getParameter("code");
		System.out.println(request.getSession().getAttribute("code"));
		if (code.equals(request.getSession().getAttribute("code"))) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String enPwd = SecurityUtil.AESCode(password);
			String email = request.getParameter("email");
			Buyer buyer = new Buyer();
			buyer.setUsername(username);
			buyer.setPassword(enPwd);
			buyer.setEmail(email);
			buyer.setRegisterTime(TimeUtil.getProcessTime());
			service.addBuyer(buyer);
			mav.addObject("msg", "注册成功！");
			mav.setViewName("/main/login");
		} else {
			mav.addObject("msg", "验证码输入错误！");
			View view = new RedirectView("/E-Mall/toregister");
			mav.setView(view);
		}
		return mav;
	}
	
	/**
	 * 结算方法，确认购物车提取出的购物信息是正确的，这是一个<br>
	 * 这是一个中间过程，不将确认数据写到数据库，只保存到session。<br>
	 * 待提交后，才写入数据库
	 * @param request
	 * @return
	 */
	@RequestMapping("/settle")
	public String settle(HttpServletRequest request, String select){
		@SuppressWarnings("unchecked")
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		Set<BasketItem> itemList = productService.getBasketByUid(buyer);
		Set<OrderItem> orders = new HashSet<OrderItem>();
		
		
		if(select != null && !select.equals("")) {
			String string = select.substring(0,select.length()-1);
			String[] selected = string.split(",");
			for (String item : selected) {
				OrderItem order = new OrderItem();
				for (BasketItem basketItem : itemList) {
					if((basketItem.getId()+"").equals(item)){
						order.setBuyer(basketItem.getBuyer());
						order.setProduct(basketItem.getProduct());
						order.setProductIllustration("");
						order.setCount(basketItem.getAddCount());
						order.setPostTime("0");
						order.setOrderID(basketItem.getProduct().getProductId().substring(0, 6) + TimeUtil.yyyyMMddHHmmssSSS());
						order.setOrderStatus(0);
						break;
					}
				}
				orders.add(order);
			}
			request.getSession().setAttribute("orders", orders);
		}
		return "/buyer/order_assure";
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/submitOrder")
	public ModelAndView submitOrder(HttpServletRequest request, String addr_select) {
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		ModelAndView mav = new ModelAndView();
		if(buyer == null) {
			mav.setViewName("/main/login");
		} else {
			Set<OrderItem> tempOrders = (Set<OrderItem>) request.getSession().getAttribute("orders");
			request.getSession().removeAttribute("orders");
			if(addr_select != null) {
				Addr addr = service.getThePAById(addr_select);
				StringBuilder builder = new StringBuilder();
				builder.append(addr.getArea()).append(",").append(addr.getStreet()).append(",").append(addr.getBlanket()).
					append(",").append(addr.getReceiveName() + "收，").append(addr.getTelNumber()+",").append("邮编："+addr.getPostcode());
				for (OrderItem orderItem : tempOrders) {
					orderItem.setReceiveInfo(builder.toString());
					orderItem.setPostTime(TimeUtil.yyyyMMddHHmmss());
					orderItem.setOrderStatus(0);//订单为等待付款状态
					orderItem.setSellerId(orderItem.getProduct().getSeller().getsellerID());
				}
				//更新订单到数据库
				service.saveOrders(buyer, tempOrders);
				buyer = service.findBuyerById(buyer.getBuyerID());
				//清空购物车数据库
				service.emptyMyCart(tempOrders, buyer);
				//更新用户session
				request.getSession().setAttribute("current_user", service.findBuyerById(buyer.getBuyerID()));
				mav.setViewName("redirect:/BuyerController/payMoney");
			} else {
				for (OrderItem orderItem : tempOrders) {
					orderItem.setReceiveInfo(request.getParameter("addr"));
					orderItem.setPostTime(TimeUtil.yyyyMMddHHmmss());
					orderItem.setOrderStatus(0);//订单为等待付款状态
					orderItem.setSellerId(orderItem.getProduct().getSeller().getsellerID());
				}
				//更新订单到数据库
				service.saveOrders(buyer, tempOrders);
				//清空购物车数据库
				service.emptyMyCart(tempOrders, buyer);
				//更新用户session
				request.getSession().setAttribute("current_user", service.findBuyerById(buyer.getBuyerID()));
				mav.setViewName("redirect:/BuyerController/payMoney");
			}
		}
		return mav;
	}

	
	@RequestMapping("/payMoney")
	public String payMoney(HttpServletRequest request) {
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		List<OrderItem> nopays = service.getNoPayOrders(buyer);
		request.setAttribute("nopays", nopays);
		return "/buyer/payMoney";
	}
	
	@RequestMapping("/payManager")
	@ResponseBody
	public String payManager(HttpServletRequest request, String buyNum) {
		String orderId = request.getParameter("id");
		OrderItem order = productService.getOrderByLongID(Long.parseLong(orderId));
		//设置orderstatus
		order.setOrderStatus(1);
		productService.updateOrder(order);
		//设置product的sales和inventory
		Product product = productService.getProductById(order.getProduct().getProductId());
		product.setSalesNum(product.getSalesNum() + Integer.parseInt(buyNum));
		product.setInventory(product.getInventory() - product.getSalesNum());
		productService.updateProduct(product);
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		request.getSession().setAttribute("current_user", service.findBuyerById(buyer.getBuyerID()));
		return "";
	}
	
	@RequestMapping("/assessManager")
	@ResponseBody
	public String assessManager(HttpServletRequest request, int myScore, String aContent) {
		String orderId = request.getParameter("id");
		OrderItem order = productService.getOrderByLongID(Long.parseLong(orderId));
		Product product =  order.getProduct();
		Evaluate evaluate = new Evaluate();
		evaluate.setOrderItem(order);
		evaluate.setPostTime(TimeUtil.getTime(System.currentTimeMillis()));
		evaluate.setProductEval(aContent);
		product.setAssessNum(product.getAssessNum()+1);
		if (product.getScore() == null) {
			product.setScore(String.valueOf(myScore));
		} else {
			float b = Float.parseFloat(product.getScore());
			float a = (float)((myScore-b)/product.getAssessNum());
			float score = a + b; 
			DecimalFormat fscore = new DecimalFormat("##0.00");
			String _score = fscore.format(score);
			product.setScore(_score);
		}
		evaluate.setShopEvaluation(myScore);
		evaluate.setProduct(product);
		product.getEvaluates().add(evaluate);
		order.setOrderStatus(4);
		productService.updateOrder(order);
		productService.updateProduct(product);
		return "";
	}
	
	@RequestMapping("/updateInfo")
	public String updateInfo(HttpServletRequest request,String username,String usermail,String truename,char sex,String tel,String birthday){
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		if(buyer==null){
			
		}else{
			buyer.setBuyerName(username);
			buyer.setTelNum(tel);
			buyer.setTrueName(truename);
			buyer.setSex(sex);
			buyer.setEmail(usermail);
			buyer.setBirthday(birthday);
			service.update(buyer);
			request.getSession().setAttribute("current_buyer", service.findBuyerById(buyer.getBuyerID()));
			
		}
		request.setAttribute("buyer", buyer);
		return "/buyer/personal_info";
		
	}
	
	@RequestMapping("/password_update")
	@ResponseBody
	public String password_update(HttpServletRequest request, String oldPwd, String newPwd, String confirmPwd) throws NoSuchAlgorithmException{
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		if(buyer==null){
			return "0";
		}else{
			if(buyer.getPassword().equals(SecurityUtil.AESCode(oldPwd))){
				buyer.setPassword(SecurityUtil.AESCode(newPwd));
				service.update(buyer);
			}else{
				return "2";
			}
			request.getSession().setAttribute("current_buyer", service.findBuyerById(buyer.getBuyerID()));
			
			return "1";
		}
	}
	
	@RequestMapping("/orderSearch")
	
	public void searchOrder(HttpServletRequest request, HttpServletResponse response, String proName, String timeBegin, String timeEnd,
			String orderNum, String orderStatus) {
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		List<OrderItem> orderItems = service.searchOrders(buyer, proName, timeBegin, timeEnd, orderNum, orderStatus);
		List<OrderJson> orderJsons = new ArrayList<OrderJson>();
		if (orderItems != null) {
			for (OrderItem orderItem : orderItems) {
				OrderJson orderJson = new OrderJson();
				orderJson.setCount(orderItem.getCount());
				float price = orderItem.getProduct().getPrice()*orderItem.getCount();
				DecimalFormat fnum = new DecimalFormat("##0.00");
				String price_ = fnum.format(price);
				orderJson.setCurrentPrice(price_);
				orderJson.setOrderID(orderItem.getOrderID());
				orderJson.setProductName(orderItem.getProduct().getProductName());
				switch (orderItem.getOrderStatus()) {
				case -1:
					orderJson.setOrderStatus("交易关闭");
					break;
				case 0:
					orderJson.setOrderStatus("等待付款");
					break;
				case 1:
					orderJson.setOrderStatus("等待发货");
					break;
				case 2:
					orderJson.setOrderStatus("已发货");
					break;
				case 3:
					orderJson.setOrderStatus("待评价");
					break;
				case 4:
					orderJson.setOrderStatus("交易成功");
				default:
					break;
				}
				orderJsons.add(orderJson);
			}
		}
		
		JSONArray jsonArray = JSONArray.fromObject(orderJsons);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out;
		try {
			out = response.getWriter();
			out.print(jsonArray.toString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("ConfirmArrived")
	@ResponseBody
	public String ConfirmArrived(HttpServletRequest request) {
		String orderId = request.getParameter("id");
		OrderItem order = productService.getOrderByLongID(Long.parseLong(orderId));
		//设置orderstatus
		order.setOrderStatus(3);
		productService.updateOrder(order);
		//设置product的sales和inventory
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		request.getSession().setAttribute("current_user", service.findBuyerById(buyer.getBuyerID()));
		return "success";
	}
}

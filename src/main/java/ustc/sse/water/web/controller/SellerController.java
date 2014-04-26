package ustc.sse.water.web.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import ustc.sse.water.constants.CommonConstant;
import ustc.sse.water.pojo.BookGoods;
import ustc.sse.water.pojo.Buyer;
import ustc.sse.water.pojo.FruitGoods;
import ustc.sse.water.pojo.Image;
import ustc.sse.water.pojo.OrderItem;
import ustc.sse.water.pojo.Product;
import ustc.sse.water.pojo.Seller;
import ustc.sse.water.pojo.Shop;
import ustc.sse.water.service.ProductService;
import ustc.sse.water.service.SellerService;
import ustc.sse.water.utils.CompressImg;
import ustc.sse.water.utils.GZipUtil;
import ustc.sse.water.utils.SecurityUtil;
import ustc.sse.water.utils.SingleSignOnUtil;
import ustc.sse.water.utils.TimeUtil;

@Controller
@RequestMapping("/SellerController")
public class SellerController {
	private SellerService sellerService;
	
	/**
	 * 获取 sellerService
	 * @return sellerService
	 */
	public SellerService getSellerService() {
		return sellerService;
	}

	/**
	 * 设置 sellerService
	 * @param sellerService sellerService
	 */
	@Resource(name="SellerService")
	public void setSellerService(SellerService sellerService) {
		this.sellerService = sellerService;
	}
	
    ProductService productService;
	
	public ProductService getProductService() {
		return productService;
	}

	@Resource(name="ProductService")
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

	@RequestMapping("/register")
	public ModelAndView sellerRegister(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, NoSuchAlgorithmException{
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		String code = request.getParameter("code");
		if (code.equals(request.getSession().getAttribute("code"))) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String enPwd = SecurityUtil.AESCode(password);
			String email = request.getParameter("email");
			Seller seller = new Seller();
			seller.setUsername(username);
			seller.setPassword(enPwd);
			seller.setEmail(email);
			seller.setRegisterTime(TimeUtil.getProcessTime());
			sellerService.addSeller(seller);
			mav.addObject("msg", "注册成功！");
			mav.setViewName("/main/login");
		} else {
			mav.addObject("msg", "验证码输入错误！");
			View view = new RedirectView("/E-Mall/toregister");
			mav.setView(view);
		}
		return mav;
	}
	
	@RequestMapping("/login")
	public ModelAndView sellerLogin(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, NoSuchAlgorithmException{
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		String name = request.getParameter("username");
		String password = request.getParameter("password");
		String pwd = SecurityUtil.AESCode(password);
		Seller seller = sellerService.findseller(name, pwd);
		if(seller != null){
			request.getSession().setAttribute("current_seller", seller);
			SingleSignOnUtil.setCookie(request, response, CommonConstant.WWW_COOKIE_NAME, seller.getUsername());
			mav.setViewName("/seller/sellerMgr");
		} else {
			mav.addObject("msg", "登录出错，用户名不存在或密码错误！");
			mav.setViewName("/main/login");
		}
		return mav;
	}
	
	@RequestMapping("/logout")
	public String Logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			return "";
		} else {
			session.removeAttribute("current_seller");//移除session中的登录信息
			return "/main/welcome";
		}
	}
	
	@RequestMapping("/reSignin")
	@ResponseBody
	public String reSignin(HttpServletRequest request, String userName, String password){
		Seller seller = sellerService.findseller(userName,password);
		if(seller == null){
			return "0";
		}else{
			request.getSession().setAttribute("current_seller", seller);
			return "1";
		}
	}
	
	@RequestMapping("/toSellerMgr")
	public String toBuyerMgr(HttpServletRequest request, HttpServletResponse response){
		return "/seller/sellerMgr";
	}
	
	
	@RequestMapping(value="/addGoods", method=RequestMethod.POST)
	public String addGoods(HttpServletRequest request, String pack_style, String factory, String pro_name,
			String factoryAdrr, String guige, String[] month, String origin, String isOrganic, String factoryTel,
			String consists, String storeMethod, String persistTime, String extraContain, String productDate, String single_price,
			String weight, String pro_count, String sellerName, String editor , String invoice, String guarantee) {
		
		String productID = "000001" + UUID.randomUUID().toString();
		FruitGoods fruit = new FruitGoods();
		MultipartHttpServletRequest  multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files = multipartRequest.getFileMap();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		for (;fileNames.hasNext();) {
			String fileName = fileNames.next();
			CommonsMultipartFile uploadfile = (CommonsMultipartFile) files.get(fileName);
			if(uploadfile.getSize() != 0) {
				Image image = new Image();
				image.setProduct(fruit);
				fruit.getImages().add(image);
				String imgURI = null;
				if (!uploadfile.isEmpty()) {
					String realPath = "C://home//upload//fruit//";//硬地址
					File dirPath = new File(realPath);
					if (!dirPath.exists()){
						dirPath.mkdirs();
					} 
					String imgFlag = fileName.substring(0, fileName.length()-3);
					String imgName = UUID.randomUUID().toString()+ imgFlag + ".jpg";
					imgURI =realPath + imgName;
					if(imgFlag.equals("main")){
						fruit.setMainImgUrl(imgURI);
					}
					File imgFile = new File("C://home//123//" + imgName);
					try {
						uploadfile.getFileItem().write(imgFile);
						CompressImg.compressImgMethod(imgFile, realPath, imgName, 500, 450, false);
					} catch (Exception e) {
					e.printStackTrace();
					}
				}
				image.setImageUrl(imgURI);
			}
		}
		
		String harvest = "";
		for (int i=0; i<month.length; i++) {
			harvest += month[i] + ",";
		}
		harvest = harvest.substring(0, harvest.length()-1);

		fruit.setPackageStyle(pack_style);
		fruit.setIsOrganic(isOrganic);
		fruit.setHarvestMonth(harvest);
		fruit.setOrigin(origin);
		fruit.setFactoryName(factory);
		fruit.setFactoryAddr(factoryAdrr);
		fruit.setFactoryTel(factoryTel);
		fruit.setInTime(TimeUtil.yyyyMMdd());
		fruit.setSpecifications(guige);
		fruit.setIngredient(consists);
		fruit.setAdditive(extraContain);
		fruit.setProductDate(productDate);
		fruit.setFruitLife(Integer.parseInt(persistTime));
		fruit.setStoreMethod(storeMethod);
		fruit.setPrice(Float.parseFloat(single_price));
		fruit.setPromotionPrice(Float.parseFloat(single_price));
		fruit.setProductName(pro_name);
		fruit.setKeyWord(pro_name);
		fruit.setWeight(Float.parseFloat(weight));
		fruit.setInventory(Integer.parseInt(pro_count));
		fruit.setSeller((Seller) request.getSession().getAttribute("current_seller"));//查询seller表获得seller
		fruit.setProductId(productID);
		
		String description = GZipUtil.gzip(editor);
		if(description.length()>0 && description.length()<5000){
			fruit.setDescription(description);
		}
		
		sellerService.addGoods(fruit);
		return "/seller/addProSuccess";
	}
	
	@RequestMapping(value="/addBookGoods", method=RequestMethod.POST)
	public String addBookGoods(HttpServletRequest request, String bookName,String ISBN,String fixedPrice,
			String pack_style,String publisher,String publishTime,String author,String authorRegion,String translator,
			String editor,String format,String printTime,String pages,String wordCount,String pro_name, String description,
			String pro_count, String sellerName,  String invoice, String guarantee) {
		
		String productID = "000002" + UUID.randomUUID().toString();
		BookGoods book = new BookGoods();
		MultipartHttpServletRequest  multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files = multipartRequest.getFileMap();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		for (;fileNames.hasNext();) {
			String fileName = fileNames.next();
			CommonsMultipartFile uploadfile = (CommonsMultipartFile) files.get(fileName);
			if(uploadfile.getSize() != 0) {
				Image image = new Image();
				image.setProduct(book);
				book.getImages().add(image);
				String imgURI = null;
				if (!uploadfile.isEmpty()) {
					String realPath = "C://home//upload//book//";//硬地址
					File dirPath = new File(realPath);
					if (!dirPath.exists()){
						dirPath.mkdirs();
					} 
					String imgFlag = fileName.substring(0, fileName.length()-3);
					String imgName = UUID.randomUUID().toString()+ imgFlag + ".jpg";
					imgURI =realPath + imgName;
					if(imgFlag.equals("main")){
						book.setMainImgUrl(imgURI);
					}
					File imgFile = new File("C://home//123//" + imgName);
					try {
						uploadfile.getFileItem().write(imgFile);
						CompressImg.compressImgMethod(imgFile, realPath, imgName, 500, 450, false);
					} catch (Exception e) {
					e.printStackTrace();
					}
				}
				image.setImageUrl(imgURI);
			}
		}
		
		book.setProductName(bookName);
		book.setPrice(Float.parseFloat(fixedPrice));
		book.setFixedPrice(Float.parseFloat(fixedPrice));
		book.setPromotionPrice(Float.parseFloat(fixedPrice));
		book.setInventory(Integer.parseInt(pro_count));
		book.setSalesNum(0);
		book.setKeyWord(pro_name);
		book.setAssessNum(0);
		book.setInTime(TimeUtil.yyyyMMdd());
		book.setIsbn(ISBN);
		book.setSuit(pack_style);
		book.setPublisher(publisher);
		book.setPublishTime(publishTime);
		book.setAuthor(author);
		book.setAuthorRegion(authorRegion);
		book.setTranslator(translator);
		book.setEditor(editor);
		book.setFormat(format);
		book.setPrintTime(printTime);
		book.setPages(Integer.parseInt(pages));
		book.setWordCount(Long.parseLong(wordCount));
		book.setSeller((Seller) request.getSession().getAttribute("current_seller"));//查询seller表获得seller
		book.setProductId(productID);
		
		String descriptionGZ = GZipUtil.gzip(description);
		if(descriptionGZ.length()>0 && descriptionGZ.length()<5000){
			book.setDescription(descriptionGZ);
		}
		
		sellerService.addGoods(book);
		return "/seller/addProSuccess";
	}
	
	@RequestMapping("/toGoodsDetail")
	public String toGoodsDetail(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, NoSuchAlgorithmException{
		request.setCharacterEncoding("utf-8");
		String goodsId = request.getParameter("id");
		if(goodsId.substring(0, 6).equals("000001")){
			FruitGoods fruitGoods = (FruitGoods) productService.getProductById(goodsId);
			request.setAttribute("product", fruitGoods);
		}else if(goodsId.substring(0, 6).equals("000002")){
			BookGoods bookGoods = (BookGoods) productService.getProductById(goodsId);
			request.setAttribute("product", bookGoods);
		}
		return "/seller/product_fruit";
	}
	
	@RequestMapping(value="/delFromShop")
	@ResponseBody
	public String removeItemFromShop(HttpServletRequest request, String itemId) {
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller==null){
			return "0";
		}else{
			if(sellerService.delProduct(itemId)){
				seller = sellerService.findseller(seller.getsellerID());
				request.getSession().setAttribute("current_seller", seller);
				request.getSession().setAttribute("proSell", seller.getProducts());
				System.out.println("success*******************************");
				return "1";
			}else{
				System.out.println("failure*******************************");
				return "0";				
			}
		}
		
		//return "1";
	}
	

	@RequestMapping(value="/addInStock")
	@ResponseBody
	public String addInStock(HttpServletRequest request, String itemId, String addCount) {
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller==null){
			return "0";
		}else{
			Set<Product> products = seller.getProducts();
			for(Product product: products){
				if(product.getProductId().equals(itemId)){
					product.setInventory(product.getInventory()+Integer.parseInt(addCount));
					sellerService.addInStock(product);
					request.getSession().setAttribute("current_seller", sellerService.findseller(seller.getsellerID()));
					request.getSession().setAttribute("proSell", seller.getProducts());
					return "1";
				}
			}
			return "0";
		}
	}
	
	@RequestMapping(value="/createShop")
	@ResponseBody
	public String createShop(HttpServletRequest request, String shopName) {
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller==null){
			return "0";
		}else{
			Shop shop = new Shop();
			shop.setShopId(seller.getsellerID()+"");
			shop.setShopName(shopName);
			shop.setEvaluateNum(0);
			seller.setShop(shop);
			sellerService.updateSeller(seller);
			seller = sellerService.findseller(seller.getsellerID());
			shop = seller.getShop();
			request.getSession().setAttribute("seller", seller);
			request.getSession().setAttribute("shop", shop);			
			return "1";
		}
		
		//return "1";
	}
	
	@RequestMapping(value="/authSeller")
	@ResponseBody
	public String authSeller(HttpServletRequest request, String trueName, String idFlag, String idNumber) {
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller==null){
			return "0";
		}else{
			seller.setTrueName(trueName);
			seller.setIdFlag(Integer.parseInt(idFlag));
			seller.setIdentification(idNumber);
			sellerService.updateSeller(seller);
			seller = sellerService.findseller(seller.getsellerID());
			request.getSession().setAttribute("seller", seller);
			request.getSession().setAttribute("shop", seller.getShop());	
			return "/seller/left";
		}
		
		//return "1";
	}
	
	@RequestMapping(value="/postGoods")
	@ResponseBody
	public String postGoods(HttpServletRequest request, String orderId, String logistics) throws ParseException {
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller==null){
			return "0";
		}else{
			List<OrderItem> orders = sellerService.getOrderItems(orderId);
			String logisticsId="00"+logistics+TimeUtil.getTimeMinis();
			for(OrderItem order:orders){
				order.setOrderStatus(2);
				order.setConveyType(Integer.parseInt(logistics));
				order.setLogisticsId(logisticsId);
			}
			sellerService.postGoods(orders);
			//request.getSession().setAttribute("current_seller", sellerService.findseller(seller.getUsername()));
			
			return "1";
		}
		
		//return "1";
	}
	
	@RequestMapping(value="/modifyPwd")
	@ResponseBody
	public String modifyPwd(HttpServletRequest request, String oldPwd, String newPwd, String confirmPwd) throws ParseException, NoSuchAlgorithmException {
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller==null){
			return "0";
		}else{
			if(seller.getPassword().equals(SecurityUtil.AESCode(oldPwd))){
				seller.setPassword(SecurityUtil.AESCode(newPwd));
				sellerService.updateSeller(seller);
			}else{
				return "2";
			}
			request.getSession().setAttribute("current_seller", sellerService.findseller(seller.getsellerID()));			
			return "1";
		}
		
		//return "1";
	}
	
	@RequestMapping(value="/updateInfo")
	@ResponseBody
	public String updateInfo(HttpServletRequest request, String nickName, String sellerNum, String birthday, String sellerAddr) throws ParseException {
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller==null){
			return "0";
		}else{
			seller.setsellerName(nickName);
			seller.setTelNum(sellerNum);
			//seller.setBirthday(birthday);
			seller.setLocalAddr(sellerAddr);
			sellerService.updateSeller(seller);
			request.getSession().setAttribute("current_seller", sellerService.findseller(seller.getsellerID()));
			
			return "1";
		}
		
		//return "1";
	}
	
	@RequestMapping(value="/dealCancelApply")
	@ResponseBody
	public String dealCancelApply(HttpServletRequest request, String id, String userName){
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller==null){
			return "0";
		}else{
			OrderItem waitCancelOrder = productService.getOrderByLongID(Long.parseLong(id));
			Buyer buyer = waitCancelOrder.getBuyer();
			buyer.setAccount(buyer.getAccount()+waitCancelOrder.getCurrentPrice());			
			waitCancelOrder.setOrderStatus(6);
			productService.updateOrder(waitCancelOrder);
			request.getSession().setAttribute("current_seller", sellerService.findseller(seller.getsellerID()));			
			return "1";
		}
		
		//return "1";
	}
	
	@RequestMapping(value="/refuseCancelApply")
	@ResponseBody
	public String refuseCancelApply(HttpServletRequest request, String id){
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller==null){
			return "0";
		}else{
			OrderItem waitCancelOrder = productService.getOrderByLongID(Long.parseLong(id));
			waitCancelOrder.setOrderStatus(7);
			productService.updateOrder(waitCancelOrder);
			request.getSession().setAttribute("current_seller", sellerService.findseller(seller.getsellerID()));
			
			return "1";
		}
		
		//return "1";
	}
	
	@RequestMapping(value="/scoreBuyer")
	@ResponseBody
	public String scoreBuyer(HttpServletRequest request, String id,String score){
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller==null){
			return "0";
		}else{
			OrderItem order = productService.getOrderByLongID(Long.parseLong(id));
			Buyer buyer = order.getBuyer();
			buyer.setBuyerRate(buyer.getBuyerRate()+Integer.parseInt(score));
			order.setOrderStatus(8);
			productService.updateOrder(order);
			return "1";
		}
		
		//return "1";
	}
}

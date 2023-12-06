<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file = "dbconn.jsp" %>
<%
    PreparedStatement pstmt = null;
    //ResultSet rs = null;
    String orderDate = request.getParameter("orderDate");
    String orderName = request.getParameter("orderName");
    String productId = request.getParameter("productId");
    String unitPrice = request.getParameter("unitPrice");
    String orderQty = request.getParameter("orderQty");
    String address = request.getParameter("orderAddress");
    
    try {
    	String sql = "insert into order0822 values(?,?,?,?,?,?)";
    	pstmt = conn.prepareStatement(sql);
    	pstmt.setString(1, orderDate);
    	pstmt.setString(2, orderName);
    	pstmt.setString(3, productId);
    	pstmt.setString(4, unitPrice);
    	pstmt.setString(5, orderQty);
    	pstmt.setString(6, address);
    	pstmt.executeUpdate();
    	
    	//재고 마이너스, 상품코드를 읽어서 재고를 가져와 빼기해줌
    	
    	//int stock=0;
    	//sql="select unitsInstock from product0822 where productId=?";
    	
    	int stock=Integer.parseInt(orderQty);
    	sql="update product0822 set unitsInstock=unitsInstock - ? where productId=?"; 
    	pstmt=conn.prepareStatement(sql);
    	pstmt.setInt(1, stock);   //stock을 데이터가 바로 인식하지 못해서 stock->?로 바꿈
    	pstmt.setString(2, productId);
    	pstmt.executeUpdate();    //db에 반영시켜주는 명령
    	%>
    	<script>
    	alert("주문정보 등록 성공");
    	location.href = "orderSelect.jsp";
    	</script>
    	<%

    }catch(Exception e) {
    	System.out.println("등록 오류:" +e.getMessage());
    }
%>

</body>
</html>
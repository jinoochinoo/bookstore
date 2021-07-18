<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<c:if test="${message=='cancel_order'}">
	<script>
	window.onload=function()
	{
	  init();
	}

	function init(){
		alert("주문을 취소했습니다.");
	}
	</script>
</c:if>
<script>
function fn_cancel_order(order_id){
	var answer=confirm("주문을 취소하시겠습니까?");
	if(answer==true){
		var formObj=document.createElement("form");
		var i_order_id = document.createElement("input"); 
	    
	    i_order_id.name="order_id";
	    i_order_id.value=order_id;
		
	    formObj.appendChild(i_order_id);
	    document.body.appendChild(formObj); 
	    formObj.method="post";
	    formObj.action="${contextPath}/mypage/cancelMyOrder.do";
	    formObj.submit();	
	}
}

</script>
</head>
<body>
<h1>최근주문내역
    <a href="#"> <img  src="${contextPath}/resources/image/btn_more_see.jpg">  </a> 
</h1>
<table class="list_view">
		<tbody align=center >
			<tr style="background:#33ff00" >
				<td>주문번호</td>
				<td>주문일자</td>
				<td>주문상품</td>
				<td>주문취소</td>
			</tr>
      <c:choose>
         <c:when test="${empty myOrderList}">
		  <tr>
		    <td colspan=5 class="fixed">
				  <strong>주문한 상품이 없습니다.</strong>
		    </td>
		  </tr>
        </c:when>
        <c:otherwise>
	      <c:forEach var="item" items="${myOrderList}"  varStatus="i">
	       <c:choose> 
              <c:when test="${pre_order_id != item.order_id}"> 
            <tr>
             <td>
		       <a href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id}"><span>${item.order_id}</span>  </a>
		     </td>
		    <td><span>${item.pay_order_time}</span></td>
			<td align="left">
			 	<strong>
			    	<c:forEach var="item2" items="${myOrderList}" varStatus="j">
			        	<c:if  test="${item.order_id ==item2.order_id}" >
			            	<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }">${item2.goods_title }/${item.order_goods_qty}개</a><br>
			        	</c:if>   
					</c:forEach>
				</strong>
			</td>
			<td>
				<input  type="button" onClick="fn_cancel_order('${item.order_id}')" value="주문취소"  />
			</td>
			</tr>
          	<c:set  var="pre_order_id" value="${item.order_id}" />
           </c:when>
      	</c:choose>
	  </c:forEach>
	</c:otherwise>
  </c:choose> 	    
</tbody>
</table>

<br><br><br>	
<h1>나의 정보
    <a href="#"> <img  src="${contextPath}/resources/image/btn_more_see.jpg" />  </a>
</h1>
<table border=0 width=100% cellpadding=10 cellspacing=10>
  <tr>
    <td>
	   이메일:
   </td>
    <td>
	   <strong>${memberInfo.email1 }@${memberInfo.email2}</strong>
   </td>
   </tr>
   <tr>
    <td>
	   전화번호 
   </td>
    <td>
	   <strong>${memberInfo.hp1}-${memberInfo.hp2}-${memberInfo.hp3}</strong>
   </td>
   </tr>
   <tr>
    <td>
	  주소 
   </td>
    <td>
		<strong>${memberInfo.address }</strong>
   </td>
   </tr>
</table>
</body>
</html>

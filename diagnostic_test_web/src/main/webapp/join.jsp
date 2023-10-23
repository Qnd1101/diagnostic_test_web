<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈화면</title>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript">
function checkValue() {
    if (!document.data.p_no.value) {
        alert("환자번호가 입력되지 않았습니다!");
        document.data.p_no.focus();
        return false;
    } else if (!document.data.t_code.value) {
        alert("검사코드가 선택되지 않았습니다!");
        document.data.t_code.focus();
        return false;
    } else if (!document.data.t_sdate.value) {
        alert("검사시작일자가 입력되지 않았습니다!");
        document.data.t_sdate.focus();
        return false;
    } else if (!document.data.t_status[0].checked && !document.data.t_status[1].checked) {
        alert("검사상태가 선택되지 않았습니다!");
        return false;
    } else if (!document.data.t_ldate.value) {
        alert("검사완료일자가 입력되지 않았습니다!");
        document.data.t_ldate.focus();
        return false;
    } else if (!document.data.t_result[0].checked && !document.data.t_result[1].checked && !document.data.t_result[2].checked) {
        alert("검사결과가 선택되지 않았습니다!");
        return false;
    }

    alert("검사결과가 정상적으로 등록 되었습니다!");
    return true;
}

function refe() {
	alert("정보를 지우고 처음부터 다시 입력 합니다!");
	return location.href='join.jsp';
}
</script>
</head>
<body>
<header>
	<jsp:include page="layout/header.jsp"></jsp:include>
</header>
<nav>
	<jsp:include page="layout/nav.jsp"></jsp:include>
</nav>
<section class = "section">
	<h2>검사결과입력</h2>
	<form action="join_p.jsp" method="post" name="data" onsubmit="return checkValue()">
	<table border="1" style="margin-left:auto; margin-right: auto;">
		<tr>
			<th>환자번호</th>
			<td><input type="text" name="p_no" size="10">예)1001</td>
		</tr>
		<tr>
			<th>검사코드</th>
			<td>
			<select name="t_code">
				<option value="">검사명</option>
				<option value="T001">[T001]결핵</option>
				<option value="T002">[T002]장티푸스</option>
				<option value="T003">[T003]수두</option>
				<option value="T004">[T004]홍역</option>
				<option value="T005">[T005]콜레라</option>
			</select>
			</td>
		</tr>
		<tr>
			<th>검사시작일자</th>
			<td><input type="text" name="t_sdate" size="10">예)20200101</td>
		</tr>
		<tr>
			<th>검사상태</th>
			<td>
				<input type="radio" name="t_status" value="1">검사중
				<input type="radio" name="t_status" value="2">검사완료
			</td>
		</tr>
		<tr>
			<th>검사완료일자</th>
			<td><input type="text" name="t_ldate" size="10">예)20200101</td>
		</tr>
		<tr>
			<th>검사결과</th>
			<td>
				<input type="radio" name="t_result" value="X">미입력 
				<input type="radio" name="t_result" value="P">양성
				<input type="radio" name="t_result" value="N">음성 
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;">
				<input type="submit" value="검사결과등록">
				<input type="button" value="다시쓰기" onclick="refe()">
			</td>
		</tr>
	</table>
	</form>
</section>
<footer>
	<jsp:include page="layout/footer.jsp"></jsp:include>
</footer>
</body>
</html>
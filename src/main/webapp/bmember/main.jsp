<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="css/tiny-slider.css" />
<link rel="stylesheet" href="css/style.css" />
<script type="text/javascript"
	src="http://code.jquery.com/jquery-2.1.4.js"></script>
<script type="text/javascript" src="js/searchBook.js"></script>
<style>
.site-nav {
	position: absolute;
}
</style>
<title>main</title>
</head>
<body>

	<div class="site-mobile-menu site-navbar-target">
		<div class="site-mobile-menu-header">
			<div class="site-mobile-menu-close">
				<span class="icofont-close js-menu-toggle"></span>
			</div>
		</div>
		<div class="site-mobile-menu-body"></div>
	</div>

	<jsp:include page="../include/top.jsp"></jsp:include>

	<div class="hero">
		<div class="hero-slide">
			<div class="img overlay"
				style="background-image: url('bmg/books-016.jpg')"></div>
			<div class="img overlay"
				style="background-image: url('bmg/books-012.jpg')"></div>
			<div class="img overlay"
				style="background-image: url('bmg/books-001.jpg')"></div>
		</div>

		<div class="container">
			<div class="row justify-content-center align-items-center">
				<div class="col-lg-9 text-center">
					<h1 class="heading" data-aos="fade-up">쉽고 빠르게 검색해보세요</h1>
					<form class="narrow-w form-search d-flex align-items-stretch mb-3"
						data-aos="fade-up" data-aos-delay="200" id="searchForm">
						<input type="text" class="form-control px-4"
							placeholder="검색어를 입력해주세요" name="searchKeyWord" id="searchF">
						<button type="submit" class="btn btn-primary">Search</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="js/bootstrap.bundle.min.js"></script>
	<script src="js/tiny-slider.js"></script>
	<script src="js/aos.js"></script>
	<script src="js/custom.js"></script>
</body>
</html>

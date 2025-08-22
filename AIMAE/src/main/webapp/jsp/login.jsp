<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AIMAE</title>

    <!-- Favicon -->
    <link rel="icon" href="../images/favicon.ico" sizes="52x52" type="image/png">

    <!-- Style -->
    <link rel="stylesheet" href="../css/index.css">
    <link rel="stylesheet" href="../css/footer.css">
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/login.css">
    <link rel="stylesheet" href="../css/myPage.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

</head>

<body>

    </div>

    <!-- Login -->
    <div class="login-box">

        <div class="login-container">

            <h1 class="login-logo"><a href="../index.jsp" class="logo">AIMAE</a></h1>

            <form action="/AIMAE/AimaeLoginService" method="post">
                <div class="login-form">
                    <input style="width: 22.9rem !important;" type="text" name="USER_ID" placeholder="아이디를 입력해주세요.">
                    <input style="width: 22.9rem !important;" type="password" name="PASSWORD" placeholder="비밀번호를 입력해주세요.">
                    <button type="submit">로그인</button>
                </div>
            </form>
				<div class="social-login2">
	                <button class="social-btn kakao" aria-label="카카오 로그인" onclick="oauthLogin('kakao')">
	                    <img src="../images/kakao.png" alt="카카오 로그인" />
	                </button>
	                <button class="social-btn google" aria-label="구글 로그인" onclick="oauthLogin('google')">
	                    <img src="https://www.svgrepo.com/show/355037/google.svg" alt="구글 로그인" />
	                </button>
	                <button class="social-btn naver" aria-label="네이버 로그인" onclick="oauthLogin('naver')">
	                    <img src="https://blog.kakaocdn.net/dna/bU1uVm/btqGsLHK8Ha/AAAAAAAAAAAAAAAAAAAAAGoZUlR2gBNJysd7x3kViluaRJ-de7a9HNJ7XOCX4W-Z/img.png?credential=yqXZFxpELC7KVnFOS48ylbz2pIh7yKj8&amp;expires=1756652399&amp;allow_ip=&amp;allow_referer=&amp;signature=q0DeRdE%2BKPMovqMItwp%2Fuk5%2BoHY%3D" alt="네이버 로그인" />
	                </button>
            	</div>
            	
                <div class="login-span">
                    <span><a href="findID.jsp">아이디 찾기</a></span> <a style="color: #939393;">|</a>
                    <span><a href="findPw.jsp">비밀번호 찾기</a></span> <a style="color: #939393;">|</a>
                    <span><a href="join.jsp">회원가입</a></span>
                </div>

        </div>

    </div>

    <!-- Footer -->

    <div class="footer">

        <div class="footer-content">

            <div class="footer-section">
                <h4 style="margin-bottom: 22px;">회사 정보</h4>
                <p class="footer-p">주소 : 서울특별시 강남구</p>
                <p class="footer-p">전화 : 010-1234-5678</p>
                <p class="footer-p">이메일 : support@aimae.com</p>
            </div>
        
            <div class="footer-section">
                <h4>고객센터</h4>
                <ul>
                    <li class="footer-tag"><a href="#">FAQ</a></li>
                    <li class="footer-tag"><a href="#">반품/교환</a></li>
                    <li class="footer-tag"><a href="#">배송정보</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h4>소셜 미디어</h4>

                <div class="social-icons">
                    <a href="https://www.facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a>
                    <a href="https://www.twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
                    <a href="https://www.instagram.com/chan2hee1" target="_blank"><i class="fab fa-instagram"></i></a>
                    <a href="https://www.linkedin.com" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                </div>
				<div>
                    <img src="../images/favicon.ico" alt="" style="width: 5rem;">
                </div>
				
            </div>

        </div>

        <div class="footer-bottom">
            <p>&copy; 2025 AIMAE</p>
        </div>
    </div>

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script src="../js/index.js"></script>

    <!-- 드롭다운 -->
    <script>
        document.addEventListener('DOMContentLoaded', () => {
        const dropdown = document.querySelector('.dropdown');
        const btn = dropdown.querySelector('.category-logo');

            btn.addEventListener('click', (e) => {
                e.preventDefault();
                dropdown.classList.toggle('show');
            });

            window.addEventListener('click', (e) => {
                if (!dropdown.contains(e.target)) {
                dropdown.classList.remove('show');
                }
            });
        });
    </script>
    
    <!-- 로그인 -->
    <script>
        function oauthLogin(provider) {
            const routes = {
                kakao:  "/oauth2/authorization/kakao",
                google: "/oauth2/authorization/google",
                naver:  "/oauth2/authorization/naver"
            };
            const url = routes[provider] || "#";
            window.location.href = url;
        }
    </script>

</body>
</html>
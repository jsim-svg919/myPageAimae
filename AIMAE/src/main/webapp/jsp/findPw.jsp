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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

</head>

<body>

    </div>

    <!-- findPW -->
    <div class="login-box">

        <div class="login-container">
            
            <div class="login-header">
                <h1 class="login-logo"><a href="../index.jsp" class="logo">AIMAE</a></h1>
                <h1 class="login-logo" style="margin-top: 1.45rem !important; font-size: 20px !important;">비밀번호 찾기</h1>
            </div>

                <div class="login-form">

                    <div>
                        <input style="width: 22.9rem !important;" type="text" name="" value="" placeholder="아이디를 입력해주세요.">
                    </div>

                    <div class="form-input">
                        <input id="email" type="text" name="" placeholder="이메일 입력해주세요.">
                        <button type="button" onclick="" class="btn-2">인증번호 전송</button>
                    </div>

                    <div class="form-input">
                        <input type="text" name="auth_code" value="" placeholder="인증번호를 입력해주세요.">
                        <button type="button" onclick="" class="btn-2">인증번호 확인</button>
                    </div>

                    <button type="button" onclick="">비밀번호 찾기</button>

                </div>

                <div class="login-span">
                    <span><a href="findID.jsp">아이디 찾기</a></span> <a style="color: #939393;">|</a>
                    <span><a href="login.jsp">로그인</a></span> <a style="color: #939393;">|</a>
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

</body>
</html>
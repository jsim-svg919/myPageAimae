<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>AIMAE</title>

  <!-- Favicon -->
  <link rel="icon" href="../images/favicon.ico" sizes="52x52" type="image/png">

  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/header.css">
  <link rel="stylesheet" href="../css/footer.css">
  <link rel="stylesheet" href="../css/cart.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
  
</head>
<body>

  <!-- Header -->
  <div class="header">

    <div class="brand">

      <div class="dropdown">
        <button class="category-logo">
          <span><i class="fa-solid fa-bars"></i></span>
        </button>

        <div class="dropdown-content">
          <a href="fruitProducts.jsp">과일</a>
          <a href="vegetableProducts.jsp">채소</a>
          <a href="electronicProducts.jsp">전자제품</a>
        </div>

      </div>

      <a href="../index.jsp" class="logo">
        <span style="margin-left: 10px;">AIMAE</span>
      </a>
      
    </div>

    <!-- 로그인 / 로그아웃 헤더 변경 -->
	<%@ include file="../loginheader2.jsp" %>

  </div>

  <!-- 장바구니 본문 -->
  <div class="cart-container">
    <div class="cart-header">
      <h2>장바구니</h2>
      <span id="cart-count">총 2개의 상품</span>
    </div>
    <div style="border-bottom: 1px solid #8c52ff; margin-bottom: 2rem;"></div>

    <table class="cart-table">
      <thead>
        <tr>
          <th>상품</th>
          <th>상품명</th>
          <th>가격</th>
          <th>수량</th>
          <th>합계</th>
          <th>삭제</th>
        </tr>
      </thead>

      <tbody id="cart-body">
  <tr data-price="20000">
    <td>
      <input type="checkbox" class="item-checkbox" checked />
      <img src="../images/favicon.ico" alt="상품1" style="margin-left: 10px; vertical-align: middle;" />
    </td>
    <td>예쁜 티셔츠</td>
    <td>₩20,000</td>
    <td><input type="number" value="1" min="1" class="qty-input" /></td>
    <td class="subtotal">₩20,000</td>
    <td><button class="remove-btn">삭제</button></td>
  </tr>
  <tr data-price="35000">
    <td>
      <input type="checkbox" class="item-checkbox" checked />
      <img src="../images/favicon.ico" alt="상품2" style="margin-left: 10px; vertical-align: middle;" />
    </td>
    <td>귀여운 니트</td>
    <td>₩35,000</td>
    <td><input type="number" value="2" min="1" class="qty-input" /></td>
    <td class="subtotal">₩70,000</td>
    <td><button class="remove-btn">삭제</button></td>
  </tr>
</tbody>
    </table>

    <div class="cart-summary">
      <div class="total-price" id="total-price">총 결제 금액: ₩90,000</div>
      <button class="checkout-btn">결제하기</button>
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

  <!-- 계산 JS -->
  <script>
    function formatPrice(num) {
      return '₩' + num.toLocaleString();
    }

    function updateCart() {
      const rows = document.querySelectorAll('#cart-body tr');
      let total = 0;
      let count = 0;

      rows.forEach(row => {
        const checkbox = row.querySelector('.item-checkbox');
        if (checkbox && checkbox.checked) {
          const price = parseInt(row.dataset.price);
          const qty = parseInt(row.querySelector('.qty-input').value);
          const subtotal = price * qty;
          row.querySelector('.subtotal').innerText = formatPrice(subtotal);
          total += subtotal;
          count += 1;
        } else {
          row.querySelector('.subtotal').innerText = formatPrice(0);
        }
      });

      document.getElementById('total-price').innerText = '총 결제 금액: ' + formatPrice(total);
      document.getElementById('cart-count').innerText = '총 ' + count + '개의 상품';
    }

    document.addEventListener('DOMContentLoaded', () => {
      document.querySelectorAll('.qty-input').forEach(input => {
        input.addEventListener('change', () => {
          if (input.value < 1) input.value = 1;
          updateCart();
        });
      });

      document.querySelectorAll('.remove-btn').forEach(btn => {
        btn.addEventListener('click', () => {
          const row = btn.closest('tr');
          row.remove();
          updateCart();
        });
      });

      document.querySelectorAll('.item-checkbox').forEach(checkbox => {
        checkbox.addEventListener('change', () => {
          updateCart();
        });
      });

      updateCart();
    });
</script>


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

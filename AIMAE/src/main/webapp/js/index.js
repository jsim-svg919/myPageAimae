// index.jsp에서 window.CONTEXT_PATH가 정의 안 돼도 에러 안 나게 || "" 처리.
var CONTEXT_PATH = window.CONTEXT_PATH || "";

// 페이지 식별
var IS_RECOM = document.body.classList.contains("page-recom");
var IS_INDEX = document.body.classList.contains("page-index");


// index.jsp에서는 /ask 관련 함수들을 무력화 (세이프가드)
if (!IS_RECOM) {
	window.sendAsk = function() { return false; };
	window.renderResult = function() { };
}

// /ask로 질문/이미지 전송하는 함수
function sendAsk() {
	var ASK_URL = "http://127.0.0.1:5000/ask";
	var question = $("#search-input").val().trim();
	var fileIn = $("#file-input")[0];

	if (!question && (!fileIn || fileIn.files.length === 0)) {
		alert("질문이나 이미지를 입력하세요.");
		return;
	}

	// 로딩 표시(로딩중에 다른거 작업 못하게)
	setLoading(true);

	// 파일이 있으면 → FormData로 전송 (recom.jsp에서만 호출됨)
	if (fileIn && fileIn.files.length > 0) {
		var fd = new FormData();
		fd.append("question", question);
		fd.append("image", fileIn.files[0]); // app.py가 'image' 키로 받는 기준

		$.ajax({
			url: ASK_URL,
			type: "POST",
			data: fd,
			processData: false,
			contentType: false,
			success: function(res) {
				setLoading(false);
				renderResult(res);
				$("#clear-preview").click(); // 미리보기 정리(선택)
			},
			error: function(xhr) {
				setLoading(false);
				alert("서버 요청 중 오류: " + (xhr.responseText || xhr.statusText));
			}
		});
		return; // ← 여기서 끝
	}

	// 텍스트만 있으면 JSON
	$.ajax({
		url: ASK_URL,
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({ question: question }),
		success: function(res) {
			setLoading(false);
			renderResult(res);
		},
		error: function(xhr) {
			setLoading(false);
			alert("서버 요청 중 오류: " + (xhr.responseText || xhr.statusText));
		}
	});
}

// Flask 응답 → 화면 반영
function renderResult(res) {
	console.log("서버 응답:", res);

	// 1. answer 반영
	$(".content-product-header").text(res.answer || " ");

	// 2. products 반영
	var slider = $("#product-slider2");
	slider.empty();  // 기존 카드 지우기

	if (res.products && res.products.length > 0) {
		res.products.forEach(function(p) {
			var card = `
                <div class="product-list-box">
                    <a href="productDetail.jsp" class="list-pbox">
                        <img src="${p.IMAGE_URL || '../images/favicon.ico'}" alt="상품 이미지" class="product-img">
                        <div class="product-info">
                            <h3 class="product-name" title="${p.PRODUCT_NAME || ''}">${p.PRODUCT_NAME || '이름 없음'}</h3>
                            <p class="product-price">₩${p.PRICE || '정보 없음'}</p>
                            <button class="add-cart-btn"><i class="fas fa-shopping-cart"></i> 장바구니</button>
                        </div>
                    </a>
                </div>`;
			slider.append(card);
		});
	} else {
		slider.append("<p>추천 가능한 상품이 없습니다.</p>");
	}


	//  추천 상세 비교표 채우기
	var tbody = $("#recommend-tbody");
	tbody.empty();

	if (res.products && res.products.length > 0) {
		res.products.forEach(function(p) {
			var row = `
	            <tr>
	                <td title="${p.PRODUCT_NAME || ''}">
	                    ${p.PRODUCT_NAME || '이름 없음'}
	                </td>
	                <td>${p.PRICE ? '₩' + p.PRICE : '정보 없음'}</td>
	                <td>${p.PRD_INFO || '정보 없음'}</td>
	                <td>${p.PRD_INFO ? p.PRD_INFO.slice(0, 30) + '…' : '정보 없음'}</td>
	            </tr>`;
			tbody.append(row);
		});
	} else {
		tbody.append(`
	        <tr>
	            <td colspan="4" style="text-align:center; color:#666;">
	                추천 가능한 상품이 없습니다.
	            </td>
	        </tr>
	    `);
	}
}

// page-recom일때만 /ask 이벤트 실행되게
if (IS_RECOM) {
	
	// page-recom 전용: sessionStorage 이미지 복구 → #file-input에 주입
	$(function(){
	  if (!document.body.classList.contains('page-recom')) return;

	  var dataURL = sessionStorage.getItem('aimae_image_data');
	  var name    = sessionStorage.getItem('aimae_image_name');
	  var type    = sessionStorage.getItem('aimae_image_type') || 'image/jpeg';

	  if (dataURL) {
	    try {
	      var arr = dataURL.split(',');
	      var bstr = atob(arr[1]);
	      var len = bstr.length, u8 = new Uint8Array(len);
	      for (var i=0; i<len; i++) u8[i] = bstr.charCodeAt(i);
	      var blob = new Blob([u8], { type: type });
	      var file = new File([blob], name || 'upload.jpg', { type: type });

	      var dt = new DataTransfer();
	      dt.items.add(file);
	      var fileEl = document.getElementById('file-input');
	      if (fileEl) fileEl.files = dt.files;

	      // (선택) 미리보기도 즉시 반영
	      if ($("#preview").length) {
	        $("#preview").attr("src", dataURL).show();
	        $("#clear-preview").show();
	        $("#image-status").text(name || "");
	      }
	    } catch(e) {
	      console.warn('이미지 복구 실패:', e);
	    } finally {
	      // 사용 후 정리
	      sessionStorage.removeItem('aimae_image_data');
	      sessionStorage.removeItem('aimae_image_name');
	      sessionStorage.removeItem('aimae_image_type');
	      sessionStorage.removeItem('aimae_image_size');
	    }
	  }
	});
	
	// /ask 이벤트, 자동실행(q 읽기) 등 넣기
	$("#search-icon").on("click", function(e) { e.preventDefault(); sendAsk(); });
	$("#search-input").on("keydown", function(e) { if (e.key === "Enter") { e.preventDefault(); sendAsk(); } });

	// q 파라미터 자동 실행
	$(function() {
		var q = new URLSearchParams(location.search).get("q");
		if (q && q.trim()) {
			$("#search-input").val(q.trim());
			setTimeout(function() { sendAsk(); }, 0);
		}
	});
}


// 이미지 업로드 & 미리보기, sendAsk()로 이미지 보내기
(function() {
	var MAX_MB = 5;
	var ALLOW = ["image/jpeg", "image/png", "image/webp", "image/gif"];

	// 1) 아이콘 클릭 → 파일 선택창
	$("#image-icon").on("click", function(e) {
		e.preventDefault();
		$("#file-input").click();
	});

	// 2) 파일 선택 시 미리보기 + 검증
	$("#file-input").on("change", function() {
		var f = this.files && this.files[0];
		if (!f) return;

		// (a) 타입 검증
		if (ALLOW.indexOf(f.type) === -1) {
			alert("이미지 파일(JPG/PNG/WebP/GIF)만 업로드할 수 있어요.");
			clearPreview();
			return;
		}
		// (b) 용량 검증
		var sizeMB = (f.size / (1024 * 1024)).toFixed(2);
		if (f.size > MAX_MB * 1024 * 1024) {
			alert("파일이 너무 커요. 최대 " + MAX_MB + "MB까지 가능합니다.");
			clearPreview();
			return;
		}

		// (c) 미리보기 표시
		var reader = new FileReader();
		reader.onload = function(e) {
			$("#preview").attr("src", e.target.result).show();
			$("#clear-preview").show();
			$("#image-status").text(f.name + " (" + sizeMB + "MB)");

			// recom.jsp에서만 자동 전송
			if (document.body.classList.contains("page-recom")) {
				if (!$("#search-input").val().trim()) {
					$("#search-input").val("이미지 추천 요청");
				}
				setTimeout(function() { sendAsk(); }, 0);
			}
		};
		reader.readAsDataURL(f);
	});

	// 3) 미리보기 초기화
	$("#clear-preview").on("click", function() {
		clearPreview();
	});

	function clearPreview() {
		var $file = $("#file-input");
		$file.val("");                              // 파일 리셋
		$("#preview").attr("src", "").hide();       // 썸네일 숨김
		$("#clear-preview").hide();                 // X 버튼 숨김
		$("#image-status").text("");                // 상태 텍스트 초기화
	}
})();


// 로딩 상태 헬퍼(setLoading 중 버튼 눌림 방지)
var $askBtn = $("#search-icon");
function setLoading(on) {
	if (on) {
		$askBtn.addClass("disabled").css("pointer-events", "none").css("opacity", "0.5");
		$(".content-product-header").text("분석 중입니다… 잠시만요");
	} else {
		$askBtn.removeClass("disabled").css("pointer-events", "").css("opacity", "");
	}
}

if (IS_INDEX) {
	// index.jsp → recom.jsp 이동 (텍스트만)
	function gotoRecom(e){
	  if (e) { e.preventDefault(); e.stopPropagation(); }

	  var q = $("#search-input").val().trim();
	  if (!q) { alert("검색어를 입력해 주세요."); return false; }

	  var CONTEXT_PATH = window.CONTEXT_PATH || "";
	  var url = CONTEXT_PATH + '/jsp/recom.jsp?q=' + encodeURIComponent(q);

	  var fileEl = document.getElementById('file-input');
	  var file = fileEl && fileEl.files && fileEl.files[0];
	  if (!file) {
	    window.location.assign(url);
	    return false;
	  }

	  // 이미지 있으면: dataURL 저장 → 저장 끝난 뒤 이동
	  var reader = new FileReader();
	  reader.onload = function(ev){
	    try {
	      sessionStorage.setItem('aimae_image_data', ev.target.result);
	      sessionStorage.setItem('aimae_image_name', file.name || 'upload.jpg');
	      sessionStorage.setItem('aimae_image_type', file.type || 'image/jpeg');
	      sessionStorage.setItem('aimae_image_size', String(file.size || 0));
	    } catch (err) {
	      console.warn('sessionStorage 저장 실패:', err);
	    }
	    window.location.assign(url);
	  };
	  reader.readAsDataURL(file);
	  return false;
	}

	// 검색 버튼 클릭
	$("#search-icon").on("click", function(e) {
		e.preventDefault();
		gotoRecom();
	});

	// 엔터 키 입력
	$("#search-input").on("keypress", function(e) {
		if (e.which === 13) {
			e.preventDefault();
			gotoRecom();
		}
	});
}



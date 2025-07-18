# Stay Folio 코딩 가이드라인

## 📋 목차
1. [프로젝트 구조](#프로젝트-구조)
2. [네이밍 컨벤션](#네이밍-컨벤션)
3. [HTML 가이드라인](#html-가이드라인)
4. [CSS 가이드라인](#css-가이드라인)
5. [JavaScript 가이드라인](#javascript-가이드라인)
6. [파일 구조 규칙](#파일-구조-규칙)
7. [코드 품질 규칙](#코드-품질-규칙)

---

## 🏗️ 프로젝트 구조

### 디렉토리 구조
```
src/main/webapp/
├── WEB-INF/views/          # JSP/HTML 뷰 파일
│   ├── admin/              # 관리자 페이지
│   ├── login/              # 로그인 관련 페이지
│   ├── includes/           # 공통 컴포넌트 (header, footer)
│   └── home.jsp            # 메인 페이지
└── resources/
    ├── css/                # 스타일시트
    │   ├── common.css      # 공통 스타일
    │   ├── header.css      # 헤더 전용
    │   ├── footer.css      # 푸터 전용
    │   └── [module]/       # 모듈별 CSS 폴더
    ├── js/                 # JavaScript 파일
    └── icons/              # 아이콘 리소스
```

---

## 🏷️ 네이밍 컨벤션

### 파일명
- **HTML/JSP**: `camelCase.html` (예: `signupSuccess.html`)
- **CSS**: `kebab-case.css` (예: `login-form.css`)
- **JavaScript**: `camelCase.js` (예: `formValidator.js`)

### CSS 클래스명
```css
/* BEM 방법론 기반 */
.block-name {}              /* 블록 */
.block-name__element {}     /* 요소 */
.block-name--modifier {}    /* 수정자 */

/* 실제 예시 */
.login-page {}              /* 페이지 블록 */
.login-form {}              /* 폼 블록 */
.login-form__input {}       /* 폼의 입력 요소 */
.login-form__button {}      /* 폼의 버튼 요소 */
.login-form--disabled {}    /* 비활성화된 폼 */
```

### JavaScript 변수/함수명
```javascript
// 변수: camelCase
const userName = 'john';
const isValidEmail = true;

// 함수: camelCase (동사로 시작)
function validateEmail() {}
function handleSubmit() {}
function toggleVisibility() {}

// 상수: UPPER_SNAKE_CASE
const MAX_PASSWORD_LENGTH = 20;
const API_ENDPOINTS = {};

// jQuery 객체: $ 접두사
const $form = $('.login-form');
const $errorMessage = $('.error-message');
```

### ID 및 Name 속성
```html
<!-- kebab-case 사용 -->
<input id="user-email" name="user-email" />
<input id="confirm-password" name="confirm-password" />
<div id="error-message-container"></div>
```

---

## 📄 HTML 가이드라인

### 기본 구조
```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>페이지명 - Stay Folio</title>
    
    <!-- CSS 로드 순서 -->
    <link rel="stylesheet" href="../../../resources/css/common.css" />
    <link rel="stylesheet" href="../../../resources/css/header.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
    <link rel="stylesheet" href="../../../resources/css/[module]/[page].css" />
</head>
<body>
    <!-- 헤더 include -->
    <!-- 메인 콘텐츠 -->
    <!-- 푸터 include -->
    
    <!-- JavaScript 로드 (body 끝) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../../../resources/js/[module].js"></script>
</body>
</html>
```

### 시맨틱 HTML 사용
```html
<!-- 좋은 예 -->
<main class="login-page">
    <section class="login-form-section">
        <h2 class="login-title">LOGIN</h2>
        <form class="login-form" role="form">
            <fieldset>
                <legend class="sr-only">로그인 정보</legend>
                <div class="form-group">
                    <label for="user-email">이메일</label>
                    <input type="email" id="user-email" required />
                </div>
            </fieldset>
        </form>
    </section>
</main>

<!-- 피해야 할 예 -->
<div class="login-page">
    <div class="login-form">
        <div class="title">LOGIN</div>
        <div class="form">
            <div>이메일</div>
            <input type="text" />
        </div>
    </div>
</div>
```

### 접근성 고려사항
```html
<!-- ARIA 속성 사용 -->
<input type="password" 
       id="password" 
       aria-describedby="password-help"
       aria-invalid="false" />
<div id="password-help" class="help-text">
    8자 이상, 영문/숫자/특수문자 조합
</div>

<!-- 스크린 리더 전용 텍스트 -->
<span class="sr-only">필수 입력 항목</span>
```

---

## 🎨 CSS 가이드라인

### 기본 원칙
1. **모바일 퍼스트**: 작은 화면부터 설계
2. **모듈화**: 컴포넌트별 CSS 분리
3. **일관성**: 통일된 디자인 시스템 사용

### 색상 시스템
```css
:root {
    /* Primary Colors */
    --color-primary: #000000;
    --color-secondary: #222222;
    --color-accent: #888888;
    
    /* Background Colors */
    --color-bg-primary: #ffffff;
    --color-bg-secondary: #f9f9f9;
    --color-bg-error: #fff5f5;
    
    /* Text Colors */
    --color-text-primary: #222222;
    --color-text-secondary: #888888;
    --color-text-error: #e53e3e;
    
    /* Border Colors */
    --color-border-default: #e0e0e0;
    --color-border-focus: #111111;
    --color-border-error: #e53e3e;
}
```

### 타이포그래피
```css
:root {
    /* Font Family */
    --font-primary: "Pretendard", -apple-system, BlinkMacSystemFont, system-ui, sans-serif;
    
    /* Font Sizes */
    --font-size-xs: 0.75rem;    /* 12px */
    --font-size-sm: 0.875rem;   /* 14px */
    --font-size-base: 1rem;     /* 16px */
    --font-size-lg: 1.125rem;   /* 18px */
    --font-size-xl: 1.25rem;    /* 20px */
    --font-size-2xl: 1.5rem;    /* 24px */
    
    /* Font Weights */
    --font-weight-normal: 400;
    --font-weight-medium: 500;
    --font-weight-semibold: 600;
    --font-weight-bold: 700;
    
    /* Line Heights */
    --line-height-tight: 1.25;
    --line-height-normal: 1.5;
    --line-height-relaxed: 1.75;
}
```

### 간격 시스템
```css
:root {
    /* Spacing Scale */
    --space-xs: 0.25rem;   /* 4px */
    --space-sm: 0.5rem;    /* 8px */
    --space-md: 1rem;      /* 16px */
    --space-lg: 1.5rem;    /* 24px */
    --space-xl: 2rem;      /* 32px */
    --space-2xl: 3rem;     /* 48px */
    --space-3xl: 4rem;     /* 64px */
}
```

### 컴포넌트 스타일 예시
```css
/* 버튼 컴포넌트 */
.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: var(--space-sm) var(--space-md);
    border: 1px solid transparent;
    border-radius: 8px;
    font-family: var(--font-primary);
    font-size: var(--font-size-base);
    font-weight: var(--font-weight-medium);
    text-decoration: none;
    cursor: pointer;
    transition: all 0.2s ease;
}

.btn--primary {
    background-color: var(--color-primary);
    color: var(--color-bg-primary);
}

.btn--primary:hover {
    background-color: var(--color-secondary);
}

.btn--secondary {
    background-color: transparent;
    color: var(--color-primary);
    border-color: var(--color-border-default);
}
```

### 반응형 디자인
```css
/* 브레이크포인트 */
:root {
    --breakpoint-sm: 576px;
    --breakpoint-md: 768px;
    --breakpoint-lg: 992px;
    --breakpoint-xl: 1200px;
}

/* 미디어 쿼리 사용 */
.container {
    width: 100%;
    max-width: 400px;
    margin: 0 auto;
    padding: var(--space-md);
}

@media (min-width: 768px) {
    .container {
        max-width: 600px;
        padding: var(--space-lg);
    }
}
```

---

## ⚡ JavaScript 가이드라인

### 기본 원칙
1. **ES6+ 문법 사용** (const/let, arrow functions, destructuring)
2. **함수형 프로그래밍** 지향
3. **에러 핸들링** 필수
4. **성능 최적화** (디바운싱, 쓰로틀링)

### 코드 구조
```javascript
// 1. 상수 선언
const VALIDATION_RULES = {
    EMAIL: /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/,
    PASSWORD: /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/,
    PHONE: /^\d{10,11}$/
};

// 2. 유틸리티 함수
const debounce = (func, delay) => {
    let timeoutId;
    return (...args) => {
        clearTimeout(timeoutId);
        timeoutId = setTimeout(() => func.apply(null, args), delay);
    };
};

// 3. 검증 함수들
const validateEmail = (email) => VALIDATION_RULES.EMAIL.test(email);
const validatePassword = (password) => VALIDATION_RULES.PASSWORD.test(password);

// 4. DOM 조작 함수들
const showError = ($field, message) => {
    const $errorElement = $field.siblings('.error-message');
    $errorElement.text(message).show();
    $field.addClass('error');
};

const hideError = ($field) => {
    const $errorElement = $field.siblings('.error-message');
    $errorElement.hide();
    $field.removeClass('error');
};

// 5. 이벤트 핸들러
const handleFormSubmit = (event) => {
    event.preventDefault();
    // 폼 처리 로직
};

// 6. 초기화 함수
const initializeForm = () => {
    const $form = $('.login-form');
    const $inputs = $form.find('input');
    
    // 이벤트 리스너 등록
    $form.on('submit', handleFormSubmit);
    $inputs.on('blur', handleFieldBlur);
    $inputs.on('input', debounce(handleFieldInput, 500));
};

// 7. DOM 준비 완료 시 실행
$(document).ready(initializeForm);
```

### 에러 핸들링
```javascript
// try-catch 사용
const submitForm = async (formData) => {
    try {
        const response = await fetch('/api/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(formData)
        });
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const result = await response.json();
        return result;
    } catch (error) {
        console.error('Form submission failed:', error);
        showErrorMessage('로그인에 실패했습니다. 다시 시도해주세요.');
        throw error;
    }
};
```

### jQuery 사용 규칙
```javascript
// jQuery 객체는 $ 접두사 사용
const $form = $('.login-form');
const $submitButton = $('#submit-btn');

// 체이닝 활용
$form
    .find('input')
    .addClass('form-control')
    .on('focus', handleFocus)
    .on('blur', handleBlur);

// 성능을 위한 캐싱
const $window = $(window);
const $document = $(document);
```

---

## 📁 파일 구조 규칙

### CSS 파일 구조
```
css/
├── common.css              # 전역 스타일, 리셋, 유틸리티
├── header.css              # 헤더 컴포넌트
├── footer.css              # 푸터 컴포넌트
├── login/                  # 로그인 모듈
│   ├── login.css          # 로그인 페이지
│   ├── signup.css         # 회원가입 페이지
│   └── terms.css          # 약관 페이지
├── admin/                  # 관리자 모듈
│   └── dashboard.css
└── components/             # 재사용 컴포넌트
    ├── buttons.css
    ├── forms.css
    └── modals.css
```

### JavaScript 파일 구조
```
js/
├── common.js               # 전역 유틸리티 함수
├── login.js                # 로그인 관련 기능
├── signup.js               # 회원가입 관련 기능
├── term.js                 # 약관 관련 기능
└── utils/                  # 유틸리티 모듈
    ├── validation.js       # 검증 함수들
    ├── api.js             # API 호출 함수들
    └── dom.js             # DOM 조작 헬퍼들
```

---

## ✅ 코드 품질 규칙

### 주석 작성 규칙
```javascript
/**
 * 이메일 유효성을 검사합니다.
 * @param {string} email - 검사할 이메일 주소
 * @returns {boolean} 유효한 이메일이면 true, 아니면 false
 */
const validateEmail = (email) => {
    // 이메일 정규식 패턴으로 검증
    return VALIDATION_RULES.EMAIL.test(email);
};
```

```css
/* ==========================================================================
   로그인 폼 스타일
   ========================================================================== */

.login-form {
    /* 폼 기본 레이아웃 */
    max-width: 400px;
    margin: 0 auto;
}

.login-form__input {
    /* 입력 필드 스타일 */
    width: 100%;
    padding: var(--space-sm);
}
```

### 코드 포맷팅
```javascript
// 좋은 예: 일관된 들여쓰기와 간격
const handleSubmit = (event) => {
    event.preventDefault();
    
    const formData = {
        email: $('#email').val().trim(),
        password: $('#password').val().trim()
    };
    
    if (validateForm(formData)) {
        submitForm(formData);
    }
};

// 피해야 할 예: 불일치한 포맷팅
const handleSubmit=(event)=>{
event.preventDefault();
const formData={email:$('#email').val().trim(),password:$('#password').val().trim()};
if(validateForm(formData)){submitForm(formData);}
};
```

### 성능 최적화
```javascript
// 디바운싱 적용
const debouncedValidation = debounce((field, value) => {
    validateField(field, value);
}, 500);

// 이벤트 위임 사용
$(document).on('input', '.form-control', function() {
    const $this = $(this);
    debouncedValidation($this, $this.val());
});

// DOM 쿼리 최소화
const $form = $('.login-form');
const $inputs = $form.find('input'); // 한 번만 쿼리
```

---

## 🔍 코드 리뷰 체크리스트

### HTML
- [ ] 시맨틱 태그 사용
- [ ] 접근성 속성 (aria-*, role) 포함
- [ ] 올바른 폼 구조 (label, fieldset)
- [ ] 반응형 메타 태그 포함

### CSS
- [ ] BEM 네이밍 컨벤션 준수
- [ ] CSS 변수 사용
- [ ] 모바일 퍼스트 접근
- [ ] 브라우저 호환성 고려

### JavaScript
- [ ] ES6+ 문법 사용
- [ ] 에러 핸들링 포함
- [ ] 성능 최적화 적용
- [ ] 함수 단위 테스트 가능

---

이 가이드라인을 따라 일관되고 유지보수 가능한 코드를 작성해주세요! 🚀

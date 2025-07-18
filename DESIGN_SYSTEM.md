# Stay Folio 디자인 시스템

## 🎨 브랜드 아이덴티티

### 브랜드 컨셉
- **미니멀리즘**: 깔끔하고 단순한 디자인
- **모던**: 현대적이고 세련된 감각
- **신뢰성**: 안정적이고 전문적인 이미지
- **접근성**: 모든 사용자가 쉽게 사용할 수 있는 인터페이스

### 로고 가이드라인
```html
<!-- 기본 로고 -->
<h1 class="logo">
    <a href="main.html">STAY<br />FOLIO</a>
</h1>
```

**사용 규칙:**
- 로고는 항상 대문자로 표기
- 줄바꿈은 STAY와 FOLIO 사이에만 허용
- 최소 여백: 로고 높이의 1/2 이상

---

## 🎯 컬러 팔레트

### Primary Colors
```css
:root {
    /* 메인 컬러 */
    --color-black: #000000;         /* 주요 텍스트, 버튼 */
    --color-dark-gray: #222222;     /* 보조 텍스트 */
    --color-medium-gray: #888888;   /* 플레이스홀더, 비활성 */
    --color-light-gray: #e0e0e0;    /* 테두리, 구분선 */
    --color-white: #ffffff;         /* 배경, 반전 텍스트 */
}
```

### Semantic Colors
```css
:root {
    /* 상태별 컬러 */
    --color-success: #10b981;       /* 성공 메시지 */
    --color-warning: #f59e0b;       /* 경고 메시지 */
    --color-error: #ef4444;         /* 오류 메시지 */
    --color-info: #3b82f6;          /* 정보 메시지 */
}
```

### Background Colors
```css
:root {
    /* 배경 컬러 */
    --color-bg-primary: #ffffff;    /* 메인 배경 */
    --color-bg-secondary: #f9f9f9;  /* 입력 필드 배경 */
    --color-bg-tertiary: #f5f5f5;   /* 카드, 섹션 배경 */
    --color-bg-overlay: rgba(0, 0, 0, 0.5); /* 모달 오버레이 */
}
```

### 컬러 사용 가이드
| 용도 | 컬러 | 사용 예시 |
|------|------|-----------|
| 주요 액션 | `--color-black` | 로그인 버튼, 제출 버튼 |
| 보조 액션 | `--color-dark-gray` | 취소 버튼, 링크 |
| 텍스트 | `--color-dark-gray` | 본문 텍스트 |
| 보조 텍스트 | `--color-medium-gray` | 설명 텍스트, 라벨 |
| 테두리 | `--color-light-gray` | 입력 필드, 카드 테두리 |

---

## 📝 타이포그래피

### 폰트 패밀리
```css
:root {
    --font-primary: "Pretendard", -apple-system, BlinkMacSystemFont, 
                    system-ui, Roboto, "Helvetica Neue", "Segoe UI", 
                    "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", sans-serif;
}
```

### 폰트 크기 스케일
```css
:root {
    /* 폰트 크기 (16px 기준) */
    --font-size-xs: 0.75rem;    /* 12px - 캡션, 라벨 */
    --font-size-sm: 0.875rem;   /* 14px - 보조 텍스트 */
    --font-size-base: 1rem;     /* 16px - 기본 텍스트 */
    --font-size-lg: 1.125rem;   /* 18px - 강조 텍스트 */
    --font-size-xl: 1.25rem;    /* 20px - 소제목 */
    --font-size-2xl: 1.5rem;    /* 24px - 제목 */
    --font-size-3xl: 1.875rem;  /* 30px - 대제목 */
    --font-size-4xl: 2.25rem;   /* 36px - 메인 타이틀 */
}
```

### 폰트 굵기
```css
:root {
    --font-weight-light: 300;
    --font-weight-normal: 400;
    --font-weight-medium: 500;
    --font-weight-semibold: 600;
    --font-weight-bold: 700;
}
```

### 줄 간격
```css
:root {
    --line-height-tight: 1.25;     /* 제목용 */
    --line-height-normal: 1.5;     /* 기본 텍스트 */
    --line-height-relaxed: 1.75;   /* 긴 텍스트 */
}
```

### 타이포그래피 클래스
```css
/* 제목 스타일 */
.heading-1 {
    font-size: var(--font-size-4xl);
    font-weight: var(--font-weight-bold);
    line-height: var(--line-height-tight);
    letter-spacing: 0.4em;
}

.heading-2 {
    font-size: var(--font-size-2xl);
    font-weight: var(--font-weight-semibold);
    line-height: var(--line-height-tight);
}

.heading-3 {
    font-size: var(--font-size-xl);
    font-weight: var(--font-weight-medium);
    line-height: var(--line-height-normal);
}

/* 본문 스타일 */
.body-large {
    font-size: var(--font-size-lg);
    line-height: var(--line-height-normal);
}

.body-base {
    font-size: var(--font-size-base);
    line-height: var(--line-height-normal);
}

.body-small {
    font-size: var(--font-size-sm);
    line-height: var(--line-height-normal);
}

/* 캡션 스타일 */
.caption {
    font-size: var(--font-size-xs);
    color: var(--color-medium-gray);
    line-height: var(--line-height-normal);
}
```

---

## 📏 간격 시스템

### 간격 스케일 (8px 기준)
```css
:root {
    --space-0: 0;
    --space-1: 0.125rem;   /* 2px */
    --space-2: 0.25rem;    /* 4px */
    --space-3: 0.375rem;   /* 6px */
    --space-4: 0.5rem;     /* 8px */
    --space-5: 0.625rem;   /* 10px */
    --space-6: 0.75rem;    /* 12px */
    --space-8: 1rem;       /* 16px */
    --space-10: 1.25rem;   /* 20px */
    --space-12: 1.5rem;    /* 24px */
    --space-16: 2rem;      /* 32px */
    --space-20: 2.5rem;    /* 40px */
    --space-24: 3rem;      /* 48px */
    --space-32: 4rem;      /* 64px */
    --space-40: 5rem;      /* 80px */
    --space-48: 6rem;      /* 96px */
}
```

### 간격 사용 가이드
| 용도 | 간격 | 사용 예시 |
|------|------|-----------|
| 요소 내부 여백 | `--space-4`, `--space-8` | 버튼, 입력 필드 패딩 |
| 요소 간 간격 | `--space-8`, `--space-12` | 폼 필드 간격 |
| 섹션 간격 | `--space-16`, `--space-24` | 카드, 섹션 마진 |
| 페이지 간격 | `--space-32`, `--space-48` | 페이지 상하 여백 |

---

## 🔘 컴포넌트 디자인

### 버튼
```css
/* 기본 버튼 */
.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: var(--space-8) var(--space-16);
    border: 1px solid transparent;
    border-radius: 8px;
    font-family: var(--font-primary);
    font-size: var(--font-size-base);
    font-weight: var(--font-weight-medium);
    text-decoration: none;
    cursor: pointer;
    transition: all 0.2s ease;
    min-height: 48px; /* 터치 접근성 */
}

/* Primary 버튼 */
.btn--primary {
    background-color: var(--color-black);
    color: var(--color-white);
}

.btn--primary:hover {
    background-color: var(--color-dark-gray);
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

/* Secondary 버튼 */
.btn--secondary {
    background-color: transparent;
    color: var(--color-black);
    border-color: var(--color-light-gray);
}

.btn--secondary:hover {
    background-color: var(--color-bg-secondary);
    border-color: var(--color-dark-gray);
}

/* 크기 변형 */
.btn--large {
    padding: var(--space-12) var(--space-24);
    font-size: var(--font-size-lg);
    min-height: 56px;
}

.btn--small {
    padding: var(--space-4) var(--space-8);
    font-size: var(--font-size-sm);
    min-height: 36px;
}
```

### 입력 필드
```css
.form-control {
    width: 100%;
    padding: var(--space-8) var(--space-12);
    border: 1px solid var(--color-light-gray);
    border-radius: 8px;
    font-family: var(--font-primary);
    font-size: var(--font-size-base);
    background-color: var(--color-bg-secondary);
    transition: all 0.2s ease;
    min-height: 48px;
}

.form-control:focus {
    outline: none;
    border-color: var(--color-black);
    background-color: var(--color-white);
    box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.1);
}

.form-control--error {
    border-color: var(--color-error);
    background-color: #fef2f2;
}

.form-control::placeholder {
    color: var(--color-medium-gray);
}
```

### 카드
```css
.card {
    background-color: var(--color-white);
    border: 1px solid var(--color-light-gray);
    border-radius: 12px;
    padding: var(--space-16);
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    transition: all 0.2s ease;
}

.card:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    transform: translateY(-2px);
}
```

---

## 📱 반응형 디자인

### 브레이크포인트
```css
:root {
    --breakpoint-xs: 480px;   /* 모바일 */
    --breakpoint-sm: 576px;   /* 모바일 가로 */
    --breakpoint-md: 768px;   /* 태블릿 */
    --breakpoint-lg: 992px;   /* 데스크톱 */
    --breakpoint-xl: 1200px;  /* 대형 데스크톱 */
    --breakpoint-2xl: 1400px; /* 초대형 화면 */
}
```

### 컨테이너 시스템
```css
.container {
    width: 100%;
    margin: 0 auto;
    padding: 0 var(--space-16);
}

/* 모바일 */
@media (max-width: 767px) {
    .container {
        max-width: 100%;
        padding: 0 var(--space-12);
    }
}

/* 태블릿 */
@media (min-width: 768px) {
    .container {
        max-width: 720px;
    }
}

/* 데스크톱 */
@media (min-width: 992px) {
    .container {
        max-width: 960px;
    }
}

/* 대형 데스크톱 */
@media (min-width: 1200px) {
    .container {
        max-width: 1140px;
    }
}
```

---

## 🎭 애니메이션 & 전환

### 전환 효과
```css
:root {
    /* 전환 시간 */
    --transition-fast: 0.15s;
    --transition-base: 0.2s;
    --transition-slow: 0.3s;
    
    /* 이징 함수 */
    --ease-in: cubic-bezier(0.4, 0, 1, 1);
    --ease-out: cubic-bezier(0, 0, 0.2, 1);
    --ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
}

/* 기본 전환 */
.transition {
    transition: all var(--transition-base) var(--ease-in-out);
}

/* 호버 효과 */
.hover-lift:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.hover-scale:hover {
    transform: scale(1.05);
}
```

### 로딩 애니메이션
```css
@keyframes spin {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

.loading-spinner {
    width: 20px;
    height: 20px;
    border: 2px solid var(--color-light-gray);
    border-top: 2px solid var(--color-black);
    border-radius: 50%;
    animation: spin 1s linear infinite;
}
```

---

## ♿ 접근성 가이드라인

### 색상 대비
- **AA 등급**: 4.5:1 이상 (일반 텍스트)
- **AAA 등급**: 7:1 이상 (중요한 텍스트)

### 포커스 표시
```css
.focus-visible {
    outline: 2px solid var(--color-black);
    outline-offset: 2px;
}

/* 키보드 네비게이션 */
*:focus-visible {
    outline: 2px solid var(--color-black);
    outline-offset: 2px;
}
```

### 터치 타겟 크기
- 최소 크기: 44px × 44px
- 권장 크기: 48px × 48px

---

## 📐 레이아웃 시스템

### 그리드 시스템
```css
.grid {
    display: grid;
    gap: var(--space-16);
}

.grid--2-cols {
    grid-template-columns: repeat(2, 1fr);
}

.grid--3-cols {
    grid-template-columns: repeat(3, 1fr);
}

/* 반응형 그리드 */
@media (max-width: 767px) {
    .grid--2-cols,
    .grid--3-cols {
        grid-template-columns: 1fr;
    }
}
```

### 플렉스박스 유틸리티
```css
.flex { display: flex; }
.flex-col { flex-direction: column; }
.items-center { align-items: center; }
.justify-center { justify-content: center; }
.justify-between { justify-content: space-between; }
.gap-4 { gap: var(--space-4); }
.gap-8 { gap: var(--space-8); }
```

---

## 🎯 사용 예시

### 로그인 페이지 구현
```html
<main class="container">
    <div class="card" style="max-width: 400px; margin: var(--space-32) auto;">
        <h2 class="heading-2" style="text-align: center; margin-bottom: var(--space-4);">
            LOGIN
        </h2>
        <p class="body-small" style="text-align: center; color: var(--color-medium-gray); margin-bottom: var(--space-24);">
            로그인
        </p>
        
        <form class="flex flex-col gap-8">
            <div>
                <label class="body-small" style="display: block; margin-bottom: var(--space-4);">
                    이메일
                </label>
                <input type="email" class="form-control" placeholder="이메일을 입력해주세요." />
            </div>
            
            <div>
                <label class="body-small" style="display: block; margin-bottom: var(--space-4);">
                    비밀번호
                </label>
                <input type="password" class="form-control" placeholder="비밀번호를 입력해주세요." />
            </div>
            
            <button type="submit" class="btn btn--primary btn--large">
                LOGIN
            </button>
        </form>
    </div>
</main>
```

이 디자인 시스템을 활용하여 일관되고 아름다운 Stay Folio 인터페이스를 구축하세요! ✨

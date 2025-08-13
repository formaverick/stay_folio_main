### **Stay Folio 프론트엔드 코딩 규약**

이 문서는 `stay_folio` 프로젝트의 프론트엔드 코드(HTML, CSS, JavaScript) 작성에 대한 규칙과 가이드라인을 정의합니다. 모든 팀원은 이 규약을 준수하여 코드의 일관성, 가독성, 유지보수성을 높여야 합니다.

#### **1. 일반 원칙**

- **일관성:** 프로젝트 내 기존 코드의 스타일과 패턴을 최우선으로 따릅니다.
- **가독성:** 다른 사람이 코드를 쉽게 이해할 수 있도록 명확하고 간결하게 작성합니다.
- **모듈화:** 기능별, 페이지별로 파일을 분리하여 관심사를 분리하고 재사용성을 높입니다.

---

#### **2. HTML 규약**

1.  **기본 구조**
    - 모든 HTML 문서는 `<!DOCTYPE html>`으로 시작하고, `lang="ko"` 속성을 포함해야 합니다.
    - 문자 인코딩은 `UTF-8`을 사용합니다.
      ```html
      <!DOCTYPE html>
      <html lang="ko">
        <head>
          <meta charset="UTF-8" />
          ...
        </head>
        ...
      </html>
      ```

2.  **시맨틱 마크업**
    - `header`, `footer`, `nav`, `main`, `section`, `article`, `aside` 등 시맨틱 태그를 의미에 맞게 적극적으로 사용합니다.
    - 단순 `<div>` 남용을 지양하고, 콘텐츠의 구조를 명확히 표현합니다.

3.  **들여쓰기 및 형식**
    - 들여쓰기는 **공백(Space) 2칸**을 사용합니다.
    - 속성값은 항상 큰따옴표(`"`)로 감쌉니다.

4.  **클래스 명명**
    - CSS 규약의 명명 규칙(BEM 기반)을 따릅니다. (아래 CSS 섹션 참조)
    - JavaScript에서 특정 요소를 선택하기 위한 목적으로만 클래스를 사용할 경우, `js-` 접두사를 붙여 스타일링 목적의 클래스와 구분합니다. (예: `class="js-modal-trigger"`)

5.  **주석**
    - 복잡한 UI 구조나 특정 마크업이 필요한 이유를 설명할 때 주석을 사용합니다.
    - 시작과 끝을 명시하여 가독성을 높입니다.
      ```html
      <!-- 메인 캐러셀 시작 -->
      <section class="carousel-container">
        ...
      </section>
      <!-- 메인 캐러셀 끝 -->
      ```

---

#### **3. CSS 규약**

1.  **파일 구조**
    - **`common.css`**: 모든 페이지에 공통적으로 적용되는 스타일 (폰트, 리셋, 기본 레이아웃, 버튼 등)을 정의합니다.
    - **페이지/컴포넌트별 분리**: 각 페이지나 주요 컴포넌트별로 CSS 파일을 분리하여 관리합니다.
      - 예: `login/login.css`, `admin/room/roomList.css`, `stayCard.css`

2.  **명명 규칙 (BEM 기반)**
    - 클래스 이름은 **케밥 케이스(kebab-case)**를 사용합니다.
    - 구조는 `[블록]-[요소]--[상태]` 형식을 따릅니다.
    - **블록(Block):** 기능적으로 독립적인 최상위 컴포넌트. (예: `admin-login`, `search-filter`, `stay-card`)
    - **요소(Element):** 블록을 구성하는 부분. 블록 이름 뒤에 하이픈(-)으로 연결합니다. (예: `admin-login-form`, `search-filter-container`, `stay-card-image`)
    - **상태(Modifier):** 블록이나 요소의 상태나 변형. 점(`.`)으로 구분된 별도의 클래스로 정의합니다. (예: `.active`, `.error`, `.disabled`)

      ```css
      /* 블록 */
      .admin-login-container { ... }

      /* 요소 */
      .admin-login-form { ... }
      .admin-login-form .form-group { ... }

      /* 상태 */
      .form-group.error input { ... }
      .nav-item.active { ... }
      ```

3.  **선택자**
    - ID 선택자(`#id`)는 스타일링에 사용하지 않습니다. 클래스 선택자를 사용하세요.
    - 불필요한 태그 선택자 중첩을 피합니다. (예: `ul.nav` 대신 `.nav`)

4.  **단위**
    - **`rem`**: 폰트 크기, `padding`, `margin` 등 전체 레이아웃과 관련된 유동적인 크기에 사용합니다.
    - **`px`**: `border` 두께 등 고정된 크기가 필요할 때 사용합니다.
    - **`%`**: 부모 요소에 대한 상대적인 너비/높이를 지정할 때 사용합니다.

5.  **주석**
    - 파일 상단에 해당 파일의 역할을 명시합니다.
    - 복잡한 스타일이나 특정 섹션을 구분할 때 주석을 사용합니다.
      ```css
      /* 관리자 로그인 페이지 스타일 */

      .admin-login-container { ... }
      ```

---

#### **4. JavaScript (jQuery 포함) 규약**

1.  **파일 구조**
    - CSS와 마찬가지로 기능 및 페이지 단위로 파일을 분리합니다.
      - 예: `login/signup.js`, `main/carousel.js`, `search/searchFilter.js`

2.  **변수 및 상수**
    - 변수는 **카멜 케이스(camelCase)**를 사용합니다.
    - 변수 선언은 `const`를 기본으로 사용하고, 재할당이 필요한 경우에만 `let`을 사용합니다. `var`는 사용하지 않습니다.
    - **jQuery 객체를 담는 변수는 `$` 접두사**를 붙여 DOM 요소임을 명확히 합니다.
      ```javascript
      const $carousel = $(".carousel");
      let currentSlide = 0;
      ```

3.  **함수**
    - 함수명은 **카멜 케이스(camelCase)**를 사용하며, 동사로 시작하여 그 역할을 명확히 나타냅니다.
      - 예: `validateEmail()`, `updateDateDisplay()`, `handleFormSubmit()`
    - 하나의 함수는 하나의 기능만 수행하도록 작성합니다.

4.  **jQuery 사용**
    - 모든 코드는 `$(document).ready(function() { ... });` 내에 작성하여 DOM이 완전히 로드된 후 스크립트가 실행되도록 보장합니다.
    - 이벤트 핸들러는 `.on()`을 사용합니다.
      ```javascript
      // Good
      $(".btn-login").on("click", handleLogin);

      // Bad
      $(".btn-login").click(handleLogin);
      ```

5.  **유효성 검사**
    - 모든 사용자 입력 폼에는 제출 전 클라이언트 사이드 유효성 검사를 구현합니다.
    - 각 필드별 검사 함수(`validateEmail`, `validatePassword` 등)를 만들어 재사용성을 높입니다.
    - 에러 메시지는 해당 입력 필드 바로 아래에 `.error-message` 클래스를 가진 요소를 통해 표시합니다.

6.  **이벤트 처리**
    - `scroll`, `input`과 같이 빈번하게 발생하는 이벤트는 **디바운스(debounce)**를 적용하여 성능 저하를 방지합니다.
      ```javascript
      const debouncedValidate = debounce(function ($field) {
        validateField($field, $field.val());
      }, 500);

      $field.on("input", function () {
        debouncedValidate($(this));
      });
      ```

7.  **주석**
    - 복잡한 로직이나 알고리즘, 특정 해결 방법에 대한 이유를 설명할 때 주석을 작성합니다. "무엇을" 하는 코드인지보다 "**왜**" 그렇게 작성했는지를 설명하는 데 집중합니다.
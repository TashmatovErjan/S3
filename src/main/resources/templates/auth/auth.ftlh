<#import "../layout.ftlh" as main>
<@main.layout ; spring>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .auth-page {
            min-height: calc(100vh - 56px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .auth-card {
            width: 100%;
            max-width: 440px;
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .auth-tabs {
            display: flex;
            gap: 4px;
            background: #f1f3f5;
            border-radius: 10px;
            padding: 4px;
            margin-bottom: 30px;
        }

        .auth-tab-btn {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            background: transparent;
            color: #6c757d;
            transition: all 0.2s;
        }

        .auth-tab-btn.active {
            background: white;
            color: #000;
            box-shadow: 0 1px 4px rgba(0,0,0,0.1);
        }

        .auth-form { display: none; }
        .auth-form.active { display: block; }

        .auth-input {
            border-radius: 10px;
            padding: 12px 15px;
        }

        .auth-submit-btn {
            width: 100%;
            padding: 12px;
            background: black;
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 500;
            transition: opacity 0.2s;
        }

        .auth-submit-btn:hover { opacity: 0.85; }

        .error-text { font-size: 13px; color: red; }
    </style>

    <div class="auth-page">
        <div class="auth-card">

            <div class="auth-tabs">
                <button class="auth-tab-btn active" onclick="switchTab('login', this)">Логин</button>
                <button class="auth-tab-btn" onclick="switchTab('register', this)">Регистрация</button>
            </div>

            <div id="form-login" class="auth-form active">
                <#if RequestParameters.error??>
                    <div class="alert alert-danger mb-3">Неверная почта или пароль</div>
                </#if>
                <form action="/auth/login" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <div class="mb-3">
                        <input type="email" name="username"
                               class="form-control auth-input"
                               placeholder="Почта">
                    </div>
                    <div class="mb-4">
                        <input type="password" name="password"
                               class="form-control auth-input"
                               placeholder="Пароль">
                    </div>
                    <button type="submit" class="auth-submit-btn">Войти</button>
                </form>
            </div>

            <div id="form-register" class="auth-form">
                <form action="/auth/register" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />

                    <div class="form-group mb-3">
                        <label for="userDto.email">Почта</label>
                        <@spring.formInput "userDto.email" 'class="form-control auth-input" id="userDto.email"' />
                        <div class="text-danger" style="font-size: 13px; margin-top: 4px;">
                            <@spring.showErrors "<br>" />
                        </div>
                        <#if emailError??>
                            <div class="text-danger" style="font-size: 13px; margin-top: 4px;">${emailError}</div>
                        </#if>
                    </div>

                    <div class="form-group mb-3">
                        <label for="userDto.password">Пароль</label>
                        <@spring.formInput "userDto.password" 'class="form-control auth-input" id="userDto.password" type="password"' />
                        <div class="text-danger" style="font-size: 13px; margin-top: 4px;">
                            <@spring.showErrors "<br>" />
                        </div>
                    </div>

                    <input type="hidden" name="accountTypeId" value="2">
                    <button type="submit" class="auth-submit-btn">Зарегистрироваться</button>
                </form>
            </div>

        </div>
    </div>

    <script>
        function switchTab(tab, el) {
            document.querySelectorAll('.auth-tab-btn').forEach(b => b.classList.remove('active'));
            document.querySelectorAll('.auth-form').forEach(f => f.classList.remove('active'));
            el.classList.add('active');
            document.getElementById('form-' + tab).classList.add('active');
        }

        <#assign hasRegisterErrors = (spring.status?? && spring.status.errorMessages?has_content)!false />
        <#if hasRegisterErrors>
        switchTab('register', document.querySelectorAll('.auth-tab-btn')[1]);
        </#if>
    </script>
</@main.layout>
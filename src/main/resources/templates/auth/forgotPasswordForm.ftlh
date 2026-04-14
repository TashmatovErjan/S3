<#import "../layout.ftlh" as main>
<@main.layout ; spring>

    <style>
        .auth-page { min-height: calc(100vh - 52px); display: flex; align-items: center; justify-content: center; padding: 2rem 1rem; }
        .auth-card { width: 100%; max-width: 400px; }
        .auth-title { font-size: 18px; font-weight: 500; margin: 0 0 4px; }
        .auth-sub { font-size: 13px; color: #888; margin: 0 0 2rem; }
        .auth-input { width: 100%; font-size: 13px; padding: 8px 12px; border: 0.5px solid #dddcd4; border-radius: 8px; outline: none; background: white; transition: border-color 0.15s; }
        .auth-input:focus { border-color: #888; }
        .auth-btn { width: 100%; font-size: 13px; font-weight: 500; padding: 8px 0; border: 0.5px solid #888; border-radius: 8px; background: #1a1a1a; color: white; cursor: pointer; transition: opacity 0.15s; margin-top: 1rem; }
        .auth-btn:hover { opacity: 0.85; }
        .alert { font-size: 13px; padding: 8px 12px; border-radius: 8px; margin-bottom: 1rem; }
        .alert-err { background: #fcebeb; color: #a32d2d; border: 0.5px solid #f7c1c1; }
        .alert-warn { background: #faeeda; color: #633806; border: 0.5px solid #fac775; }
    </style>

    <div class="auth-page">
        <div class="auth-card">
            <h2 class="auth-title">Восстановление пароля</h2>
            <p class="auth-sub">Введите почту — пришлём ссылку для сброса</p>

            <#if error??>
                <div class="alert alert-err">${error}</div>
            </#if>
            <#if message??>
                <div class="alert alert-warn">${message}</div>
            </#if>

            <form action="/auth/forgotPassword" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                <input type="email" name="email" class="auth-input" placeholder="Почта">
                <button type="submit" class="auth-btn">Отправить ссылку</button>
            </form>
        </div>
    </div>

</@main.layout>
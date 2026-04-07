<#import "spring.ftl" as spring>
<#macro layout>
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>S3</title>
        <link rel="shortcut icon" href="data:," type="image/x-icon">
        <style>
            *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                font-size: 14px;
                color: #1a1a1a;
                background: #f9f8f5;
                min-height: 100vh;
            }

            a { text-decoration: none; color: inherit; }

            nav {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 1.5rem;
                height: 52px;
                background: #ffffff;
                border-bottom: 0.5px solid #dddcd4;
            }

            .nav-brand {
                font-size: 15px;
                font-weight: 500;
                letter-spacing: -0.01em;
                color: #1a1a1a;
            }

            .nav-links {
                display: flex;
                align-items: center;
                gap: 4px;
            }

            .nav-link {
                font-size: 13px;
                color: #888;
                padding: 5px 12px;
                border-radius: 6px;
                transition: background 0.1s, color 0.1s;
            }

            .nav-link:hover {
                background: #f1f0eb;
                color: #1a1a1a;
            }

            .nav-btn {
                font-size: 13px;
                color: #888;
                padding: 5px 12px;
                border-radius: 6px;
                border: 0.5px solid #dddcd4;
                transition: background 0.1s;
                cursor: pointer;
            }

            .nav-btn:hover { background: #f1f0eb; }

            .nav-btn-danger { color: #a32d2d; border-color: #f7c1c1; }
            .nav-btn-danger:hover { background: #fcebeb; }

            main {
                max-width: 720px;
                margin: 0 auto;
                padding: 2rem 1.5rem;
            }


        </style>

        <#assign known = SPRING_SECURITY_CONTEXT?? >
        <#if known>
            <#assign
            user = SPRING_SECURITY_CONTEXT.authentication.principal
            name = user.getUsername()
            isAuthenticated = true
            roles = SPRING_SECURITY_CONTEXT.authentication.authorities?map(it -> it.authority)
            >
        <#else>
            <#assign isAuthenticated = false roles = [] >
        </#if>
    </head>
    <body>

    <nav>
        <a class="nav-brand" href="/">S3</a>
        <div class="nav-links">
            <#if isAuthenticated>
                <a class="nav-link" href="/profile">Профиль</a>
                <a class="nav-btn nav-btn-danger" href="/logout">Выйти</a>
            <#else>
                <a class="nav-btn" href="/auth/login">Войти</a>
            </#if>
        </div>
    </nav>
    <main>
        <#nested spring>
    </main>
    </body>
    </html>
</#macro>
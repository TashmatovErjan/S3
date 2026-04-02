<#import "spring.ftl" as spring>
<#macro layout>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>S3</title>
        <link rel="shortcut icon" href="data:," type="image/x-icon">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .navbar {
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 0.8rem 1rem;
            }
            .nav-link {
                font-weight: 500;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                margin: 0 2px;
            }
            .nav-link:hover {
                background-color: rgba(255,255,255,0.1);
            }
            .btn-black {
                background-color: black;
                color: white;
                font-weight: 500;
            }
            .btn-black:hover {
                background-color: white;
                color: white;
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
            <#assign
            isAuthenticated = false
            roles = []
            >
        </#if>

    </head>
    <body>
    <nav class="navbar navbar-expand-lg navbar-dark" style="background: linear-gradient(to right, #041c2c, #002b2b);">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="/">S3</a>

            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <#if isAuthenticated>
                        <li class="nav-item">
                            <a class="nav-link" href="/profile">Profile</a>
                        </li>
                    </#if>
                </ul>

                <div class="d-flex gap-2">
                    <#if isAuthenticated>
                        <a href="/logout" class="btn btn-outline-danger">Выйти</a>
                    <#else>
                        <a href="/auth/login" class="btn btn-outline-light">Войти</a>
                    </#if>
                </div>
            </div>
        </div>
    </nav>
    <div>
        <#nested spring>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
</#macro>
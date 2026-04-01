<#import "../layout.ftlh" as main>
<@main.layout ; spring>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .login-page {
            min-height: calc(100vh - 56px);
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(to right, #041c2c, #002b2b);
            padding: 20px;
        }

        .login-card {
            width: 100%;
            max-width: 800px;
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
        }

        .login-left-panel h2 {
            font-size: 32px;
            font-weight: 700;
        }

        .login-left-panel p {
            font-size: 18px;
            margin-top: 10px;
        }

        .login-form-container {
            padding: 40px;
            background: white;
        }

        .login-form-title {
            font-size: 24px;
            margin-bottom: 30px;
            color: #333;
            font-weight: 600;
        }

        .login-form-control {
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 20px;
        }

        .login-btn {
            background-color: black;
            color: white;
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            font-weight: 500;
            border: none;
            transition: all 0.2s;
            margin-bottom: 20px;
        }

        .divider {
            width: 100%;
            height: 1px;
            background-color: #ddd;
            margin: 20px 0;
        }

        .login-buttons-row {
            display: flex;
            gap: 10px;
        }

        .register-btn {
            background-color: white;
            color: black;
        }

        .register-btn:hover {
            background-color: #f8f9fa;
            color: black;
        }
    </style>

    <div class="login-page">
        <div class="login-card d-flex flex-row">

            <div class="col-md-6 login-form-container">
                <h3 class="login-form-title">Логин</h3>
                <#if RequestParameters.error??>
                    <div class="d-flex justify-content-center mt-4">
                        <div class="alert alert-danger shadow rounded-3 text-center w-100" style="max-width: 400px;">
                            Ошибка какая то
                        </div>
                    </div>
                </#if>

                <form action="/auth/login" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />

                    <div class="mb-3">
                        <input type="email"
                               name="username"
                               class="form-control login-form-control"
                               placeholder="Почта"
                        >
                    </div>

                    <div class="mb-3">
                        <input type="password"
                               name="password"
                               class="form-control login-form-control"
                               placeholder="Пароль"
                        >
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="login-btn">Логин</button>
                    </div>
                    <div class="login-buttons-row">
                        <a href="/auth/register" class="register-btn">Регистрация</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</@main.layout>

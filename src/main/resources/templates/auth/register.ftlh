<#import "../layout.ftlh" as main>
<@main.layout ; spring>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .registration-page {
            min-height: calc(100vh - 56px);
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(to right, #041c2c, #002b2b);
            padding: 20px;
        }

        .registration-card {
            width: 100%;
            max-width: 900px;
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
        }

        .registration-form-container {
            padding: 40px;
            background: white;
        }

        .error-block {
            margin-top: 5px;
            color: red;
            font-size: 13px;
        }
    </style>

    <div class="registration-page">
        <div class="registration-card d-flex flex-row">

            <div class="col-md-6 registration-form-container">
                <h3 class="mb-4">Регистрация</h3>

                    <form action="/auth/register" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />

                        <div class="form-group mb-3">
                            <label for="userDto.email">Почта</label>
                            <@spring.formInput "userDto.email" 'class="form-control" id="userDto.email"' />
<#--                            <div class="error-block"><@spring.showErrors "<br>" "error-message" /></div>-->
                            <#if emailError??>
                                <div class="error text-danger">${emailError}</div>
                            </#if>
                        </div>

                        <div class="form-group mb-3">
                            <label for="userDto.password">Пароль</label>
                            <@spring.formInput "userDto.password" 'class="form-control" id="userDto.password" type="password"' />
                            <div class="error-block"><@spring.showErrors "<br>" "error-message" /></div>
                        </div>

                        <input type="hidden" name="accountTypeId" value="2">
                        <button type="submit" class="btn btn-dark w-100 py-2">
                            Регистрация
                        </button>
                    </form>
            </div>
        </div>
    </div>
</@main.layout>
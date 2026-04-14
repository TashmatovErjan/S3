<#import "../layout.ftlh" as main>
<@main.layout ; spring>

    <style>
        .msg-page { min-height: calc(100vh - 52px); display: flex; align-items: center; justify-content: center; padding: 2rem 1rem; }
        .msg-card { width: 100%; max-width: 400px; text-align: center; }
        .msg-text { font-size: 15px; color: #1a1a1a; line-height: 1.6; margin: 0 0 1.5rem; }
        .msg-back { font-size: 13px; color: #888; text-decoration: none; border-bottom: 0.5px solid #dddcd4; }
        .msg-back:hover { color: #1a1a1a; border-color: #888; }
    </style>

    <div class="msg-page">
        <div class="msg-card">

            <#if error??>
                <p class="msg-text" style="color: #a32d2d;">${error}</p>
            <#else>
                <p class="msg-text">${message}</p>
            </#if>
            <a href="/" class="msg-back">На главную</a>
        </div>
    </div>

</@main.layout>
<#import "../layout.ftlh" as main>
<@main.layout ; spring>

    <style>
        .p-page { max-width: 640px; margin: 0 auto; padding: 2rem 1rem; }
        .p-section { margin-bottom: 1.5rem; }
        .p-label { font-size: 12px; font-weight: 500; color: #888; letter-spacing: .05em; text-transform: uppercase; margin-bottom: 12px; }
        .p-card { background: white; border: 0.5px solid #e5e4dc; border-radius: 12px; padding: 1.25rem; }
        .p-row { display: flex; justify-content: space-between; align-items: center; padding: 10px 0; border-bottom: 0.5px solid #e5e4dc; }
        .p-row:last-child { border-bottom: none; padding-bottom: 0; }
        .p-row:first-child { padding-top: 0; }
        .p-key { font-size: 13px; color: #888; }
        .p-val { font-size: 13px; color: #1a1a1a; font-weight: 500; }
        .p-bar-wrap { background: #e5e4dc; border-radius: 2px; height: 3px; margin-top: 12px; overflow: hidden; }
        .p-bar { height: 100%; border-radius: 2px; background: #1a1a1a; }
        .p-bar-meta { display: flex; justify-content: space-between; margin-top: 6px; }
        .p-btn { font-size: 13px; font-weight: 500; padding: 7px 16px; border-radius: 8px; border: 0.5px solid #dddcd4; background: white; color: #1a1a1a; cursor: pointer; }
        .p-btn:hover { background: #f5f4f0; }
        .p-btn-danger { border-color: #f7c1c1; color: #a32d2d; }
        .p-btn-danger:hover { background: #fcebeb; }
        .p-actions { display: flex; gap: 8px; flex-wrap: wrap; }
        .p-avatar { width: 44px; height: 44px; border-radius: 50%; background: #e5e4dc; display: flex; align-items: center; justify-content: center; font-size: 15px; font-weight: 500; color: #1a1a1a; flex-shrink: 0; }
        .p-header { display: flex; align-items: center; gap: 14px; margin-bottom: 2rem; }
        .p-name { font-size: 16px; font-weight: 500; color: #1a1a1a; margin: 0; }
        .p-storage-top { display: flex; justify-content: space-between; align-items: baseline; }
        .p-storage-label { font-size: 13px; color: #888; }
        .p-storage-count { font-size: 13px; color: #888; }
    </style>

    <div class="p-page">

        <div class="p-header">
            <div class="p-avatar">${user.email?upper_case?substring(0,1)}</div>
            <div>
                <p class="p-name">${user.email}</p>
            </div>
        </div>

        <div class="p-section">
            <div class="p-label">Хранилище</div>
            <div class="p-card">
                <div class="p-storage-top">
                    <span class="p-storage-label">${storageQuota!'0 КБ'} из ${userQuota}</span>
                    <span class="p-storage-count">${fileCount} файлов · ${getUsedSpacePercent!0}%</span>
                </div>
                <div class="p-bar-wrap">
                    <div class="p-bar" style="width: ${getUsedSpacePercent!0}%;"></div>
                </div>
            </div>
        </div>

        <div class="p-section">
            <div class="p-label">Аккаунт</div>
            <div class="p-card">
                <div class="p-row">
                    <span class="p-key">Email</span>
                    <span class="p-val">${user.email}</span>
                </div>
                <div class="p-row">
                    <span class="p-key">Роль</span>
                    <span class="p-val">Пользователь</span>
                </div>
            </div>
        </div>

        <div class="p-section">
            <div class="p-label">Действия</div>
            <div class="p-actions">
                <form action="/profile/delete" method="post" style="margin:0;">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button type="submit" class="p-btn p-btn-danger">Удалить аккаунт</button>
                </form>
            </div>
        </div>

    </div>

</@main.layout>
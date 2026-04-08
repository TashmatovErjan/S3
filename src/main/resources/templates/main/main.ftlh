<#import "../layout.ftlh" as main>
<@main.layout ; spring>


    <style>
        .upload-page { max-width: 640px; margin: 0 auto; padding: 2rem 1rem; }
        .upload-zone { border: 1px dashed #d1d0c9; border-radius: 12px; padding: 2.5rem 1.5rem; text-align: center; cursor: pointer; transition: background 0.15s; }
        .upload-zone:hover { background:#f5f4f0 }
        .btn-select { font-size: 13px; font-weight: 500; border: 0.5px solid #888; padding: 6px 16px; border-radius: 8px; background: white; cursor: pointer; }
        .file-row { display: flex; justify-content: space-between; align-items: center; padding: 10px 0; border-bottom: 0.5px solid #e5e4dc; }
        .badge { font-size: 11px; padding: 2px 8px; border-radius: 6px; }
        .badge-ok  { color: #3B6D11; background: #EAF3DE; }
        .badge-err { color: #A32D2D; background: #FCEBEB; }
        .section-label { font-size: 12px; font-weight: 500; color: #888; letter-spacing: .05em; text-transform: uppercase; margin-bottom: 12px; }
        #progressBar { height: 2px; background: #1a1a1a; width: 0; transition: width .2s; border-radius: 1px; }
        #progressTrack { background: #e5e4dc; border-radius: 1px; overflow: hidden; height: 2px; margin-top: 6px; }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-6px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .actions { display: flex; align-items: center; gap: 6px; flex-shrink: 0; }
        .icon-btn {
            width: 28px; height: 28px;
            border-radius: 6px;
            border: 0.5px solid #dddcd4;
            background: white;
            cursor: pointer;
            display: flex; align-items: center; justify-content: center;
            transition: background 0.1s;
            padding: 0;
        }
        .icon-btn:hover { background: #f5f4f0; }
        .icon-btn.del:hover { background: #fcebeb; border-color: #f7c1c1; }
        .icon-btn svg { width: 14px; height: 14px; pointer-events: none; }
    </style>

    <div class="upload-page">

        <div style="margin-bottom: 2rem;">
            <h2 style="font-size: 18px; font-weight: 500; margin: 0 0 4px;">Файлы</h2>
            <p style="font-size: 13px; color: #888; margin: 0;">Загрузите один или несколько файлов</p>
        </div>

        <form action="/file/upload" method="post" enctype="multipart/form-data" id="uploadForm">
            <input type="hidden" name="_csrf" value="${_csrf.token}" />

            <div class="upload-zone" onclick="document.getElementById('fileInput').click()">
                <div style="font-size: 13px; color: #888; margin-bottom: 12px;">Перетащите файлы или</div>
                <span class="btn-select">Выбрать файлы</span>
                <input type="file" name="file" id="fileInput" multiple style="display:none;">
            </div>

            <div id="selectedFiles" style="margin-top: 1rem;"></div>

            <div id="progressWrap" style="display:none; margin-top: 1rem;">
                <div style="display:flex; justify-content:space-between; margin-bottom:4px;">
                    <span style="font-size:12px; color:#888;" id="uploadStatus">Загрузка...</span>
                    <span style="font-size:12px; color:#888;" id="uploadPct">0%</span>
                </div>
                <div id="progressTrack"><div id="progressBar"></div></div>
            </div>

            <div style="margin-top: 1.5rem; display: flex; gap: 8px; justify-content: flex-end;">
                <button type="submit" style="font-size:13px; font-weight:500; padding:7px 20px; border:0.5px solid #888; border-radius:8px; background:white; cursor:pointer;">
                    Загрузить
                </button>
            </div>
        </form>

        <div style="margin-top: 2.5rem; border-top: 0.5px solid #e5e4dc; padding-top: 1.5rem;">
            <div class="section-label">Загруженные файлы</div>
            <div id="uploadedFiles">
                <#list dto.content as file>
                    <div class="file-row">
                        <div>
                            <div class="file-name">${file.originalName}</div>
                            <div class="file-meta">${file.createDate!''} · ${file.fileType!''} · ${file.size!''}</div>
                        </div>
                        <div class="actions">
                            <button type="button" class="icon-btn" title="Скачать" onclick="alert('Скачивание пока недоступно')">
                                <svg viewBox="0 0 16 16" fill="none" stroke="#888" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M8 2v8M5 7l3 3 3-3"/><path d="M3 11v2h10v-2"/>
                                </svg>
                            </button>
                            <form action="/file/delete/${file.originalName}" method="post" style="margin:0;">
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                <button type="submit" class="icon-btn del" title="Удалить">
                                    <svg viewBox="0 0 16 16" fill="none" stroke="#888" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M3 4h10M6 4V3h4v1M5 4l.5 8h5L11 4"/>
                                    </svg>
                                </button>
                            </form>
                        </div>
                    </div>
                </#list>
            </div>
        </div>

    </div>

    <script>
        document.getElementById('fileInput').addEventListener('change', function () {
            const list = document.getElementById('selectedFiles');
            list.innerHTML = '';
            for (const f of this.files) {
                const row = document.createElement('div');
                row.className = 'file-row';
                row.innerHTML = '<span class="file-name">' + f.name + '</span>'
                    + '<span class="file-meta">' + (f.size / 1024).toFixed(0) + ' KB</span>';
                list.appendChild(row);
            }
        });

        document.getElementById('uploadForm').addEventListener('submit', function (e) {
            e.preventDefault();
            const files = document.getElementById('fileInput').files;
            if (!files.length) { alert('Выберите файл'); return; }

            const wrap = document.getElementById('progressWrap');
            const bar  = document.getElementById('progressBar');
            const pct  = document.getElementById('uploadPct');
            const status = document.getElementById('uploadStatus');
            wrap.style.display = 'block';

            const formData = new FormData(this);
            const xhr = new XMLHttpRequest();

            xhr.upload.addEventListener('progress', e => {
                if (e.lengthComputable) {
                    const p = Math.round(e.loaded / e.total * 100);
                    bar.style.width = p + '%';
                    pct.textContent = p + '%';
                }
            });

            xhr.addEventListener('load', function () {
                if (xhr.status === 200) {
                    status.textContent = 'Готово';
                    bar.style.width = '100%';
                    pct.textContent = '100%';

                    const uploadedList = document.getElementById('uploadedFiles');
                    const now = new Date().toISOString().replace('T', ' ').split('.')[0];

                    for (const f of files) {
                        const row = document.createElement('div');
                        row.className = 'file-row';
                        row.style.animation = 'fadeIn 0.3s ease';
                        row.innerHTML =
                            '<div>' +
                            '<div class="file-name">' + f.name + '</div>' +
                            '<div class="file-meta">' + now + ' · ' + (f.type || '—') + ' · ' + f.size + '</div>' +
                            '</div>' +
                            '<div class="actions">' +
                            '<button type="button" class="icon-btn" title="Скачать" onclick="alert(\'Скачивание пока недоступно\')">' +
                            '<svg viewBox="0 0 16 16" fill="none" stroke="#888" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">' +
                            '<path d="M8 2v8M5 7l3 3 3-3"/><path d="M3 11v2h10v-2"/>' +
                            '</svg>' +
                            '</button>' +
                            '<button type="button" class="icon-btn del" title="Удалить (обновите страницу)">' +
                            '<svg viewBox="0 0 16 16" fill="none" stroke="#888" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">' +
                            '<path d="M3 4h10M6 4V3h4v1M5 4l.5 8h5L11 4"/>' +
                            '</svg>' +
                            '</button>' +
                            '</div>';
                        uploadedList.prepend(row);
                    }

                    document.getElementById('selectedFiles').innerHTML = '';
                    document.getElementById('fileInput').value = '';
                    setTimeout(() => { wrap.style.display = 'none'; }, 2000);

                } else {
                    status.textContent = 'Ошибка';
                }
            });

            xhr.addEventListener('error', () => {
                status.textContent = 'Ошибка соединения';
                setTimeout(() => { wrap.style.display = 'none'; }, 5000);
            });

            xhr.open('POST', '/file/upload');
            xhr.send(formData);
        });
    </script>

</@main.layout>
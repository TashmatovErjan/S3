<#import "../layout.ftlh" as main>
<@main.layout ; spring>
 <p>Hello</p>
 <form class="modal-content" action="/file/upload" method="post" enctype="multipart/form-data" id="uploadForm">
  <input type="hidden" name="_csrf" value="${_csrf.token}" />
  <div class="modal-header">
   <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Закрыть"></button>
  </div>
  <div class="modal-body">
   <input type="file" name="file" class="form-control" multiple id="fileInput">
  </div>
  <div class="modal-footer">
   <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
   <button type="submit" class="btn btn-primary">Загрузить</button>
  </div>
 </form>

 <div id="uploadContainer" style="display: none; margin-top: 16px;">
  <div id="fileList"></div>
  <div style="margin-top: 8px;">
   <small id="totalStatus"></small>
   <progress id="progressBar" value="0" max="100" style="width: 100%; margin-top: 4px;"></progress>
  </div>
 </div>

 <script>
  document.getElementById('uploadForm').addEventListener('submit', (event) => {
   event.preventDefault();
   const fileInput = document.getElementById('fileInput');
   const files = fileInput.files;

   if (files.length > 0) {
    uploadFiles(files);
   } else {
    alert('Пожалуйста, выберите файл.');
   }
  });

  function uploadFiles(files) {
   const container = document.getElementById('uploadContainer');
   const fileList = document.getElementById('fileList');
   const progressBar = document.getElementById('progressBar');
   const totalStatus = document.getElementById('totalStatus');

   container.style.display = 'block';
   fileList.innerHTML = '';
   progressBar.value = 0;
   totalStatus.textContent = '';

   for (let i = 0; i < files.length; i++) {
    const item = document.createElement('div');
    item.style.display = 'flex';
    item.style.justifyContent = 'space-between';
    item.style.padding = '4px 0';
    fileList.appendChild(item);
   }

   const formData = new FormData();
   for (let i = 0; i < files.length; i++) {
    formData.append('file', files[i]);
   }

   const csrfToken = document.querySelector('input[name="_csrf"]').value;
   formData.append('_csrf', csrfToken);

   const xhr = new XMLHttpRequest();

   xhr.upload.addEventListener('progress', function (event) {
    if (event.lengthComputable) {
     const percent = (event.loaded / event.total) * 100;
     progressBar.value = percent;
     totalStatus.textContent = `Загружено ${Math.round(percent)}%`;

     for (let i = 0; i < files.length; i++) {
      const status = document.getElementById(`fileStatus_${i}`);
      if (percent < 100) {
       status.textContent = 'Загрузка...';
       status.style.color = 'orange';
      }
     }
    }
   });

   xhr.addEventListener('load', function () {
    if (xhr.status === 200) {
     totalStatus.textContent = 'Все файлы загружены!';
     for (let i = 0; i < files.length; i++) {
      const status = document.getElementById(`fileStatus_${i}`);
      status.textContent = 'Загружен ✓';
      status.style.color = 'green';
     }
    } else {
     totalStatus.textContent = 'Ошибка при загрузке.';
     for (let i = 0; i < files.length; i++) {
      const status = document.getElementById(`fileStatus_${i}`);
      status.textContent = 'Ошибка ✗';
      status.style.color = 'red';
     }
    }

    setTimeout(() => {
     container.style.display = 'none';
    }, 10000);
   });

   xhr.addEventListener('error', function () {
    totalStatus.textContent = 'Произошла ошибка.';
    setTimeout(() => {
     container.style.display = 'none';
    }, 10000);
   });

   xhr.open('POST', '/file/upload');
   xhr.send(formData);
  }
 </script>

</@main.layout>
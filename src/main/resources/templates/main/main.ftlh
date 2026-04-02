<#import "../layout.ftlh" as main>
<@main.layout ; spring>
 <p>Hello</p>
 <form class="modal-content" action="/file/upload" method="post" enctype="multipart/form-data">
 <input type="hidden" name="_csrf" value="${_csrf.token}" />
 <div class="modal-header">
  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Закрыть"></button>
 </div>
 <div class="modal-body">
  <input type="file" name="file" class="form-control" multiple>
 </div>
 <div class="modal-footer">
  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
  <button type="submit" class="btn btn-primary">Загрузить</button>
 </div>
</form>
</@main.layout>
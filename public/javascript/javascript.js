$(function () {
  /**
   * Save category
   */
  $('#save_category').on('click', function () {
    $('#form_category').submit()
  });

  $('#add_category').on('click', () => {
    $('#form_category')[0].reset();
    $('#form_category').prop('action', '/category/add_category');
    $('#AddCategoryModal').text("Add New Category")
  })

  $('#delete_category').on('click', function () {
    let category_id = $('#category_id').val();

    if (category_id) {
      $.post('/category/delete_category', {category_id: category_id}, response => {
       if (response.success)
        window.location.reload();
      }, 'JSON')
    }
  })

  $('.category_table_contents a').on('click', function () {
    let category = $(this).data('category');
    let category_id = $(this).prop("id");

    $('#category_id').val(category_id);
    $('#category_name').val(category.name);
    $('#category_description').val(category.description);
    $('#form_category').prop('action', '/category/edit_category')
    $('#AddCategoryModal').text("Edit Category")
  });

  /**
   * Search through the pages.
   */
  $('#page_search').on('keyup', function() {
    let search = $(this).val().toLowerCase();
    let pages = sessionStorage.pages ? JSON.parse(sessionStorage.pages) : [];
    let table_body = ``;

    $.each(pages, function(index, value) {
      value.description = value.description ? value.description : '';

      if (value.title.toLowerCase().includes(search) || value.description.toLowerCase().includes(search)) {
        table_body += `<tr>`;
        table_body += `<td> <a href='${value.url}'> ${value.title}</a></td>`;
        table_body += `<td>${value.description}</td>`;
        table_body += `</tr>`;
      }
    });

    $('.table tbody').html(table_body);
  });

  /**
   * Search through the users.
   */
  $('#user_search').on('keyup', function() {
    let search = $(this).val();
    let users = $('#table-striped').data('users')
    let table_body = ``;

    $.each(users, function(index, value) {
      if (value.username.toLowerCase().includes(search) || value.email.toLowerCase().includes(search)) {
        table_body += `<tr>`;
        table_body += `<td>${value.first_name} ${value.last_name}</td>`;
        table_body += `<td>${value.username}</td>`;
        table_body += `<td>${value.email}</td>`;
        table_body += `</tr>`;
      }
    });

    $('.table tbody').html(table_body);
  });

});

  /**
   * Save new user
   */
  $('#save_user').on('click', function () {
    $('#form_user').submit()
  });

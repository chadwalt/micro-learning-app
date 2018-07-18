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
  })
});

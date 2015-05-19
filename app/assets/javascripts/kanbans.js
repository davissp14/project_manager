
$(function() {

  $(document).on('click', 'a.start-task', function(){
    var task_id = $(this).data('task');
    var profile_url = $(this).data('gravitar');
    var ele = $(this).closest('li');
    
    ele.remove();

    ele = setAction(ele, task_id)

    tag = '<li class="list-group-item kanban-tasks">'
    tag += setImage(ele, profile_url);
    tag += ele.html()
    tag += '</li>'

    $(tag).appendTo('ul.in_progress')
  })

  function setImage(ele, img) {
    return '<span class="kanban-task-owner"> \
              <img src="'+ img +'" height="35" width="35" style="border-radius: 25px;" /> \
            </span>';    
  }

  function setAction(ele, task) {
    html = '<a class="btn btn-active btn-xs complete-task" style="color: #fff;"" data-task="'+task+'" href="#">Complete</a>'
    ele.find('.kanban-task-actions').html(html)
    return ele
  }

  $(document).on('click', 'a.complete-task', function(){
    var task_id = $(this).data('task');
    var ele = $(this).closest('li');
    
    ele.remove();
    ele = removeAction(ele, task_id)

    $('ul.complete').append(ele);
  })

  function removeAction(ele, task) {
    ele.find('.kanban-task-actions').html('')
    return ele
  }

});

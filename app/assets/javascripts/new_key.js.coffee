$ ->
  $('body').on 'click', '#new-key', ->
    $this = $(this)
    $this.next().val($('#search_blurbs').val())
    $this.parents('form').submit()

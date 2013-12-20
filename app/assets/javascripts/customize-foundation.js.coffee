$ ->
  clearAlert = setTimeout(->
    $(".sitewide.alert-box").animate({ marginTop: "-43px", opacity: 0 }, 1000).remove(1)
  , 6000)
  $(document).on "click", ".sitewide.alert-box a.close",  ->
    clearTimeout clearAlert

  $(document).on 'click', '.trigger-tab', (e) ->
    e.preventDefault()
    $($(this).attr('href')).click()

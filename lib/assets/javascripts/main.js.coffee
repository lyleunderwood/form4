$ ->
  $.supersized {
    fit_portrait: 1,
    fit_landscape: 1,
    transition_speed: 1000,
    slide_interval: 2000,
    slides: [
      {
        image: '/images/backgrounds/1.jpg'
      },
      {
        image: '/images/backgrounds/2.jpg'
      }
    ]
  }

  load_content = (hash) ->
    target_slide = null

    target_slide = hash if hash.length > 0

    sections = $('#sections .section')
    sections.hide()

    if target_slide
      $('#' + target_slide).show()

  link_navigate = (e) ->
    url = $(this).attr 'href'
    url = url.replace(/^.*##?/, '')
    url = '' if url == 'home'
    $.history.load url

    false

  setup_history = ->
    $.history.init load_content

    $('#navigation a, .home_link').not('external-link').click link_navigate

  setup_history() unless screen.width < 768

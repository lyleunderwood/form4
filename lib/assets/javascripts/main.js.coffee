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
    if hash.length > 0
      target_slide = hash + '_slide'

    sections = $('#sections .section')
    sections.hide()

    if target_slide
      $('#' + target_slide).show()


    console.log(hash, target_slide, sections)

  link_navigate = (e) ->
    url = $(this).attr 'href'
    url = url.replace(/^.*#/, '')
    $.history.load url

    false

  $.history.init load_content

  $('#navigation a, .home_link').not('external-link').click link_navigate

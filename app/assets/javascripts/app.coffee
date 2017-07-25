if navigator.userAgent.match(/IEMobile\/10\.0/)
  msViewportStyle = document.createElement('style')
  msViewportStyle.appendChild document.createTextNode('@-ms-viewport{width:auto!important}')
  document.getElementsByTagName('head')[0].appendChild msViewportStyle

document.addEventListener('turbolinks:before-cache', () ->
  document.querySelectorAll('*[uk-icon] > svg').forEach((elem) ->
    elem.remove()
  )
)

$(document).on "turbolinks:load", ->
  document.querySelectorAll('[data-slug]').forEach((i) ->
    i.addEventListener('change', () ->
      document.getElementById(i.getAttribute('data-slug')).value = slugify(i.value)
    )
  )

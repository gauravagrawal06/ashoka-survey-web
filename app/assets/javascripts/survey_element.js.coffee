# Binding between the actual and dummy fieldsets

class SurveyElement
  constructor: (@actual, @dummy) ->
    @actual.find('*').bind('keyup change', @mirror)

  mirror: (event) =>
    name = $(event.target).attr('name')

    dummy_val = $(event.target).val()
    if dummy_val == "" && $(event.target).attr('type') == "text"
      dummy_val = SurveyApp.SurveyBuilder.translations.untitled

    @dummy.find("*[name=\"#{name}\"]").val(dummy_val);
    @dummy.find("*[name=\"#{name}\"]").text(dummy_val);

  show: (event) =>
    @actual.show()
    if @dummy.attr('id') == "dummy_survey_details"
      @dummy.addClass("details_active")
    else
      @dummy.addClass("active")    

  hide: =>
    @actual.hide()
    @dummy.removeClass("active")
    @dummy.removeClass("details_active")

SurveyApp.SurveyElement = SurveyElement
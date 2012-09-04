# Collection of dummy questions
class SurveyBuilder.Views.DummyPaneView extends Backbone.View
  el: "#dummy_pane"

  initialize: ->
    @questions = []

  add_question: (type, model) ->
    if type == 'radio'
      @questions.push(new SurveyBuilder.Views.Dummies.RadioQuestionView(model))
      this.render()

  render: ->
    $(this.el).append(question.render().el) for question in @questions
    return this

  remove_all_active: ->
    $(question.el).removeClass("active") for question in @questions
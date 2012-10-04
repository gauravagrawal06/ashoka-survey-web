SurveyBuilder.Views.Questions ||= {}

# The settings of a single single line question in the DOM
class SurveyBuilder.Views.Questions.SurveyDetailsView extends Backbone.View

  events:
    'keyup  input[type=text]': 'handle_textbox_keyup'

  initialize: ->
    this.model.actual_view = this
    @template = this.options.template
    this.model.on('change', this.render, this)
    console.log(@template)

  render:(template) ->
    $(this.el).html(Mustache.render(this.template, this.model.toJSON()))
    return this

  handle_textbox_keyup: (event) ->
    this.model.off('change', this.render)
    input = $(event.target)
    propertyHash = {}
    propertyHash[input.attr('name')] = input.val()
    this.update_model(propertyHash)

  update_model: (propertyHash) ->
    this.model.set(propertyHash)

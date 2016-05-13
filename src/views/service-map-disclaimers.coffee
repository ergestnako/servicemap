define [
    'i18next',
    'cs!app/views/base',
    'cs!app/tour',
    'cs!app/views/feature-tour-start'
],
(
    {t: t},
    {SMItemView: SMItemView},
    tour,
    TourStartButtonView
) ->
    ServiceMapDisclaimersView: class ServiceMapDisclaimersView extends SMItemView
        template: 'description-of-service'
        className: 'content modal-dialog about'
        events:
            'click .uservoice-link': 'openUserVoice'
            'click .accessibility-stamp': 'onStampClick'
            'click .start-tour-button': 'onTourStart'
        openUserVoice: (ev) ->
            UserVoice = window.UserVoice || [];
            UserVoice.push ['show', mode: 'contact']
        onStampClick: (ev) ->
            app.commands.execute 'showAccessibilityStampDescription'
            ev.preventDefault()
        onTourStart: (ev) ->
            $('#feedback-form-container').modal('hide');
            tour.startTour()
            app.getRegion('tourStart').currentView.trigger 'close'
            @remove();
        serializeData: ->
            lang: p13n.getLanguage()

    ServiceMapAccessibilityDescriptionView: class ServiceMapAccessibilityDescriptionView extends SMItemView
        template: 'description-of-accessibility'
        className: 'content modal-dialog about'
        events:
            'click .uservoice-link': 'openUserVoice'
        serializeData: ->
            lang: p13n.getLanguage()
        onRender: ->
            @$el.scrollTop()

    ServiceMapDisclaimersOverlayView: class ServiceMapDisclaimersOverlayView extends SMItemView
        template: 'disclaimers-overlay'
        serializeData: ->
            layer = p13n.get('map_background_layer')
            if layer in ['servicemap', 'accessible_map']
                copyrightLink = "https://www.openstreetmap.org/copyright"
            copyright: t "disclaimer.copyright.#{layer}"
            copyrightLink: copyrightLink
        events:
            'click #about-the-service': 'onAboutClick'
            'click #about-accessibility-stamp': 'onStampClick'
            'click .accessibility-stamp': 'onStampClick'
        onAboutClick: (ev) ->
            app.commands.execute 'showServiceMapDescription'
            ev.preventDefault()
        onStampClick: (ev) ->
            app.commands.execute 'showAccessibilityStampDescription'
            ev.preventDefault()

{% extends "base.tpl" %}

{% block page_class %}page {% if id.name %}{{ id.name }}{% endif %} {% if m.rsc[id].media|without_embedded_media:id %}has_images{% endif %}{% endblock %}

{% block content %}

    {% block content_header %}
        <h1>{{ id.title }}</h1>
    {% endblock %}

    {{ id.body|show_media }}

    {% block post_body %}
    {% endblock %}

{% endblock %}


{% block side %}
    {% with m.rsc[id].media|without_embedded_media:id as images %}
        {% if images %}
            <div class="side-images">
                {% for img in images %}
                    {% catinclude "helper/_image.tpl" img width=446 %}
                {% endfor %}
            </div>
        {% endif %}
    {% endwith %}
{% endblock %}

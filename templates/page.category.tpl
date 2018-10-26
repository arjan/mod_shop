{% extends "page.tpl" %}

{% block content %}
    <h1>{{ id.title }}</h1>
    <p>All the products in category {{ id.title }}</p>

    <div>
        {% with m.search[{query cat=id.name sort='created'}] as r %}
            {% for id in r %}
                {% catinclude "helper/_listitem.tpl" id %}
            {% endfor %}
        {% endwith %}

        <div class="clear"></div>
    </div>
{% endblock %}

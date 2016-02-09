{% extends "page.tpl" %}

{% block content %}
<div class="fullimage">
    {% image id.o.depiction[1] width=1200 upscale %}
    {% if id.body %}
    <div class="body">
        {{ id.body }}
    </div>
    {% endif %}
</div>
{% endblock %}

{% block bottom %}
{% endblock %}

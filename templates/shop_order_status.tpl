{% extends "page.tpl" %}

{% block content %}
{% with m.rsc[q.id] as r %}

<h1>{{ r.title }}</h1>

{% print r.status  %}

{% endwith %}

{% endblock %}

{% extends "base.tpl" %}

{% block page_class %}outfit{% endblock %}

{% block content %}
<div class="outfit-wrapper">
    {% include "helper/_prevnext.tpl" %}

    {% with id.o.depiction[1], id.o.depiction|slice:[2,3], id.o.depiction|slice:[4,16] as firstimage, next2, rest %}

    <div class="main-image">
        <div class="do_imagemagnifier" data-imagemagnifier="fullsize: '{% image_url firstimage width=2000 height=2550 upscale crop  %}'">
            {% image firstimage width=420 height=510 upscale crop class="source" %}
            <div class="target"></div>
        </div>
    </div>

    <div class="outfit-details">

        <div class="content-block">
            <h1>{{ id.title }}</h1>

            {{ id.body|show_media }}
        </div>

        <div class="outfit-grid">
            {% for id in next2 %}
            {% include "helper/_outfit_thumb.tpl" %}
            {% endfor %}
        </div>
    </div>
        <div class="clear"></div>

    <div class="outfit-grid">
        {% for id in rest %}
        {% include "helper/_outfit_thumb.tpl" %}
        {% endfor %}
    </div>
    <div class="clear"></div>
</div>

{% endwith %}
{% endblock %}

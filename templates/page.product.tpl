{% extends "page.tpl" %}

{% block page_class %}product{% endblock %}

{% block content %}
{% include "helper/_prevnext.tpl" id=id %}

{% with q.variant|default:m.rsc[id].o.has_variant[1] as variant_id %}

<div class="main-image">
    <div class="do_imagemagnifier" data-imagemagnifier="fullsize: '{% image_url m.rsc[variant_id].depiction width=2000 height=2550 upscale crop  %}'">
        {% image m.rsc[variant_id].depiction width=400 height=510 upscale crop class="source" %}
        <div class="target"></div>
    </div>
    <div class="below-image">
        <a href="#">Click to view large image</a>
    </div>
</div>

<div class="product-details">

    <div class="content-block">
        <h1>{{ id.title }}</h1>

        {{ id.body|show_media }}
    </div>

    <div class="content-block price">
        &euro; {{ m.rsc[variant_id].price|format_integer }},-
    </div>

    <div class="content-block basket-form">
        {% include "helper/_product_basket_form.tpl" %}
    </div>

</div>

<div class="clear"></div>

<div class="variant-thumbs">
    {% for id in m.rsc[variant_id].o.depiction|slice:[4] %}
    <a href="javascript:;" class="view-variant-image"
       data-bigimage="{% image_url id width=2000 height=2550 upscale crop %}"
       data-smallimage="{% image_url id width=400 height=510 upscale crop %}"
       >{% image id width=124 height=157 crop %}</a>
    {% endfor %}

    <div class="wear-it">
        {% if m.rsc[id].o.suggestion %}
        <span class="wear-it">wear it with</span>
    
        {% for id in m.rsc[id].o.suggestion|slice:[3] %}
        <a href="{{ id.page_url }}" title="{{ id.title }}"
           >{% image id.o.has_variant[1] width=124 height=157 crop %}</a>
        {% endfor %}
        {% endif %}
    </div>

</div>

<div class="clear"></div>

{% endwith %}
{% endblock %}

{% block side %}
{% endblock %}

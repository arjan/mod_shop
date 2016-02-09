<div class="do_metaframe product-thumb">
    <a class="metaframe-trigger" href="{{ id.page_url }}">{% image id.o.has_variant[1] width=124 height=157 crop %}</a>
    <div class="metaframe-popup product-popup do_varianthover">
        <h3> {{ id.title }} </h3>
        <div class="metaframe-placeholder"></div>
        {% if id.o.has_variant|length > 1 %}
        <ul class="variants">
            {% for vid in id.o.has_variant %}
            <li data-variantimage="{% image_url vid.depiction
                                   width=124 height=157 crop %}">
                <a href="{{ id.page_url }}?variant={{ vid }}">
                    {% image vid.depiction width=25 height=31 crop %}
                </a>
            </li>
            {% endfor %}
        </ul>
        {% endif %}
    </div>
</div>

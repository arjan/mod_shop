
<p class="prev-next">

    {% with m.search[{previous id=id cat=id.category.id pagelen=1}]|first as p %}
    {% if p %}
    <a class="prev" href="{{ m.rsc[p].page_url }}" title="{{ m.rsc[p].title }}">previous &lt;</a>
    {% else %}
    <span class="prev">previous &lt;</a>
    {% endif %}
    {% endwith %}

    {% with m.search[{next id=id cat=id.category.id pagelen=1}]|first as p %}
    {% if p %}
    <a class="next" href="{{ m.rsc[p].page_url }}" title="{{ m.rsc[p].title }}">&gt; next</a>
    {% else %}
    <span class="next" >&gt; next</a>
    {% endif %}
    {% endwith %}
    
</p>
<div class="clear"></div>

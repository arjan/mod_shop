<a href="{{ m.rsc.page_shoppingcart.page_url }}">
    {% if m.shoppingcart.count %}
    Shopping basket ({{ m.shoppingcart.count }} item{% if m.shoppingcart.count>1 %}s{% endif %}) &euro; {{ m.shoppingcart.total|format_price }}
    {% else %}
    Shopping basket is empty
    {% endif %}
</a>

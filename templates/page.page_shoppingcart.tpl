{% extends "page.tpl" %}

{% block post_body %}

{% with m.shoppingcart.items as items %}
{% if items %}
<table width="100%" class="cart">
    <tr>
        <th width="45%">&nbsp;</th>
        <th width="10%">Color</th>
        <th width="10%" class="right">Size</th>
        <th width="15%" class="right">Price</th>
        <th width="10%" class="right">Amount</th>
        <th width="10%">&nbsp;</th>
    </tr>
    {% for item, count in items %}
    {% with item.variant_id as vid %}
    <tr>
        <td>
            <a href="{{ item.id.page_url }}?variant={{ item.variant_id }}">{{ m.rsc[item.id].title }}</a>
        </td>
        <td>
            {{ m.rsc[item.variant_id].short_title|default:m.rsc[item.variant_id].title }}
        </td>
        <td class="right">
            {{ item.size }}
        </td>
        <td class="right">
            &euro; {{ item.price|format_price }}
        </td>
        <td class="right">
            <input name="amount" id="{{ #amount.vid }}" size="2" maxlength="2" value="{{ count }}" />
            {% wire id=#amount.vid action={update_cart_amount item=item action={reload}} type="change" %}
        </td>
        <td class="right">
            {% button action={remove_from_cart item=item action={reload}} text="X" %}
        </td>
    </tr>
    {% endwith %}
    {% endfor %}

    <tr>
        <td colspan="3" class="right">
            SubTotal:
        </td>
        <td class="right">
            &euro; {{ m.shoppingcart.total|format_price }}
        </td>
        <td colspan="2">
            &nbsp;
        </td>
    </tr>

    <tr>
        <td colspan="3" class="right">
            Grand total:
        </td>
        <td class="right">
            &euro; {{ m.shoppingcart.total|format_price }}
        </td>
        <td colspan="2">
            &nbsp;
        </td>
    </tr>
       
</table>

    <p class="cart-buttons">
        <a class="back" href="javascript:history.go(-1);">Continue shopping</a>
    
        {% button action={redirect location=m.rsc.page_checkout.page_url} text="proceed to checkout" %}
        <a class="update" href="#">Update cart</a>

    </p>
    
{% else %}
<p>Shopping cart is empty.</p>
{% endif %}
{% endwith %}

{% endblock %}

{% block bottom %}

{% endblock %}

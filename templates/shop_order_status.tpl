{% extends "page.tpl" %}

{% block content %}
{% with m.session.shop_order as o %}

{% if not o %}
<h1>Order not found</h1>
{% else %}
<h1>{_ Thank you for your order! _}</h1>

<p>Your order with id <strong>{{ o.id }}</strong> has been successfully processed. Please write this number down for further reference.</p>

<p>A confirmation e-mail has been sent to <strong>{{ o.order.details.email }}</strong>.</p>

{% include "_order_details.tpl" order=o %}

{% endif %}
{% endwith %}

{% endblock %}

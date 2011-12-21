{% extends "email_base.tpl" %}

{% block title %}
{{ m.site.title }} order confirmation
{% endblock %}

{% block body %}
{% with m.rsc[order_id] as order %}
<p>Dear {{ order.order.details.firstname }} {{ order.order.details.lastname }},</p>

<p>Thank you for your order at {{ m.site.title }}. This e-mail confirms your order.</p>

{% include "_order_details.tpl" order=order %}

<p>For more information, please e-mail us at {{ m.site.reply_to }} or use the "reply" button of your e-mail client.</p>

<p>Kind regards,</p>

<p>{{ m.site.title }}</p>

{% endwith %}
{% endblock %}



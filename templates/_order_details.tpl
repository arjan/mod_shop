
<h2>Order {{ order.id }}</h2>

<p>Placed on {{ order.created|date:"j F Y, H:i" }}</p>

<p>Order status: <strong>{{ order.status }}</strong></p>

{% if order.status == 'paid' %}
<p>
    Payment method: {{ order.payment.paymentMethod }}<br />
    Payment reference: {{ order.payment.pspReference }}
</p>
{% endif %}


<table style="width: 500px">
    <tr>
        <th>Item</th>
        <th>Variant</th>
        <th>Size</th>
        <th>Amount</th>
        <th>Price</th>
        <th>Total price</th>
    </tr>

    {% for line in order.order.cart.items %}
    <tr>
        <td>
            {{ line.id.title }}
        </td>
        <td>
            {{ line.variant_id.title }}
        </td>
        <td>
            {{ line.size }}
        </td>
        <td>
            {{ line.amount }}
        </td>
        <td>
            {{ line.price }}
        </td>
        <td>
            {{ line.amount * line.price }}
        </td>
    </tr>
    {% endfor %}
    <tr>
        <td colspan="5">
            Order total ex. VAT
        </td>
        <td>
            {{ order.order.price_ex_vat/100 }}
        </td>
    </tr>
    <tr>
        <td colspan="5">
            <strong>Order total (incl. VAT)</strong>
        </td>
        <td>
            <strong>{{ order.order.price_inc_vat/100 }}</strong>
        </td>
    </tr>
</table>

<h2>Address details</h2>

<p>
    {{ order.order.details.firstname }} {{ order.order.details.lastname }}<br />
    {{ order.order.details.address }}<br />
    {{ order.order.details.postcode }} {{ order.order.details.city }}<br />
</p>
<p>
    E-mail: {{ order.order.details.email }}<br />
    Phone: {{ order.order.details.phone }}<br />
</p>


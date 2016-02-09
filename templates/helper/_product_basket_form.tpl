{% wire id="basket-form" type="submit" postback={add_to_cart id=id variant_id=variant_id action={redirect location="/cart"}} delegate="mod_shop" %}
<form id="basket-form" method="post" action="postback">
    <table>
        <tr>
            <th>
                Color
            </th>
            <td>
                {% for id in id.o.has_variant %}
                <a class="variant-link {% if id == variant_id
                          %}current{% endif %}" href="?variant={{ id
                                                      }}"
                   style="background-color: {{ id.color }}" title="{{ id.short_title|default:id.title }}"><span></span></a>
                {% endfor %}
                <div class="clear"/>
            </td>
        </tr>
        <tr>
            <th>
                Size
            </th>
            <td>
                <select name="size" id="size">
                    {#<option>Choose a size</option>#}
                    <option value="S">Small</option>
                    <option value="M" selected>Medium</option>
                    <option value="L">Large</option>
                    <option value="XL">Extra large</option>
                </select>

                <a href="#" onclick="$('#size-chart').fadeToggle()">Size chart</a>
            </td>
        </tr>
        <tr>
            <th>
                Amount
            </th>
            <td>
                <input name="amount" id="amount" size="2" value="1" />
                {% validate id="amount" type={presence} %}
            </td>
        </tr>
        <tr>
            <th>
                &nbsp;
            </th>
            <td>
                <input value="color {% if not m.rsc[variant_id].stock %}not{% endif %} in stock" readonly />
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                {% button text=_"Add to Basket" disabled=(not m.rsc[variant_id].stock) %}
            </td>
        </tr>
    </table>


</form>
<img id="size-chart" src="/lib/images/size-chart.png" onclick="$('#size-chart').fadeOut()" />

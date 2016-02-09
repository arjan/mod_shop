{% with id|menu_trail as menu_ids %}

<div id="header">
    <div class="container">
        <img src="/lib/images/mainlogo.png" class="logo" />

        {% block minicart %}
        <div id="minicart">
            {% include "helper/_minicart.tpl" %}
        </div>
        {% wire action={connect signal={shoppingcart_changed cart=m.persistent.persistent_id}  action={update target="minicart" template="helper/_minicart.tpl"}} %}
        {% endblock %}
        
        <ul id="navigation">

            {% for mid, children in m.rsc.main_menu.menu %}
            <li>
                <a href="{{ m.rsc[mid].page_url }}" {% if menu_ids[1] == mid %}class="current"{% endif %}>
                    {{ m.rsc[mid].short_title|default:m.rsc[mid].title }}
                </a>
            </li>
            {% endfor %}
        </ul>
    </div>
</div>

{% for mid, children in m.rsc.main_menu.menu %}
{% if mid == menu_ids[1] and children %}
<div class="mainsection">
    <div class="container">
        <ul id="subnavigation">
            {% if mid.is_a.category %}
            <li>
                <a href="{{ m.rsc[mid].page_url }}" {% if menu_ids == [mid] %}class="current"{% endif %}>
                    View all
                </a>
            </li>
            {% endif %}
            
            {% for mid, children in children %}
            <li>
                <a href="{{ m.rsc[mid].page_url }}" {% if menu_ids[2] == mid %}class="current"{% endif %}>
                    {{ m.rsc[mid].short_title|default:m.rsc[mid].title }}
                </a>
            </li>
            {% endfor %}
        </ul>
    </div>
</div>
{% endif %}
{% endfor %}

{% endwith %}

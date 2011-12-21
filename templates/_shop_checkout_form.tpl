{% wire id="checkout-form" type="submit" postback={checkout} delegate="mod_shop" %}
<form class="checkout" id="checkout-form" method="post" action="postback">

    <div class="element">
        <label>
            <h3>{_ First name _}</h3>
            <input type="text" name="firstname" id="firstname" />
            {% validate id="firstname" type={presence} %}
        </label>
    </div>

    <div class="element">
        <label>
            <h3>{_ Last name _}</h3>
            <input type="text" name="lastname" id="lastname" />
            {% validate id="lastname" type={presence} %}
        </label>
    </div>

    <div class="element">
        <label>
            <h3>{_ Address _}</h3>
            <input type="text" name="address" id="address" />
            {% validate id="address" type={presence} %}
        </label>
    </div>

    <div class="element">
        <label>
            <h3>{_ Postcode / city _}</h3>
            <input type="text" name="postcode" id="postcode" size="4" />
            <input type="text" name="city" id="city" />
            {% validate id="postcode" type={presence} %}
            {% validate id="city" type={presence} %}
        </label>
    </div>

    <div class="element">
        <label>
            <h3>{_ Phone _}</h3>
            <input type="text" name="phone" id="phone" />
            {% validate id="phone" type={presence} %}
        </label>
    </div>

    <div class="element">
        <label>
            <h3>{_ Email _}</h3>
            <input type="text" name="email" id="email" />
            {% validate id="email" type={presence} type={email} %}
        </label>
    </div>

    <div>
        {% with m.shop.payment_providers as p %}
        {% if p|length == 1 %}

        Payment will be done with {{ p[1].name }}
        <input type="hidden" name="payment-provider" value="{{ p[1].module }}" />
        
        {% else %}
        Choose payment provider
        <select name="payment-provider">
            {% for pr in p %}
            <option value="{{ pr.module }}">{{ pr.name }}</option>
            {% endfor %}
        </select>
        {% endif %}
    </div>

    {% endwith %}
    
    {% button text=_"Place order" %}
    
</form>

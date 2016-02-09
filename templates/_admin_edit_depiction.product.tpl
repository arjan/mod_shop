<h2>Variants</h2>

{% for id in m.rsc[id].o.has_variant %}
    <div class="pull-right">
        <span style="background-color: {{ id.color}}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <span>Stock: {{ id.stock|default:0}}</span>
        <span>Price: {{ id.price|default:0}} EUR</span>
        
        <span><a href class="btn btn-sm btn-default" id="{{ #edit.id }}">edit</a></span>
    </div>

    <h3>
        {{ id.title }}        
    </h3>
    {% wire id=#edit.id text=_"edit" action={dialog_edit_basics id=id action={reload}} %}

{% catinclude "_admin_edit_depiction.tpl" id is_editable=is_editable languages=languages %}
{% endfor %}

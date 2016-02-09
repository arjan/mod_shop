{% with m.rsc[id] as r %}
{% with m.rsc[id].is_editable as is_editable %}
<fieldset class="{% if not in_dialog %}admin-form{% endif %}">
	<div class="form-item clearfix">
		<label for="field-title{{ lang_code_with_dollar }}">{_ Title _} {{ lang_code_with_brackets }}</label>
		<input type="text" id="field-title{{ lang_code_with_dollar }}" name="title{{ lang_code_with_dollar }}" 
			value="{{ is_i18n|if : r.translation[lang_code].title : r.title }}"
			{% if not is_editable %}disabled="disabled"{% endif %}
			{% include "_language_attrs.tpl" language=lang_code class="field-title" %} />
	</div>

	<div class="form-item clearfix">
		<label for="field-short_title{{ lang_code_with_dollar }}">{_ Short title _} {{ lang_code_with_brackets }}</label>
		<input type="text" id="field-short_title{{ lang_code_with_dollar }}" name="short_title{{ lang_code_with_dollar }}" 
			value="{{ is_i18n|if : r.translation[lang_code].short_title : r.short_title }}"
			{% if not is_editable %}disabled="disabled"{% endif %}
			{% include "_language_attrs.tpl" language=lang_code class="field-short_title" %} />
	</div>
        
	<div class="form-item clearfix">
		<label for="field-color">{_ Color _}</label>
		<input type="text" id="field-color" name="color"
                       class="do_ColorPicker" autocomplete="off" data-colorpicker="onSubmit: function(hsb, hex, rgb, el) {console.log(arguments);$(el).val('#'+hex).ColorPickerHide();}"
			value="{{ id.color|escape }}"
			{% if not is_editable %}disabled="disabled"{% endif %} />
	</div>

        <div class="form-item clearfix">
	    <label for="field-stock">{_ Stock _}</label>
	    <input type="text" id="field-stock" name="stock"
		   value="{{ id.stock|escape }}"
		   {% if not is_editable %}disabled="disabled"{% endif %} />
	</div>

        <div class="form-item clearfix">
	    <label for="field-price">{_ Price _}</label>
	    <input type="text" id="field-price" name="price"
		   value="{{ id.price|escape }}"
		   {% if not is_editable %}disabled="disabled"{% endif %} />
	</div>

</fieldset>

{% endwith %}
{% endwith %}

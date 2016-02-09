<!DOCTYPE html>
<html lang="en"
      xmlns:og="http://ogp.me/ns#"
      >
    <head>
        <title>{% block title %}{% endblock %}{% block titlesep %}{% endblock %}{{ m.config.site.title.value }}</title>
        <meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
        <meta name="author" content="Arjan Scherpenisse arjan@miraclethings.nl &copy; 2011" />

        <link rel="shortcut icon" href="/favicon.ico" />

        <meta property="og:title" content="{% block title %}{{ m.site.title }}{% endblock %}"/>
        {% if id %}
        {% with m.rsc[id].media|first as first_media %}{% if first_media %}
        <meta property="og:image" content="http://{{ m.site.hostname }}{% image_url first_media width=500 %}"/>
        {% endif %}{% endwith %}
        <meta property="og:site_name" content="{{ m.site.title }}"/>
        {% if m.rsc[id].summary %}<meta property="og:description" content="{{ m.rsc[id].summary|escape }}"/>{% endif %}
        {% endif %}{# id #}

        {% include "_js_include_jquery.tpl" %}

        {% all include "_html_head.tpl" %}

        {% lib "ui-metaframe/metaframe.css" "css/normalize.css" "css/museo.css" "css/base.css" %}
        
        {% if m.config.site.google_key.value %}
            <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key={{ m.config.site.google_key.value }}"></script>
        {% endif %}

        {% block html_head_extra %}{% endblock %}
        <link rel="shortcut icon" href="/lib/images/favicon.ico" type="image/x-icon" />
    </head>

    <body class="{% block page_class %}page{% endblock %}">
        {% include "helper/_header.tpl" %}

        <div class="mainsection">
            <div class="container" id="top">
                <div class="content">
                    {% block content_area %}
                    {% block content %}

                    {% endblock %}
                    {% endblock %}{# content_area #}
                </div>

                {% block side %}
                {% endblock %}

                <div class="clear"></div>
                {% block bottom %}
                <div class="back-to-top"><a href="#top">Back to top</a></div>
                {% endblock %}
                
            </div>
        </div>

        {% include "helper/_footer.tpl" %}

        {% include "_js_include.tpl" %}

        {% lib "ui-metaframe/ui.metaframe.js" "js/ui.imagemagnifier.js" "js/ui.varianthover.js" "js/ui.maplocation.js" "js/shop.js" %}

        {% block _js_include_extra %}{% endblock %}

        {% script %}

        {% all include "_html_body.tpl" %}
    </body>
</html>

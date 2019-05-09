---
{%- from "spamassassin/map.jinja" import spamassassin with context %}

{%- for file in ['v310', 'v312', 'v320', 'v330', 'v340', 'v341', 'v342'] %}
spamassassin_plugin_pre_{{ file }}_cleanup:
  file.absent:
    - name: {{ spamassassin.config_dir }}/{{ file }}.pre
    - watch_in:
      - service: spamassassin_service

{%- endfor %}

spamassassin_plugin_configuration:
  file.managed:
    - name: {{ spamassassin.config_dir }}/init.pre
    - source: salt://spamassassin/files/init.pre
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - context:
        plugins: {{ spamassassin.plugins | json() }}
    - watch_in:
      - service: spamassassin_service

{% for source in spamassassin.get('local_plugins', []) %}
{% set basename = source.split('/') | last %}
spamassassin_plugin_install_{{ basename }}:
  file.managed:
    - name: /usr/share/perl5/vendor_perl/Mail/SpamAssassin/Plugin/{{ basename }}
    - source: {{ source }}
    - watch_in:
      - service: spamassassin_service
{% endfor %}

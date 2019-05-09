{%- from "spamassassin/map.jinja" import spamassassin with context %}

{%- for channel, items in spamassassin.channels.items() %}
{%-   if items.state == 'absent' %}
spamassassin_channel_{{ channel }}_remove:
  file.absent:
    - name: {{ spamassassin.channel_dir }}/{{ channel }}.conf

{%-   elif items.state == 'present' %}
spamassassin_channel_{{ channel }}_add:
  file.managed:
    - name: {{ spamassassin.channel_dir }}/{{ channel }}.conf
    - source: salt://spamassassin/files/channel-template.jinja2
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - context:
        comment: {{ items.comment }}
        host: {{ items.host }}
        gpg_id: {{ items.gpg_id }}
        gpg_key: |
          {{ items.gpg_key | indent(10) }}

{%-   endif %}
{%- endfor %}

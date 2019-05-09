---
{%- from "spamassassin/map.jinja" import spamassassin with context %}

spamassassin_local_configuration:
  file.managed:
    - name: {{ spamassassin.config_dir }}/local.cf
    - source: salt://spamassassin/files/spamassassin.cf
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - context:
        config: {{ spamassassin.get('config', {}) | json() }}
        whitelist: {{ spamassassin.get('whitelist', {}) | json() }}
        blacklist: {{ spamassassin.get('blacklist', {}) | json() }}
        local_rules: {{ spamassassin.get('local_rules', {}) | json() }}
    - watch_in:
      - service: spamassassin_service

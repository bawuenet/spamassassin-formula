{%- from "spamassassin/map.jinja" import spamassassin with context %}
---

spamassassin_milter_pkg:
  pkg.installed:
    - name: {{ spamassassin.milter_pkg }}

{% if spamassassin.milter_postfix %}
spamassassin_milter_postfix_pkg:
  pkg.installed:
    - name: {{ spamassassin.milter_postfix_pkg }}
{% endif %}

spamassassin_milter_config:
  file.managed:
    - name: /etc/sysconfig/spamass-milter
    - source: salt://spamassassin/files/spamassassin-milter.sysconf
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - context:
      options: {{ spamassassin.get('milter', {}) | json() }}

spamassassin_milter_service:
  service.running:
    - name: {{ spamassassin.service }}
    - enable: True
    - require:
      - pkg: spamassassin_milter_pkg
    - watch_any:
      - pkg: spamassassin_milter_pkg
      - pkg: spamassassin_milter_postfix_pkg
      - file: spamassassin_milter_config

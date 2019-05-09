---
{%- from "spamassassin/map.jinja" import spamassassin with context %}

include:
  - .user
  - .package

spamassassin_spamd_config:
  file.managed:
    - name: /etc/sysconfig/spamassassin
    - source: salt://spamassassin/files/spamd.sysconf
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - context:
      options: {{ spamassassin.get('spamd', {}) | json() }}


spamassassin_service:
  service.running:
    - name: {{ spamassassin.service }}
    - enable: True
    - require:
      - pkg: spamassassin_package
    - watch_any:
      - pkg: spamassassin_package
      - file: spamassassin_spamd_config

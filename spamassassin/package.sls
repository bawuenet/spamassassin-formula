{%- from "spamassassin/map.jinja" import spamassassin with context %}

spamassassin_package:
  pkg.installed:
    - name: {{ spamassassin.package }}

{%- if spamassassin.get('local_packages', {}) | length > 0 %}
spamassassin_local_packages:
  pkg.installed:
    - sources:
{%-   for pkg in spamassassin.local_packages %}
      - {{ (pkg.split('/') | last).split('-')[:-2] | join('-') }}: {{ pkg }}
{%-   endfor %}
    - watch_in:
      - service: spamassassin_service
{%- endif %}

{%- if spamassassin.get('extra_packages', {}) | length > 0 %}
spamassassin_extra_packages:
  pkg.installed:
    - pkgs:
{%-   for pkg in spamassassin.extra_packages %}
      - {{ pkg }}
{%-   endfor %}
    - watch_in:
      - service: spamassassin_service
{%- endif %}

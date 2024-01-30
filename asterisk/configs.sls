# -*- coding: utf-8 -*-
# vim: ft=sls
---

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import asterisk with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

asterisk-configs:
  file.recurse:
    - name: /etc/asterisk
    - source: {{ files_switch(['/etc/asterisk']) }}
    - template: jinja
    - context: {{ asterisk }}
{%- if asterisk.force_update %}
    - replace: True
    - clean: True
{%- else %}
    - replace: False
{%- endif %}

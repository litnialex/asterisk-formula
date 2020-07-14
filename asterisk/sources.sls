# -*- coding: utf-8 -*-
# vim: ft=sls
---

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import asterisk with context %}

asterisk-sources:
  git.latest:
    - name: https://github.com/asterisk/asterisk.git
    - branch: {{ asterisk.rev }}
    - rev: {{ asterisk.rev }}
    - depth: 1
    - fetch_tags: False
    - target: {{ asterisk.src_dir }}
    - creates: {{ asterisk.src_dir }}/.git

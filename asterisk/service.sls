# -*- coding: utf-8 -*-
# vim: ft=sls
---

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import asterisk with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

asterisk-user:
  user.present:
    - name: {{ asterisk.user }}
    - groups: {{ asterisk.groups }}
    - usergroup: True
    - shell: /bin/bash
    - home: /var/lib/asterisk

asterisk-directories:
  file.directory:
    - names:
      - /var/log/asterisk
      - /var/run/asterisk
      - /var/lib/asterisk
      - /var/spool/asterisk
    - user: {{ asterisk.user }}
    - recurse:
      - user

asterisk-service:
  file.managed:
    - names:
      - /etc/logrotate.d/asterisk:
        - source: {{ files_switch(['/etc/logrotate.d/asterisk'], indent_width=10) }}
      - /etc/systemd/system/asterisk.service:
        - source: {{ files_switch(['/etc/systemd/system/asterisk.service'], indent_width=10) }}
    - template: jinja
    - context: {{ asterisk }}
    - backup: minion

asterisk-running:
{%- if grains.init in ["systemd"]  %}
  service.running:
    - name: asterisk
    - enable: True
{%- else %}
  cmd.run:
    - name: /usr/sbin/asterisk -F
    - runas: {{ asterisk.user }}
    - unless: pidof asterisk
{%- endif %}

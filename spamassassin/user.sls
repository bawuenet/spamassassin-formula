spamassassin_user:
  user.present:
    - name: sa-user
    - system: True
    - createhome: True
    - nologinit: True
    - fullname: 'Spamassassin User'
    - system: True
    - shell: /bin/bash

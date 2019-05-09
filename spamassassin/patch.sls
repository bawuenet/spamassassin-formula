---
spamassassin_utf8_domain_message:
  file.patch:
    - name: /usr/share/perl5/vendor_perl/Mail/SpamAssassin/DnsResolver.pm
    - source: salt://spamassassin/files/domain_utf8_debug.patch
#    - hash: sha1:e8a8fddb8abde5d3ff1058d80d6205f5d800d344

spamassassin_sa-update_sha1:
  file.patch:
    - name: /usr/bin/sa-update
    - source: salt://spamassassin/files/sa-update_sha1.patch
#    - hash: sha1:de0706b881cadcb8fb9868b28c08050d3dc365d7

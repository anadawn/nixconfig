{ pkgs, ... }: {

  home = {
    packages = [ pkgs.neomutt ];
    file.".config/neomutt/neomuttrc" = {
      text =
        ''set folder = "imaps://akrishna852@gmail.com@imap.gmail.com:993"
  set spoolfile = "+INBOX"
  set sort = threads 
  set sort_aux = reverse-last-date-received
  mailboxes =INBOX =[Gmail]/Sent\ Mail =[Gmail]/Drafts =[Gmail]/Spam =[Gmail]/Trash
  set smtp_pass="`pass passwords/neomutt`"
  set smtp_url='smtps://akrishna852@gmail.com@smtp.gmail.com'
  set imap_pass="`pass passwords/neomutt`"
  set sidebar_visible = yes
  set sidebar_short_path = yes
  set sidebar_width = 22
  set sidebar_format = '%D%?F? [%F]?%* %?N?%N/?%S'
  unset signature
  set pgp_use_gpg_agent = yes
  set crypt_use_gpgme = yes
  set delete = yes
  set editor = "$EDITOR"
'';
    };

  };

}

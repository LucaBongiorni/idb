# autocomplete
LIST = [
    'cert', 'screenshot', 'app', 'quit', 'exit', 'install'
].sort


CERT_CMDS = ['install', 'uninstall', 'reinstall', 'list']
INSTALL_CMDS = ['dumpdecrypted', 'killswitch','open']
APP_CMDS = ['list', 'download', 'decrypt', 'select', 'url_handlers', 'archive', 'get_plists', 'get_sqlite', 'get_cachedb','bundleid','name','info_plist', 'launch']

comp = proc { |s|
  l = Readline.line_buffer
  tokens = l.split(' ')

  # no base command entered yet
  if tokens.length <= 1 and not l.end_with? " "
    next LIST.grep( /^#{Regexp.escape(s)}/ )
  end

  # base command entered, auto complete parameters
  case tokens[0]

    when "cert"
      if tokens.length  == 1 or (tokens.length == 2 and not l.end_with? " ")
        next CERT_CMDS.grep( /^#{Regexp.escape(s)}/ )
      elsif tokens.length == 3 or (tokens.length == 2 and l.end_with? " ")
        next Dir[File.expand_path(s)+'*'] + Dir[File.expand_path(s)+'/*']
      end

    when "screenshot"
    when "install"
      if tokens.length  == 1 or (tokens.length == 2 and not l.end_with? " ")
        next INSTALL_CMDS.grep( /^#{Regexp.escape(s)}/ )
      end
    when "app"
      if tokens.length  == 1 or (tokens.length == 2 and not l.end_with? " ")
        next APP_CMDS.grep( /^#{Regexp.escape(s)}/ )
      end
  end



}

Readline.completion_append_character = ""
Readline.completion_proc = comp


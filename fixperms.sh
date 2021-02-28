#! /bin/bash
# 
# License: GNU General Public License v3.0
# Copyright https://github.com/PeachFlame/cPanel-fixperms
#
# See the Github page for full license and notes:
# https://github.com/diego-vieira/KeyHelp-fixperms
#

# Set verbose to null
verbose=""


#Print the help text
helptext () {
    tput bold
    tput setaf 2
    echo "Fix perms script help:"
    echo "Sets file/directory permissions to match suPHP and FastCGI schemes"
    echo "USAGE: fixperms [options] -a account_name"
    echo "-------"
    echo "Options:"
    echo "-h or --help: print this screen and exit"
    echo "-v: verbose output"
    echo "-all: run on all KeyHelp accounts"
    echo "--account or -a: specify a KeyHelp account"
    tput sgr0
    exit 0
}

# Main workhorse, fix perms per account passed to it
fixperms () {

  #Get account from what is passed to the function
  account=$1

  #Check account against KeyHelp users file
  if ! grep $account /etc/passwd
  then
    tput bold
    tput setaf 1
    echo "Invalid KeyHelp account"
    tput sgr0
    exit 0
  fi

  #Make sure account isn't blank
  if [ -z $account ]
  then
    tput bold
    tput setaf 1
    echo "Need an account name!"
    tput sgr0
    helptext
  #Else, start doing work
  else

    #Get the account's homedir
    HOMEDIR=$(egrep "^$account:" /etc/passwd | cut -d: -f6)

    tput bold
    tput setaf 3
    echo "------------------------"
    tput setaf 4
    echo "Fixing website files ${HOMEDIR}www"
    tput sgr0
    
    #Fix individual files in www
    find ${HOMEDIR}www -type d -exec chmod $verbose 755 {} \;
    find ${HOMEDIR}www -type f | xargs -d$'\n' -r chmod $verbose 644
    find ${HOMEDIR}www -name '*.cgi' -o -name '*.pl' | xargs -r chmod $verbose 755
    # Hidden files support: https://serverfault.com/a/156481
    # fix hidden files and folders like .well-known/ with root or other user perms
    chown $verbose -R $account:$account ${HOMEDIR}www/.*
    chown $verbose -R $account:$account ${HOMEDIR}www/*/.*
    find ${HOMEDIR}/* -name .htaccess -exec chown $verbose $account.$account {} \;

    tput bold
    tput setaf 4
    echo "Fixing www...."
    tput sgr0
    #Fix perms of www itself
    chown $verbose $account:www-data ${HOMEDIR}www
    chmod $verbose 750 ${HOMEDIR}www

    #Finished
    tput bold
    tput setaf 3
    echo "Finished!"
    echo "------------------------"
    printf "\n\n"
    tput sgr0
  fi

  return 0
}

#Parses all users through KeyHelp's users file
all () {
    for user in $(egrep "^${account}:" /etc/passwd | cut -d: -f6)
    do
  fixperms $user
    done
}

#Main function, switches options passed to it
case "$1" in

    -h) helptext
  ;;
    --help) helptext
      ;;
    -v) verbose="-v"

  case "$2" in

    -all) all
           ;;
    --account) fixperms "$3"
         ;;
    -a) fixperms "$3"
        ;;
    *) tput bold
           tput setaf 1
       echo "Invalid Option!"
       helptext
       ;;
  esac
  ;;

    -all) all
    ;;
    --account) fixperms "$2"
          ;;
    -a) fixperms "$2"
  ;;
    *)
       tput bold
       tput setaf 1
       echo "Invalid Option!"
       helptext
       ;;
esac

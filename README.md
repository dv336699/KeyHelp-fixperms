# Attention

Use at your own risk. I'm not responsible for any damage this may cause to your files. Make sure to have a backup.

# KeyHelp-fixperms
A based on [cPanel-fixperms](https://github.com/PeachFlame/cPanel-fixperms) script to fix permissions and ownership, on files and directories, for KeyHelp accounts.

## More Info
Ever needed just to quickly 'fix' the permissions or ownership for your files in a regular KeyHelp account? This is the script for you. There is a staggering number of people using KeyHelp out there, and this script will help every KeyHelp user quickly recover from self-made permission mistakes or allow you to be lazy when setting permissions when uploading new scripts (ex: Wordpress).

## Instructions

### Fixperms - for one single user

To get the `fixperms` script, simply wget the file from GitHub and make sure it's executable:

```bash
curl -Ssl https://raw.githubusercontent.com/diego-vieira/KeyHelp-fixperms/master/fixperms.sh > fixperms.sh
chmod +x fixperms.sh
```

Then, run it (with ROOT permissions) while using the 'a' flag to specify a particular KeyHelp user:
```bash
sudo sh ./fixperms.sh -a USER-NAME
```
It does not matter which directory you are in when you run fixperms. You can be in the user’s home directory, the server root, etc... The script will not affect anything outside of the particular user’s home folder.

### Fixperms - for all of the users
If you would like fix the permissions for every user on your KeyHelp server, simply use the '-all' option:

```bash
sudo sh ./fixperms.sh -all
```

### Verbosity of Fixperms
By default, the script runs in a 'quiet' mode with minimal display. However, if you’re like me, you may want to see everything that is happening. You can turn on verbosity and have the script print to the screen everything that is being changed. I find this extremely useful when fixing large accounts that have many files. You can watch the changes as a sort of 'progress bar' of completion. The '-v' option can be used per account or with all accounts.

#### For one single account ####
```bash
sudo sh ./fixperms.sh -v -a USER-NAME
```

#### For all accounts ####
```bash
sudo sh ./fixperms.sh -v -all
```

### Getting Help
You can run `fixperms` with the '-h' or '--help' flags in order to see a help menu.

You can also open an issue here on GitHub if you see any problems.

### Adding Fixperms to your bin
I host numerous websites for friends and family, who will routinely make mistakes in regards to file permissions. It's understandable; they're not tech people. I will need to fix their permissions for them pretty frequently on my servers so I opted to put the `fixperms` script in all my servers' bin folders.

```bash
sudo mv fixperms.sh /usr/bin/fixperms
```

## History

All credits for the original cPanel script goes to 

https://github.com/PeachFlame/cPanel-fixperms

Now that `fixperms` is in Github, all contributors will have proper credit. However, before the move to Github, there were a 2 inidividuals that were crucial to the scripts existence:

- Dean Freeman
- Colin R.


## Contributing

If you would like to contribute, simply create a new feature branch, named for the fix, and submit a merge request.
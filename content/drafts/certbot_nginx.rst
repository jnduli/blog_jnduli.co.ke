#############
Certbot Nginx
#############

:date: 2019-03-04


Certbot is really awesome. To install it and have it working this
is all I had to do:


$ sudo apt-get update
$ sudo apt-get install software-properties-common
$ sudo add-apt-repository ppa:certbot/certbot
$ sudo apt-get update
$ sudo apt-get install python-certbot-nginx 

$ sudo certbot --nginx

source :
https://certbot.eff.org/all-instructions/#ubuntu-16-04-xenial-nginx

ToDO:

fix autorenewal
set up a means on certbox editting config files after config files
update

Once installed, and you change the config files, to reenable use
of this certificate just do:

sudo certbot --nginx

Chosse all the domains and when presented with o

rookie@rookie:~$ sudo certbot --nginx                                                                                                                                                         
rookie@rookie:~$ sudo certbot --nginx                                                                                                                                                         
Saving debug log to /var/log/letsencrypt/letsencrypt.log                                                                                                                                      
Starting new HTTPS connection (1): acme-v01.api.letsencrypt.org                                                                                                                               
                                                                                                                                                                                              
Which names would you like to activate HTTPS for?                                                                                                                                             
-------------------------------------------------------------------------------                                                                                                               
1: jnduli.co.ke                                                                                                                                                                               
2: comics.jnduli.co.ke                                                                                                                                                                        
3: www.comics.jnduli.co.ke                                                                                                                                                                    
4: projects.jnduli.co.ke                                                                                                                                                                      
5: www.jnduli.co.ke                                                                                                                                                                           
-------------------------------------------------------------------------------                                                                                                               
Select the appropriate numbers separated by commas and/or spaces, or leave input                                                                                                              
blank to select all options shown (Enter 'c' to cancel):                                                                                                                                      
Cert not yet due for renewal                                                                                                                                                                  
                                                                                                                                                                                              
You have an existing certificate that has exactly the same domains or certificate name you requested and isn't close to expiry.                                                               
(ref: /etc/letsencrypt/renewal/jnduli.co.ke.conf)                                                                                                                                             
                                                                                                                                                                                              
What would you like to do?                                                                                                                                                                    
-------------------------------------------------------------------------------                                                                                                               
1: Attempt to reinstall this existing certificate                                                                                                                                             
2: Renew & replace the cert (limit ~5 per 7 days)                                                                                                                                             
-------------------------------------------------------------------------------                                                                                                               
Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 1                                                                                                                     
Keeping the existing certificate                                                                                                                                                              
Deployed Certificate to VirtualHost /etc/nginx/sites-enabled/default for set(['jnduli.co.ke', 'www.jnduli.co.ke'])                                                                            
Deployed Certificate to VirtualHost /etc/nginx/sites-enabled/comic_server for set(['comics.jnduli.co.ke', 'www.comics.jnduli.co.ke'])                                                         
Deployed Certificate to VirtualHost /etc/nginx/sites-enabled/comic_server for set(['comics.jnduli.co.ke', 'www.comics.jnduli.co.ke'])                                                         
Deployed Certificate to VirtualHost /etc/nginx/sites-enabled/writing_search_system for set(['projects.jnduli.co.ke'])                                                                         
Deployed Certificate to VirtualHost /etc/nginx/sites-enabled/default for set(['jnduli.co.ke', 'www.jnduli.co.ke'])                                                                            
nginx: [warn] conflicting server name "" on 0.0.0.0:443, ignored                                                                                                                              
nginx: [warn] conflicting server name "" on [::]:443, ignored                                             
Saving debug log to /var/log/letsencrypt/letsencrypt.log                                                                                                                                      
Starting new HTTPS connection (1): acme-v01.api.letsencrypt.org                                                                                                                               
                                                                                                                                                                                              
Which names would you like to activate HTTPS for?                                                                                                                                             
-------------------------------------------------------------------------------                                                                                                               
1: jnduli.co.ke                                                                                                                                                                               
2: comics.jnduli.co.ke                                                                                                                                                                        
3: www.comics.jnduli.co.ke                                                                                                                                                                    
4: projects.jnduli.co.ke                                                                                                                                                                      
5: www.jnduli.co.ke                                                                                                                                                                           
-------------------------------------------------------------------------------                                                                                                               
Select the appropriate numbers separated by commas and/or spaces, or leave input                                                                                                              
blank to select all options shown (Enter 'c' to cancel):                                                                                                                                      
Cert not yet due for renewal                                                                                                                                                                  
                                                                                                                                                                                              
You have an existing certificate that has exactly the same domains or certificate name you requested and isn't close to expiry.                                                               
(ref: /etc/letsencrypt/renewal/jnduli.co.ke.conf)                                                                                                                                             
                                                                                                                                                                                              
What would you like to do?                                                                                                                                                                    
-------------------------------------------------------------------------------                                                                                                               
1: Attempt to reinstall this existing certificate                                                                                                                                             
2: Renew & replace the cert (limit ~5 per 7 days)                                                                                                                                             
-------------------------------------------------------------------------------                                                                                                               
Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 1                                                                                                                     
Keeping the existing certificate                                                                                                                                                              
Deployed Certificate to VirtualHost /etc/nginx/sites-enabled/default for set(['jnduli.co.ke', 'www.jnduli.co.ke'])                                                                            
Deployed Certificate to VirtualHost /etc/nginx/sites-enabled/comic_server for set(['comics.jnduli.co.ke', 'www.comics.jnduli.co.ke'])                                                         
Deployed Certificate to VirtualHost /etc/nginx/sites-enabled/comic_server for set(['comics.jnduli.co.ke', 'www.comics.jnduli.co.ke'])                                                         
Deployed Certificate to VirtualHost /etc/nginx/sites-enabled/writing_search_system for set(['projects.jnduli.co.ke'])                                                                         
Deployed Certificate to VirtualHost /etc/nginx/sites-enabled/default for set(['jnduli.co.ke', 'www.jnduli.co.ke'])                                                                            
nginx: [warn] conflicting server name "" on 0.0.0.0:443, ignored                                                                                                                              
nginx: [warn] conflicting server name "" on [::]:443, ignored                                                                                                                                 
                                                                                                                                                                                              
Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.                                                                                                         
-------------------------------------------------------------------------------------       

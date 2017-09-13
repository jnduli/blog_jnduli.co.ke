
vim ~/.ssh/config

Host esample.com
    ForwardAgent yes

Then do this on computer:

ssh-add ~/.ssh/key

If it states aent not found:
do :
eval $(ssh-agent)

Then addthe kye.

Sshing into server now iwll work as expected

Resources:
https://developer.github.com/v3/guides/using-ssh-agent-forwarding/

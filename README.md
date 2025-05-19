# wireshark
Wireshark - Network sniffing. Multiple scénarios


for a more secure usage of wireshark, without the need to use sudo or root do th efollowing steps.

sudo usermod -aG wireshark "$USER" - Adds you to the wireshark group ( rebbot your machine or restart your network)


sudo dpkg-reconfigure wireshark-common - This sets the correct permissions for the capture binary.


following this 2 steps you should be able to use wireshark and tshark without the use of sudo or root..

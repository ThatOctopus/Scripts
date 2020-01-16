#!/bin/bash
#
clear
echo -e "\e[31m####################################################"
echo -e "\e[31m####################################################"
echo -e "\e[31m##                                                ##"
echo -e "\e[31m##\e[0m                    \e[33mFTP TOOL\e[0m                   \e[31m ##"
echo -e "\e[31m##                                                ##"
echo -e "\e[31m####################################################"
echo -e "\e[31m##\e[0m                     \e[33mBy Cam\e[0m                    \e[31m ##"
echo -e "\e[31m####################################################"
echo -e "\e[31m##\e[0m                   \e[33m Ver: 1.1  \e[0m                 \e[31m ##"
echo -e "\e[31m####################################################"
echo -e "\e[31m####################################################"
echo ""
while true
do
        echo -e "\e[96mPlease select from below on which you want to do: "
        echo "(1) Add FTP User"
        echo "(2) Change User Password"
        echo "(3) Disable FTP User"
        echo "(4) Delete FTP User"
        echo "(5) Exit"
        read -p 'Please enter your choice : ' choice

        if [ $choice == "1" ]; then
                echo -e "\e[95mEntering FTP User creation"
                read -p 'Please enter the username : '  username
                read -p 'Please enter the password : '  pass
                shift 2
                fname="$*"
                useradd -m -s /bin/bash -c "$fname" "$username"
                echo "$username:$pass" | chpasswd
                usermod -G sftp_users $username
                rm -f /home/$username/.bashrc
                mkdir /sftpusers/chroot/$username
                mkdir /sftpusers/chroot/$username/data
                chown $user:sftp_users /sftpusers/chroot/$username/data
                cp /var/"Please put data inside the data folder" /sftpusers/chroot/$username/
                str1="Match User "
                str1+=$username
                str2=" ChrootDirectory /sftpusers/chroot/"
                str2+=$username
                echo ""
                echo $str1 >> /etc/ssh/sshd_config
                echo ' X11Forwarding no'  >> /etc/ssh/sshd_config
                echo ' AllowTcpForwarding no' >> /etc/ssh/sshd_config
                echo $str2 >> /etc/ssh/sshd_config
                service sshd restart
                echo ""
                echo ""
                echo ""
                echo "Please send the below to the customer"
                echo ""
                echo -e "\e[92mTitania SFTP server Details"
                echo "Host:             sftp://xfer.titania.com"
                echo "Username: $username"
                echo "Password: $pass"
                echo "Port:             22"
                echo -e "Please be sure to go into the data folder\e[96m"
                echo ""
                echo ""
        fi
        if [ $choice == "2" ]; then
                echo -e "\e[34mEntering password change"
                read -p 'Please enter the username you wish to change the password: '  user
                read -p 'Please enter the new password: '  pass
                echo "$username:$pass" | chpasswd
        fi
        if [ $choice == "3" ]; then
                read -p 'Please enter the username you wish to disable: '  user
                echo "$user:password" | chpasswd
        fi
        if [ $choice == "4" ]; then
                read -p 'Please enter the username you wish to delete: '  user
                echo "Please be aware, This will permanently remove all data"
                read -p 'Are You sure you want to delete this user? (y/n)'  choice1
                        if [ $choice1 == "y" ]; then
                                userdel -r $user
                                rm -rf /sftpusers/chroot/$user
                                rstr=$(grep -n $user /etc/ssh/sshd_config)
                                IFS=':'
                                read -ra ADDR <<< "$rstr" # str is read into an array as tokens separated by IFS
                                for i in "${ADDR[@]}"; do # access each element of array
                                sed -i "${i}d" /etc/ssh/sshd_config
                                sed -i "${i}d" /etc/ssh/sshd_config
                                sed -i "${i}d" /etc/ssh/sshd_config
                                sed -i "${i}d" /etc/ssh/sshd_config
                                break
                                done
                        fi
                        if [ $choice1 != "y" ]; then
                                echo "Canceling..."
                        fi
                fi
        if [ $choice == "5" ]; then
                exit 1
        fi

done

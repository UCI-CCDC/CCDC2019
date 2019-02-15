# change newPassword to the new password, leaving out userName will change all users
dsquery user –name userName | dsmod user –pwd newPassword

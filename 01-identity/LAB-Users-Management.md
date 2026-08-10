
# Creation of users in Microsoft Entra ID: 

## 01-First we created 10 users:

### Trough CLI: 
**To create a users:**

```bash
az ad user create \
  --display-name "AZ104 User 01" \
  --password "Master09" \
  --user-principal-name "az104user01@kmeron01hotmail.onmicrosoft.com"
```


**To create Multiple users:**

```bash
for i in {01..10}; do
    az ad user create \
        --display-name "AZ104 User $i" \
        --password "Master09" \
        --user-principal-name "az104user$i@kmeron01hotmail.onmicrosoft.com"
done
```

**To query the users creation:**

``` bash
az ad user list \
  --query "[?starts_with(userPrincipalName, 'az104user')].{Name:displayName,UPN:userPrincipalName}" \
  -o table
```

**Result:**

![Users_Image](./LABS_IDENDITY/Images/010300.png)

### Trough Portal: 

- Microsoft Entra ID > Manage (Section) > Users (It Opens new Users Section) > All Users > New user

**Result:**

![Users_Image_Portal](./LABS_IDENDITY/Images/010301.png)

# Users Management: 

### Using the Bulk option "Download Users" we export in Bulk the details of the users:

- It will generate a file we can later use to modify our existing users.

![Export_Bulk](./LABS_IDENDITY/Images/010402.png)

- It will be visible under Bulk Operations section: 

![Export_Bulk](./LABS_IDENDITY/Images/010403.png)


### Then downloaded the Invite template to add more users:

![Export_Bulk](./LABS_IDENDITY/Images/010404.png)

### Added new users via CSV file: 

![Export_Bulk](./LABS_IDENDITY/Images/010405.png)
![Export_Bulk](./LABS_IDENDITY/Images/010406.png)

- **Note:** Users will get an invitation so they need to accep it to be added in the Microsoft Entra ID.  

### Finally Just removed all new users using the template:
- Note the difference in the amount of users found. 

![Export_Bulk](./LABS_IDENDITY/Images/0104x.png)
![Export_Bulk](./LABS_IDENDITY/Images/010408.png)




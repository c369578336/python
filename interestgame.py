def addToInventory(inv,loot):
    for i in loot:
        try:
            inv[i]=inv[i]+1
        except:
            inv[i]=1
    return inv


def displayInventory(inv):
    print("Inventory:")
    s=0
    for i in inv:
        print(inv[i],i,sep=' ')
        s=s+inv[i]
    if s:
        print('Total number of items:',s,sep='')
    else:
        print('You have None now!Work hard!')
    print("")

inv ={}
displayInventory(inv)
inv = {'gold coin': 42, 'rope': 1}
dragonLoot = ['gold coin', 'dagger', 'gold coin', 'gold coin', 'ruby']
inv = addToInventory(inv, dragonLoot)
displayInventory(inv)
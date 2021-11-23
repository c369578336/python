class dog():
    def __init__(self,name,age) -> None:
        self.name=name
        self.age=age
        self.state='stand'
    
    def sit(self):
        print('%s is sitting!'%(self.name))
        self.state='sit'

dogge=dog('fuck',2)
print(dogge.name)
print(dogge.state)
dogge.sit()
print(dogge.state)

#it seems a little different?
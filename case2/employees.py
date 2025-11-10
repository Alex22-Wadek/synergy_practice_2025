class Employee:
    def __init__(self, name, base_salary):
        self.name = name
        self.base_salary = base_salary

    def calculate_salary(self):
        return self.base_salary


class Developer(Employee):
    def __init__(self, name, base_salary, bugs_fixed):
        super().__init__(name, base_salary)
        self.bugs_fixed = max(0, bugs_fixed)  

    def calculate_salary(self):
        return self.base_salary + self.bugs_fixed * 20  


class Manager(Employee):
    def __init__(self, name, base_salary, team_efficiency):
        super().__init__(name, base_salary)
        
        self.team_efficiency = min(1.0, max(0.0, team_efficiency))

    def calculate_salary(self):
        
        return self.base_salary + self.base_salary * 0.3 * self.team_efficiency


staff = [
    Developer("Александра", 1500, 30),
    Manager("Сергей", 2000, 0.8)
]

for person in staff:
    print(person.name, person.calculate_salary())

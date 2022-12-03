class Person
    attr_accessor :name, :age

    def initialize(name, age)
        @name = name
        @age = age
    end

    def getName
        self.name
    end

    def getAge
        self.age
    end

    def setName(newName)
        self.name = newName
    end

    def setAge(newAge)
        self.age = newAge
    end

    def printInfo
        puts "
        Person name: #{self.getName}
                age: #{self.getAge}
        "
    end
end

class Student < Person
    attr_accessor :studentId

    def initialize(name, age, studentId)
        @name = name
        @age = age
        @studentId = studentId
    end

    def getStudentId
        self.studentId
    end

    def setStudentId(newId)
        self.studentId = newId
    end

    def printInfo
        puts "
        Student name: #{self.getName}
                 age: #{self.getAge}
                  ID: #{self.studentId}
        "
    end
end

johnson = Person.new("Xiaoke Wang", 24)
johnson.printInfo
charlie = Student.new("Charlie", 24, "50xxxx")
charlie.printInfo
charlie.setName("Xingjian Xuanyuan")
charlie.setAge(25)
charlie.setStudentId("502375")
charlie.printInfo
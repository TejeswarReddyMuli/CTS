class Person
{
    public string Name;
}

class Program
{
    static void ChangeValue(int x)
    {
        x = 100;
    }

    static void ChangeReference(Person p)
    {
        p.Name = "John";
    }

    static void Main()
    {
        int num = 10;
        Person person = new Person { Name = "Alice" };

        Console.WriteLine($"Before: {num}");
        ChangeValue(num);
        Console.WriteLine($"After: {num}");

        Console.WriteLine($"Before: {person.Name}");
        ChangeReference(person);
        Console.WriteLine($"After: {person.Name}");
    }
}
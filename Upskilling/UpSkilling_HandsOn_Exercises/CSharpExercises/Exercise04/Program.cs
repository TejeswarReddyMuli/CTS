class Student
{
    public string Name { get; set; } = "";
}

class Program
{
    static void Main()
    {
        var number = 100;
        var text = "Hello";

        Student s = new()
        {
            Name = "Tom"
        };

        Console.WriteLine(number.GetType());
        Console.WriteLine(text.GetType());
        Console.WriteLine(s.GetType());

        Console.WriteLine($"{number} {text} {s.Name}");
    }
}
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        List<string> fruits = new()
        {
            "Apple",
            "Banana",
            "Mango"
        };

        fruits.Add("Orange");
        fruits.Remove("Banana");

        foreach (var item in fruits)
            Console.WriteLine(item);

        Dictionary<int, string> students = new();

        students.Add(1, "Tom");
        students.Add(2, "Jerry");

        foreach (var s in students)
            Console.WriteLine($"{s.Key} {s.Value}");
    }
}
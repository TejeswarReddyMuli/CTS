public record Employee
{
    public int Id { get; init; }
    public string Name { get; init; } = "";
}

class Program
{
    static void Main()
    {
        Employee e1 = new()
        {
            Id = 1,
            Name = "Alice"
        };

        Employee e2 = e1 with { Name = "Bob" };

        Console.WriteLine(e1);
        Console.WriteLine(e2);
    }
}
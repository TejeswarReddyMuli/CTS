class Program
{
    static (int, string) GetData()
    {
        return (101, "Alice");
    }

    static void Main()
    {
        var (id, name) = GetData();

        Console.WriteLine(id);
        Console.WriteLine(name);
    }
}
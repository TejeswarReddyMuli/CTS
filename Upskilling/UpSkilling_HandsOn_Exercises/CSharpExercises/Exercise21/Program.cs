class Program
{
    static void Check(object obj)
    {
        if (obj is int number)
            Console.WriteLine($"Integer: {number}");

        switch (obj)
        {
            case string s:
                Console.WriteLine($"String: {s}");
                break;

            case int n:
                Console.WriteLine($"Number: {n}");
                break;

            default:
                Console.WriteLine("Unknown");
                break;
        }
    }

    static void Main()
    {
        Check(10);
        Check("Hello");
    }
}
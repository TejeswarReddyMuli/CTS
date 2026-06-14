class Car
{
    public string Make;
    public string Model;
    public int Year;

    public Car()
    {
        Make = "Unknown";
        Model = "Unknown";
        Year = 0;
    }

    public Car(string make, string model, int year)
    {
        Make = make;
        Model = model;
        Year = year;
    }
}

class Program
{
    static void Main()
    {
        Car c1 = new Car();
        Car c2 = new Car("Toyota", "Camry", 2024);

        Console.WriteLine($"{c1.Make} {c1.Model} {c1.Year}");
        Console.WriteLine($"{c2.Make} {c2.Model} {c2.Year}");
    }
}
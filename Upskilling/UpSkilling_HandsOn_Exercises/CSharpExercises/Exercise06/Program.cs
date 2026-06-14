class Program
{
    static void Main()
    {
        int[] nums = { 10, 20, 30, 40, 50 };

        Console.WriteLine("For Loop");
        for (int i = 0; i < nums.Length; i++)
            Console.WriteLine(nums[i]);

        Console.WriteLine("Foreach Loop");
        foreach (int n in nums)
            Console.WriteLine(n);

        Console.WriteLine("While Loop");
        int j = 0;
        while (j < nums.Length)
        {
            Console.WriteLine(nums[j]);
            j++;
        }

        Console.WriteLine("Do While Loop");
        int k = 0;
        do
        {
            Console.WriteLine(nums[k]);
            k++;
        } while (k < nums.Length);
    }
}
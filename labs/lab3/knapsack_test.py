from knapsack import knapsack, print_subset
import random
import time
import matplotlib.pyplot as plt
import numpy


def create_list(s):
    result = []
    for i in range(s):
        result.append(random.randint(0, 25))
    return result


random.seed()
sizes = [10, 20, 30, 40, 50, 100, 200, 300, 400, 500, 1000, 2000, 3000, 4000, 5000,
         10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000, 100000]
y = []
for size in sizes:
    arr = create_list(size)
    target = random.randint(100, 130)
    start = time.time()
    subset = knapsack(arr, target)
    end = time.time()
    # print_subset(subset, arr, target, size - 1, [])
    print("Size:", size, "Execution time:", end-start)
    y.append(end-start)

plt.figure()
scatter = plt.scatter(sizes, y, color='red', s=50, alpha=0.5)
plot ,= plt.plot(sizes, y, color="blue", linewidth=2.0, label="running time")
plt.legend(handles=[scatter, plot], labels=["scatter", "line chart"])
plt.title("Running time of Knapsack --- Dynamic programming")
plt.xlabel("Size of array")
plt.ylabel("Time cost (s)")
plt.show()

plt.figure()
p1 = numpy.polyfit(x=sizes, y=y, deg=1)
yvals = numpy.polyval(p1, sizes)
plt.scatter(sizes, y, color="red", alpha=0.5, label="scatter")
plt.plot(sizes, yvals, color="blue", linewidth=2.0, label="linear fit")
plt.legend()
plt.title("Linear fit of output")
plt.xlabel("Size of array")
plt.ylabel("Time cost (s)")
plt.show()
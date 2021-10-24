def knapsack(arr, target):
    arr_len = len(arr)
    subset = [[False for j in range(target + 1)] for i in range(arr_len + 1)]
    for i in range(arr_len + 1):
        subset[i][0] = True

    for i in range(1, arr_len + 1):
        for j in range(1, target + 1):
            if subset[i-1][j]:
                subset[i][j] = True
            else:
                if arr[i-1] > j:
                    subset[i][j] = False
                else:
                    subset[i][j] = subset[i-1][j-arr[i-1]]

    return subset


def print_subset(subset, arr, target, n, result):
    if target == 0:
        print(sorted(result))
        return
    if n == 0 and target != 0 and subset[1][target]:
        result.append(arr[0])
        print(sorted(result))
        return
    if subset[n][target]:
        print_subset(subset, arr, target, n-1, result.copy())

    if target >= arr[n] and subset[n][target - arr[n]]:
        result.append(arr[n])
        print_subset(subset, arr, target - arr[n], n-1, result)


if __name__ == '__main__':
    target = int(input())
    arr = []
    for i in input().split():
        arr.append(int(i))
    subset = knapsack(arr, target)
    print_subset(subset, arr, target, len(arr) - 1, [])

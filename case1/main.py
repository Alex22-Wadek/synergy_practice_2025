def sum_negatives_between_min_max(arr):
    if len(arr) < 2:
        return 0
    i_min = arr.index(min(arr))
    i_max = arr.index(max(arr))
    left = min(i_min, i_max) + 1
    right = max(i_min, i_max)
    s = 0
    for i in range(left, right):
        if arr[i] < 0:
            s += arr[i]
    return s

arr = [5, -3, 7, -1, 0, -8, 4, 9, -2]
print(sum_negatives_between_min_max(arr))

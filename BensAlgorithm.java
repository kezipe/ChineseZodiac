public static void main(String[] args) {
	long beginning = System.currentTimeMillis();
	long end = 0;
	int[] test = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
	ArrayList<int[]> list = getPairs(test);
	for (int[] array : list) {
		printArray(array);
	}
	end = System.currentTimeMillis();
	System.out.println("Total combinations:" + list.size() + ". It took" + (end - beginning) + "seconds. Including printing took" + (System.currentTimeMillis() - beginning) / 1000.0 + "seconds.");
}

private static void printArray(int[] array) {
	StringBuffer sb = new StringBuffer();
	for(int i = 0; i < array.length; i += 2){
		sb.append("{" + array[i] + "," + array[i + 1] + "} ,");
	}

	sb.delete(sb.length() - 2, sb.length());
	System.out.println( sb.toString());
}

private static ArrayList<int[]> getPairs(int[] array){
	ArrayList<int[]> list = new ArrayList<int[]>();
	ArrayList<int[]> tempList = new ArrayList<int[]>();
	int length = array.length;
	if(length % 2 != 0 || length < 2){
		return list;
	} else if (length == 2) {
		list.add(array);
		return list;
	}

	int[] baseArray = {array[0], array[1]};
	int[] permutatingArray = new int[array.length - 2];
	// set up the base and the permutating part (sent in for recursion)
	for(int i = 2; i < array.length; i++){
		permutatingArray[i - 2] = array[i];
	}

	int i = 0;
	int temp;
	do {
		tempList = getPairs(permutatingArray);
		for (int j = 0; j < tempList.size(); j++) {
			// combine the base array and permutated arrays
			list.add(mergeArray(baseArray, tempList.get(j)));
		}
		if(i < array.length - 2) {
			temp = baseArray[1];
			baseArray[1] = permutatingArray[i];
			permutatingArray[i] = temp;
		}
		i++;
	} while (i <= array.length - 2);
	return list;
}

private static int[] mergeArray(int[] a, int[] b){
	if(a.length == 0 && b.length == 0) {
		return new int[0];
	} else if (a.length == 0) {
		return b;
	} else if (b.length == 0) {
		return a;
	}
	int[] array = new int[a.length + b.length];
	for(int i = 0; i < a.length; i++){
		array[i] = a[i];
	}
	for(int i = 0; i < b.length; i++){
		array[a.length + i] = b[i];
	}
	return array;
}
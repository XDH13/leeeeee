import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.zip.CheckedInputStream;

class Solution {
    public boolean CheckPermutation(String s1, String s2) {
        if (s1.length() != s2.length())
            return false;
        char[] c1 = (s1 + s2).toCharArray();
        Arrays.sort(c1);
        for (int i = 0; i < c1.length; i = i + 2) {
            if (c1[i] != c1[i + 1]) {
                return false;
            }
        }
        return true;
    }

    public boolean lemonadeChange(int[] bills) {
        int sum = 0;
        int sum2 = 0;
        for (int i = 0; i < bills.length; i++) {
            switch (bills[i]) {
                case 5:
                    sum += 1;
                    break;
                case 10:
                    if (sum > 0) {
                        sum--;
                        sum2 += 1;
                    } else
                        return false;
                    break;
                case 20:
                    if (sum > 0) {
                        if (sum2 > 0) {
                            sum--;
                            sum2--;
                        } else if (sum >= 3) {
                            sum -= 3;
                        } else
                            return false;
                    } else
                        return false;
                    break;
            }
        }
        return true;
    }
   ///todo https://leetcode.cn/problems/swap-adjacent-in-lr-string/submissions/
   ///todo 没做出来
    public boolean canTransform(String start, String end) {
        if (start.length() != end.length())
            return false;
        char[] s = start.toCharArray();
        for (int i = 0; i < start.length(); i++) {
//            System.out.print("\n");
//            System.out.print("same");
//            System.out.print(s);
            if (s[i] == end.charAt(i)) {
                continue;
            }
            if (i == start.length() - 1) {
                return false;
            }
            if (s[i] == 'X' && s[i+1] == 'L') {
                s[i] = 'L';
                s[i + 1] = 'X';
//                System.out.print("\n");
//                System.out.print("X,nSame");
//                System.out.print(s);

            } else if (s[i] == 'R' && s[i+1] == 'X') {
                s[i + 1] = 'R';
                s[i] = 'X';
//             System.out.print("\n");
//                System.out.print("nX nSame");
//                System.out.print(s);

            } else
                return false;
        }
        String RES = String.copyValueOf(s);
//        System.out.print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
//        System.out.print(RES);
//        System.out.print("\n");
//        System.out.print("TTTTTTTTTTTTTTTTTTTTTT\n");
        if(RES.equals(end))
        return true;
        else return false;
    }
}

class Test {
    static int[] s = new int[10];

    public static void main(String[] args) {
        Solution s = new Solution();
       if (s.canTransform("LXXLXRLXXL",
               "XLLXRXLXLX")){
           System.out.print("YYYYYYYY");
       };
    }
}

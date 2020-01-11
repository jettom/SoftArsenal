        ListNode res1 = new ListNode(0);
        ListNode p1,p2,cur;
        p1 = l1;
        p2 = l2;
        cur = res1;
        int carry = 0;
        while(p1!=null || p2 !=null) {
            int val1 ,val2;
            if (p1!=null) val1 = p1.val; else val1 = 0;
            if (p2!=null) val2 = p2.val; else val2 = 0;
            int val = carry+val1+val2;
            carry = val / 10;
            ListNode node = new ListNode(val % 10);
            cur.next = node;
            cur = cur.next;
            if(p1 != null) p1= p1.next;
            if(p2 != null) p2 = p2.next;
        }
        if(carry > 0){
            ListNode nodeLast = new ListNode(carry);
            cur.next = nodeLast;
        }
        return res1.next;

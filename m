From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: FYI, another paper checking URCU correctness
Date: Mon, 13 Jun 2016 06:10:29 -0700
Message-ID: <20160613131029.GA25918__9440.68500907651$1465823524$gmane$org@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 5FCFDA36DD
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2016 13:10:33 +0000 (UTC)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5DD8wgX118588
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2016 09:10:31 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gdxt03c0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2016 09:10:31 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 13 Jun 2016 07:10:30 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 29CC019D803F
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2016 07:10:07 -0600 (MDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5DDARsP40173606
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2016 13:10:27 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5DDAQbf018527
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2016 09:10:26 -0400
Content-Disposition: inline
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, rp@svcs.cs.pdx.edu, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGVsbG8hCgpPbiB0aGUgb2ZmIGNoYW5jZSB0aGF0IHRoaXMgaXMgbmV3IG5ld3Mgb2YgaW50ZXJl
c3QuLi4KCmh0dHBzOi8vYXJ4aXYub3JnL3BkZi8xNjA2LjAxNDAwdjEucGRmCgoiT3BlcmF0aW9u
YWwgQXNwZWN0cyBvZiBDL0MrKyBDb25jdXJyZW5jeSIsIEFudG9uIFBvZGtvcGFldiwgSWx5YSBT
ZXJnZXksCkFsZWtzYW5kYXIgTmFuZXZza2kuCgpBdCBmaXJzdCBnbGFuY2UsIHRoZXkgc2VlbSB0
byBiZSB1c2luZyBhIGNvbWJpbmF0aW9uIG9mIGZvcm1hbAp2ZXJpZmljYXRpb24gYW5kIHRlc3Rp
bmcsIHVzaW5nIGEgc2ltcGxlIGxpbmtlZC1saXN0IHVzYWdlIG9mIFVSQ1UuClRoZSBzdGF0ZSBz
cGFjZSB3YXMgdG9vIGxhcmdlIGZvciB0aGVpciBmb3JtYWwgdGVjaG5pcXVlLCBzbyB0aGV5IGFk
ZGVkCmEgcmFuZG9tIHN0YXRlLXNwYWNlIHNhbXBsaW5nIGFwcHJvYWNoLCBzb3J0IG9mIGxpa2Ug
d2hhdCBQcm9tZWxhL3NwaW4KZG9lcyBmb3IgbGFyZ2UgcHJvYmxlbXMuICBUaGV5IGRpZCBwcm9t
b3RlIHJjdV9kZXJlZmVyZW5jZSgpIHRvIGFuCmFjcXVpcmUgbG9hZCwgYnV0IGxpc3QgcmVhbCBy
Y3VfZGVyZWZlcmVuY2UoKSBhcyBmdXR1cmUgd29yay4KClRoZXkgZGlkbid0IGZpbmQgYW55IGJ1
Z3MsIGJ1dCB0aGVpciB0ZWNobmlxdWUgZGlkIGZpbmQgYW4gaW5qZWN0ZWQgYnVnCnRoYXQgcmVz
dWx0ZWQgaW4gdG9vLXNob3J0IGdyYWNlIHBlcmlvZHMuCgoJCQkJCQkJVGhhbngsIFBhdWwKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==

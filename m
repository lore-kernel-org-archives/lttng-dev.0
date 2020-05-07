From: =?utf-8?b?54aK5q+T5Y2OIHZpYSBsdHRuZy1kZXY=?= <lttng-dev@lists.lttng.org>
Subject: questions about mapping from file names to
 corresponding inode
Date: Thu, 7 May 2020 13:23:10 +0800 (GMT+08:00)
Message-ID: <1bb0377a.88648.171ed966cd8.Coremail.xiongyuhua@zju.edu.cn>
Reply-To: =?UTF-8?B?54aK5q+T5Y2O?= <xiongyuhua@zju.edu.cn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9179873678441694531=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from aliyun-sdnproxy-1.icoremail.net (aliyun-cloud.icoremail.net
 [47.90.88.95])
 by lists.lttng.org (Postfix) with SMTP id 49Hj6w6B1Bz1wbC
 for <lttng-dev@lists.lttng.org>; Thu,  7 May 2020 01:43:20 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "ychen@northwestern.edu" <ychen@northwestern.edu>, =?UTF-8?Q?list=E5=BE=90=E7=AB=8B=E6=81=92?= <245038403@qq.com>, Shopping Ruan <rlq1969612634@gmail.com>
List-Id: lttng-dev@lists.lttng.org

--===============9179873678441694531==
Content-Type: multipart/alternative;
	boundary="----=_Part_1800357_1539407283.1588828990680"

------=_Part_1800357_1539407283.1588828990680
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGnvvIwKCkkgd2FudCB0byBrbm93IHdoZXRoZXIgbHR0bmcgdHJhY2UgZGF0YSB3aWxsIHByb3Zp
ZGUgbWFwcGluZyBmcm9tIGZpbGUgbmFtZXMgdG8gY29ycmVzcG9uZGluZyBpbm9kZS4KCkkgcmVm
ZXJlZCBzb21lIGRhdGEgcGFyc2VkIGJ5IGJhYmVsdHJhY2XvvIxhbmQgZm91bmQgdGhhdCBpbnRl
cm5hbCBrZXJuZWwgdHJhY2Vwb2ludHMgbGlrZSB3cml0ZWJhY2tfZGlydHlfaW5vZGVfc3RhcnTj
gIFqYmQyX3N1Ym1pdF9pbm9kZV9kYXRhIGFuZCBsdHRuZ19zdGF0ZWR1bXBfdm1fbWFwIGNhbiBw
cm92aWRlIGlub2RlIHBhcmFtZXRlci5CdXQgSSBkb27igJl0IGtub3cgdGhlIG1lYW5pbmcgb2Yg
dGhlc2UgdHJhY2Vwb2ludHMgbWVudGlvbmVkIGFib3ZlLCBhbmQgaXQgc2VlbXMgdG8gaGF2ZSBs
aXR0bGUgdG8gZG8gd2l0aCB0aGUgbWFwcGluZyB3ZSBuZWVkLkkgd2FudCB0byBrbm93IHdoaWNo
IHRyYWNlcG9pbnQgd2lsbCByZWNvcmQgdGhlIG1hcHBpbmcuCgpJbiBhZGRpdGlvbiwgSSBmb3Vu
ZCB0aGUgZ2V0X2lub2RlX2Zyb21fZmQoKSBmdW5jdGlvbiBhdCBsdHRuZy11cHJvYmVzLmMuSXQg
c2VlbXMgdG8gcHJvdmlkZSBzb21lIGhpbnRzLCBjYW4gdGhpcyBmdW5jdGlvbiBwcm92aWRlIHRo
ZSBtYXBwaW5nIGluZm9ybWF0aW9uIHdlIHdhbnQ/SWYgc28sIGhvdyBzaG91bGQgSSB1c2UgaXQg
dG8gZ2V0IHRoZSBkYXRhLgoKCgpMb29raW5nIGZvcndhcmQgdG8geW91ciByZXBseS4KCgoKCnRo
YW5rcywKCnl1aHVhCgoKLS0tLS0tLS0tLS0tLS0tLS0tCll1aHVhIFhpb25nCkxhYiBmb3IgSW50
ZXJuZXQgYW5kIFNlY3VyaXR5IFRlY2hub2xvZ3kKU2Nob29sIG9mIENvbXB1dGVyIFNjaWVuY2Ug
YW5kIFRlY2hub2xvZ3kKWmhlamlhbmcgVW5pdmVyc2l0eQpIYW5nemhvdSwgMzEwMDA3LCBQLlIu
IENoaW5hCg==
------=_Part_1800357_1539407283.1588828990680
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

SGnvvIw8YnI+Cjxicj4KSSB3YW50IHRvIGtub3cgd2hldGhlciBsdHRuZyB0cmFjZSBkYXRhIHdp
bGwgcHJvdmlkZSBtYXBwaW5nIGZyb20gZmlsZSBuYW1lcyB0byBjb3JyZXNwb25kaW5nIGlub2Rl
Ljxicj4KPGJyPgpJIHJlZmVyZWQgc29tZSBkYXRhIHBhcnNlZCBieSBiYWJlbHRyYWNl77yMYW5k
IGZvdW5kIHRoYXQgaW50ZXJuYWwga2VybmVsIHRyYWNlcG9pbnRzIGxpa2Ugd3JpdGViYWNrX2Rp
cnR5X2lub2RlX3N0YXJ044CBamJkMl9zdWJtaXRfaW5vZGVfZGF0YSBhbmQgbHR0bmdfc3RhdGVk
dW1wX3ZtX21hcCBjYW4gcHJvdmlkZSBpbm9kZSBwYXJhbWV0ZXIuQnV0IEkgZG9u4oCZdCBrbm93
IHRoZSBtZWFuaW5nIG9mIHRoZXNlIHRyYWNlcG9pbnRzIG1lbnRpb25lZCBhYm92ZSwgYW5kIGl0
IHNlZW1zIHRvIGhhdmUgbGl0dGxlIHRvIGRvIHdpdGggdGhlIG1hcHBpbmcgd2UgbmVlZC5JIHdh
bnQgdG8ga25vdyB3aGljaCB0cmFjZXBvaW50IHdpbGwgcmVjb3JkIHRoZSBtYXBwaW5nLjxicj4K
PGJyPgpJbiBhZGRpdGlvbiwgSSBmb3VuZCB0aGUgZ2V0X2lub2RlX2Zyb21fZmQoKSBmdW5jdGlv
biBhdCA8YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vbHR0bmcvbHR0bmctbW9kdWxlcy9ibG9i
L21hc3Rlci9zcmMvcHJvYmVzL2x0dG5nLXVwcm9iZXMuYyIgdGFyZ2V0PSJfYmxhbmsiPmx0dG5n
LXVwcm9iZXMuYzwvYT4uSXQgc2VlbXMgdG8gcHJvdmlkZSBzb21lIGhpbnRzLCBjYW4gdGhpcyBm
dW5jdGlvbiBwcm92aWRlIHRoZSBtYXBwaW5nIGluZm9ybWF0aW9uIHdlIHdhbnQ/SWYgc28sIGhv
dyBzaG91bGQgSSB1c2UgaXQgdG8gZ2V0IHRoZSBkYXRhLjxicj4KPGJyPgo8cD4KCUxvb2tpbmcg
Zm9yd2FyZCB0byB5b3VyIHJlcGx5Lgo8L3A+CjxwPgoJPGJyPgo8L3A+CjxwPgoJdGhhbmtzLAo8
L3A+CjxwPgoJeXVodWEKPC9wPgo8cD4KCTwvcD48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRweDt3
aGl0ZS1zcGFjZTpub3JtYWw7Ij4KCQk8YnI+Ci0tLS0tLS0tLS0tLS0tLS0tLTxicj4KWXVodWEg
WGlvbmc8YnI+CkxhYiBmb3IgSW50ZXJuZXQgYW5kIFNlY3VyaXR5IFRlY2hub2xvZ3k8YnI+ClNj
aG9vbCBvZiBDb21wdXRlciBTY2llbmNlIGFuZCBUZWNobm9sb2d5PGJyPgpaaGVqaWFuZyBVbml2
ZXJzaXR5PGJyPgpIYW5nemhvdSwgMzEwMDA3LCBQLlIuIENoaW5hPGJyPgoJPC9kaXY+Cg==
------=_Part_1800357_1539407283.1588828990680--


--===============9179873678441694531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============9179873678441694531==--

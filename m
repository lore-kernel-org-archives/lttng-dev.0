From: "Staffan Tjernstrom" <staffan@eternaltraveller.com>
Subject: lttng view on --live session vs direct babeltrace use
	on UST
Date: Wed, 14 Sep 2016 15:49:21 -0500
Message-ID: <fb211c1a543766e28b2eb036aa20f0a2.squirrel__8387.01367979429$1473888032$gmane$org@email.powweb.com>
Reply-To: stjernstrom@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from walmailout05.yourhostingaccount.com
 (walmailout05.yourhostingaccount.com [65.254.253.40])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3D453A3ED7
 for <lttng-dev@lists.lttng.org>; Wed, 14 Sep 2016 21:20:51 +0000 (UTC)
Received: from mailscan04.yourhostingaccount.com ([10.1.15.4]
 helo=walmailscan04.yourhostingaccount.com)
 by walmailout05.yourhostingaccount.com with esmtp (Exim)
 id 1bkH7t-0000gw-KN
 for lttng-dev@lists.lttng.org; Wed, 14 Sep 2016 16:49:49 -0400
Received: from [10.114.3.32] (helo=walimpout12)
 by walmailscan04.yourhostingaccount.com with esmtp (Exim)
 id 1bkH7t-0002T9-B5
 for lttng-dev@lists.lttng.org; Wed, 14 Sep 2016 16:49:49 -0400
Received: from [127.0.0.1] (helo=email.powweb.com)
 by walwebmail19.yourhostingaccount.com with esmtp (Exim)
 id 1bkH7R-0000OE-Eu
 for lttng-dev@lists.lttng.org; Wed, 14 Sep 2016 16:49:21 -0400
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SSBjcmVhdGUgYSBzZXNzaW9uIHdpdGgKCmx0dG5nIGNyZWF0ZSAtLWxpdmUgMTAwMDAwCgphZGQg
bXkgZXZlbnRzCgpsdHRuZyBlbmFibGUtZXZlbnQgLXUgIm15X3Byb3ZpZGVyOioiCgpzdGFydCBp
dAoKbHR0bmcgc3RhcnQKCnRoZW4gdmlldyB0aGUgcmVzdWx0cy4KCmx0dG5nIHZpZXcKCndvcmtz
IGZpbmUsIGJ1dCBJIG5lZWQgdG8gZmluZS10dW5lIHRoZSBvdXRwdXQgZmllbGRzIChJIG5lZWQg
dGhlCmRhdGUsIGFuZCB1dGMgdGltZSwgaW4gcGFydGljdWxhcikuCgpsdHRuZyB2aWV3IC1lICIv
dXNyL2Jpbi9iYWJlbHRyYWNlIC0tY2xvY2stZGF0ZSAtLWNsb2NrLWdtdCIKCnByb2R1Y2VzIHRo
ZSBmb2xsb3dpbmcgZXJyb3I6CgpUcmFjZSBkaXJlY3Rvcnk6Cm5ldDovL2xvY2FsaG9zdC9ob3N0
L2U3Y2gxc2FwcGhpcmUwMS5mYWN0aW9uLmxvY2FsL2F1dG8tMjAxNjA5MTQtMTUwMDQwCgpbZXJy
b3JdIFVuYWJsZSB0byBvcGVuIHRyYWNlIGRpcmVjdG9yeQoibmV0Oi8vbG9jYWxob3N0L2hvc3Qv
ZTdjaDFzYXBwaGlyZTAxLmZhY3Rpb24ubG9jYWwvYXV0by0yMDE2MDkxNC0xNTAwNDAiLgpbd2Fy
bmluZ10gW0NvbnRleHRdIENhbm5vdCBvcGVuX3RyYWNlIG9mIGZvcm1hdCBjdGYgYXQgcGF0aApu
ZXQ6Ly9sb2NhbGhvc3QvaG9zdC9lN2NoMXNhcHBoaXJlMDEuZmFjdGlvbi5sb2NhbC9hdXRvLTIw
MTYwOTE0LTE1MDA0MC4KW3dhcm5pbmddIFtDb250ZXh0XSBjYW5ub3Qgb3BlbiB0cmFjZQoibmV0
Oi8vbG9jYWxob3N0L2hvc3QvZTdjaDFzYXBwaGlyZTAxLmZhY3Rpb24ubG9jYWwvYXV0by0yMDE2
MDkxNC0xNTAwNDAiCmZvciByZWFkaW5nLgpbd2FybmluZ10gZXJyb3JzIG9jY3VycmVkIHdoZW4g
b3BlbmluZyB0cmFjZQoibmV0Oi8vbG9jYWxob3N0L2hvc3QvZTdjaDFzYXBwaGlyZTAxLmZhY3Rp
b24ubG9jYWwvYXV0by0yMDE2MDkxNC0xNTAwNDAiCmZvciByZWFkaW5nLCBjb250aW51aW5nIGFu
eXdheS4KCldoZW4gSSBkb24ndCB1c2UgYSBsaXZlIHNlc3Npb24sIHRoZSBleHBsaWNpdCB2ZXJz
aW9uIG9mIGx0dG5nIHZpZXcKd29ya3MgYXMgb25lIHdvdWxkIGV4cGVjdC4KCkRvZXMgYW55b25l
IGhhdmUgYW55IGdvb2QgaWRlYXMgd2hlcmUgSSdtIGdvaW5nIHdyb25nPzoKCktpbmQgUmVnYXJk
cywKU3RhZmZhbiBUai4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
Cg==

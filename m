From: David Goulet <dgoulet@efficios.com>
Subject: [RFC] LTTng-tools Java Tracing network protocol
Date: Wed, 11 Sep 2013 13:23:58 -0400
Message-ID: <5230A72E.3040602__30749.8395596214$1378920302$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030706050406080500050504"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VJo9B-00026z-DQ
	for lttng-dev@lists.lttng.org; Wed, 11 Sep 2013 13:24:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 58E06A1D79
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 17:23:46 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id e9z1nFmzKj0n for <lttng-dev@lists.lttng.org>;
	Wed, 11 Sep 2013 17:23:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id AE6E6A1DA0
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 17:23:45 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id c2Yx7owXgH8d for <lttng-dev@lists.lttng.org>;
	Wed, 11 Sep 2013 17:23:45 +0000 (UTC)
Received: from 127.0.0.1 (cable-10.246.173-146.electronicbox.net
	[173.246.10.146])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 1689EA1D79
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 17:23:44 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------030706050406080500050504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi everyone,

Here is the network protocol RFC for the JUL support in lttng-tools. It covers
only the communication between the Java LTTng Agent and the session daemon.

A second RFC will follow this week for the new JUL domain ABI/API in lttng-tools.

NOTE: There is still a "black spot" in that protocol where the session daemon
would have to know, during an application registration, that it's Java to
associate the app. to the domain in tools. If we can't, the trick would be to
always have the Java socket open in the session daemon and once a connection is
done, there is an initial handshake with the PID and then the association if
done there.

Cheers!
David

--------------030706050406080500050504
Content-Type: text/plain;
 name="XXXX-jul-domain-protocol.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="XXXX-jul-domain-protocol.txt"

UkZDIC0gSmF2YSBKVUwgZG9tYWluIG5ldHdvcmsgcHJvdG9jb2wKCkF1dGhvcjogRGF2aWQg
R291bGV0IDxkZ291bGV0QGVmZmljaW9zLmNvbT4KClZlcnNpb246CgktIHYwLjE6IDExLzA5
LzIwMTMKCQkqIEluaXRpYWwgcHJvcG9zYWwKCkludHJvZHVjdGlvbgotLS0tLS0tLS0tCgpU
aGlzIHByb3Bvc2FsIGlzIHRvIGRldGFpbCBhcyBtdWNoIGFzIHBvc3NpYmxlIHRoZSBuZXR3
b3JrIHByb3RvY29sIGJldHdlZW4KSmF2YSBKVUwgWzFdIGNvbXBvbmVudCBhbmQgdGhlIHNl
c3Npb24gZGFlbW9uIGZvciB0aGUgVVNUIEphdmEgdHJhY2luZyBzdXBwb3J0LgoKQXJjaGl0
ZWN0dXJlCi0tLS0tLS0tLS0tLQoKVG8gYWNoaWV2ZSBKYXZhIHRyYWNpbmcgd2l0aCBVU1Qg
dXNpbmcgSlVMIFsxXSwgYSBMVFRuZyBhZ2VudCBpcyBuZWVkZWQgaW4gdGhlCkphdmEgYXBw
bGljYXRpb24gdG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgc2Vzc2lvbiBkYWVtb24uIEpVTCB3
b3JrcyB3aXRoIExvZ2dlcgpbMl0gb2JqZWN0IGluIHdoaWNoIGhhbmRsZXJzIGFyZSBhdHRh
Y2hlZC4gT25jZSB0aGUgYWdlbnQgaXMgYWN0aXZhdGVkLCBpdAphdHRhY2hzIGEgY3VzdG9t
IExUVG5nIGxvZyBoYW5kbGVyIHRvIGFsbCBleGlzdGluZyBsb2dnZXJzIHRvIHRyYWNlIGV2
ZW50cyB0aGF0CnBhc3NlcyB0aHJvdWdoIHRob3NlLgoKVGhlIHNlc3Npb24gZGFlbW9uIGNh
biBsaXN0IHRoZSBleGlzdGluZyBsb2dnZXJzIGJ5IGFza2luZyB0aGUgYWdlbnQgYW5kCmVu
YWJsZS9kaXNhYmxlIHRoZSBoYW5kbGVyIGluIHRob3NlIExvZ2dlciBvYmplY3QgYnkgcmVt
b3Zpbmcgb3IgYWRkaW5nIHRoZQpMVFRuZyBoYW5kbGVyIChhZGRIYW5kbGVyL3JlbW92ZUhh
bmRsZXIpLgoKQ29uc2lkZXJpbmcgdGhhdCwgdGhlIG5ldHdvcmsgcHJvdG9jb2wgZm9yIHRo
aXMgY29tbXVuaWNhdGlvbiBpcyBkZWZpbmVkIGluIHRoaXMKZG9jdW1lbnQuCgpQcm90b2Nv
bAotLS0tLS0tLQoKVGhpcyBwYXJ0IGlzIHNwbGl0IGluIHR3byBzZWN0aW9ucy4gRmlyc3Qg
b25lIGV4cGxhaW5zIGhvdyB0aGUgYWdlbnQgaW5pdGlhdGUgYQpjb25uZWN0aW9uIHRvIHRo
ZSBzZXNzaW9uIGRhZW1vbiBBRlRFUiB0aGUgcmVnaXN0cmF0aW9uIGlzIGRvbmUgYnkgdGhl
IFVTVAp0cmFjZXIuIFRoZSBzZWNvbmQgZGV0YWlscyB0aGUgcHJvdG9jb2wgc3BlY2lmaWNh
dGlvbi4KCjEuIEFnZW50IGNvbW11bmljYXRpb24KCkZpcnN0LCB0aGUgVVNUIHRyYWNlciBy
ZWdpc3RlcnMgdG8gdGhlIHNlc3Npb24gZGFlbW9uLiBUaGlzIGlzIGRvbmUgYnkKaW5pdGlh
bGl6aW5nIHRoZSBsaWJyYXJ5IHRocm91Z2ggYSBKTkkgWzNdIGNhbGwgaW4gdGhlIGFnZW50
LiBEdXJpbmcgdGhlCnJlZ2lzdHJhdGlvbiwgdGhlIHNlc3Npb24gZGFlbW9uIG5lZWRzIHRv
IGRldGVjdCB0aGF0IGl0J3MgYSBKYXZhIGFwcGxpY2F0aW9uCmFuZCBwcmVwYXJlIGEgVENQ
IHNvY2tldCBmb3IgYmlkaXJlY3Rpb25uYWwgY29tbXVuaWNhdGlvbiB3aXRoIHRoZSBhZ2Vu
dC4KCk9uY2UgZG9uZSwgdGhlIGFnZW50IGNyZWF0ZXMgYSBUQ1AgY29ubmVjdGlvbiB0byB0
aGUgc2Vzc2lvbiBkYWVtb24gb24gYQpzdGFuZGFyZCBwb3J0ICg1MzQ1KSBvbiBsb2NhbGhv
c3QgKDEyNy4wLjAuMSkuCgpVc2luZyB0aGF0IHNvY2tldCwgdGhlIHNlc3Npb24gZGFlbW9u
IGNhbiBzZW5kIGNvbW1hbmRzIGFuZCByZWNlaXZlIGFuc3dlcnMuClRoZSBjb21tYW5kcyBh
cmU6CgoJKiBMaXN0IGxvZ2dlcnMgYnkgbmFtZQoJKiBFbmFibGUgbG9nZ2VyIGJ5IG5hbWUK
CSogRGlzYWJsZSBsb2dnZXIgYnkgbmFtZQoKRWFjaCBvZiB0aG9zZSB1c2VzIHRoZSBmb3Jt
YXQgZGVmaW5lZCBpbiB0aGUgbmV4dCBzZWN0aW9uICgyKS4KCjIuIEZvcm1hdCBzcGVjaWZp
Y2F0aW9uCgooRGVmaW5pdGlvbiBhcmUgZXhwcmVzc2VkIGluIGEgQyBsaWtlIGZhc2hpb24p
CgpBIGNvbW1hbmQgaXMgZm9ybWVkIHdpdGggYSBoZWFkZXIgc2VjdGlvbiBhbmQgYSBwYXls
b2FkLiBUaGUgY29tbWFuZCBhbmQKcmVzcG9uc2UgdXNlIGRpZmZlcmVudCBmb3JtYXQgc2lu
Y2Ugb25seSB0aGUgc2Vzc2lvbiBkYWVtb24gY2FuIHNlbmQgY29tbWFuZCB0bwp0aGUgYWdl
bnQuCgpTZXNzaW9uIGRhZW1vbgoKKiBIZWFkZXIgc3RydWN0CgplbnVtIGNvbW1hbmQgewoJ
TElTVAkJPSAxLAoJRU5BQkxFCQk9IDIsCglESVNBQkxFCQk9IDMsCn0KCnN0cnVjdCB7Cgl1
aW50NjRfdCBkYXRhX3NpemUJLyogU2l6ZSBvZiB0aGUgcGF5bG9hZCBmb2xsb3dpbmcgdGhl
IGhlYWRlciAqLwoJdWludDY0X3QgY21kCQkvKiBDb21tYW5kIHZhbHVlIGZyb20gdGhlIGRl
ZmluZWQgZW51bSBhYm92ZS4gKi8KCXVpbnQ2NF90IHZlcnNpb24JLyogQ29tbWFuZCB2ZXJz
aW9uLiBVc2VkIGZvciBjb21wYXRpYmlsaXR5LiAqLwp9CgoqIFBheWxvYWQKCnN0cnVjdCBl
bmFibGVfbG9nZ2VyIHsKCWNoYXIgbmFtZVtNQVhfU0laRV0JLyogTmFtZSBvZiB0aGUgbG9n
Z2VyIHRvIGVuYWJsZS4gKi8KfQoKc3RydWN0IGRpc2FibGVfbG9nZ2VyIHsKCWNoYXIgbmFt
ZVtNQVhfU0laRV0JLyogTmFtZSBvZiB0aGUgbG9nZ2VyIHRvIGRpc2FibGUuICovCn0KCkph
dmEgQWdlbnQ6CgoqIFJlcGx5IHN0cnVjdCBmb3IgZWFjaCBjb21tYW5kCgpzdHJ1Y3QgbGlz
dF9sb2dnZXJfY21kIHsKCXVpbnQ2NF90IG5iOwkJLyogTnVtYmVyIG9mIGxvZ2dlci4gKi8K
CWNoYXIgbG9nZ2VyX25hbWVbXQkvKiBMb2dnZXIgbmFtZShzKS4gKHZhcmlhYmxlIHNpemUp
LiAqLwoJdWludDMyX3QgcmV0X2NvZGUJLyogRXJyb3IgY29kZS4gKi8KfQoKc3RydWN0IGdl
bmVyaWNfcmVwbHkgewoJdWludDMyX3QgcmV0X2NvZGUJLyogRXJyb3IgY29kZS4gKi8KfQoK
Rm9yIGVuYWJsZSBhbmQgZGlzYWJsZSBsb2dnZXIsIHRoZSBnZW5lcmljIHN0cnVjdHVyZSBp
cyB1c2VkLgoKUmVmZXJlbmNlcwotLS0tLS0tLS0tCgpbMV0gaHR0cDovL2RvY3Mub3JhY2xl
LmNvbS9qYXZhc2UvNy9kb2NzL2FwaS9qYXZhL3V0aWwvbG9nZ2luZy9wYWNrYWdlLXN1bW1h
cnkuaHRtbApbMl0gaHR0cDovL2RvY3Mub3JhY2xlLmNvbS9qYXZhc2UvNy9kb2NzL2FwaS9q
YXZhL3V0aWwvbG9nZ2luZy9Mb2dnZXIuaHRtbApbM10gaHR0cDovL2RvY3Mub3JhY2xlLmNv
bS9qYXZhc2UvNy9kb2NzL3RlY2hub3Rlcy9ndWlkZXMvam5pLwo=
--------------030706050406080500050504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------030706050406080500050504--

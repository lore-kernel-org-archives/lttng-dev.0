From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: New tracef() feature in LTTng-UST
Date: Fri, 14 Mar 2014 20:50:10 +0000 (UTC)
Message-ID: <138917049.3594.1394830210179.JavaMail.zimbra__5062.01453176818$1394830277$gmane$org@efficios.com>
References: <1387436488.3593.1394830119067.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WOZ3S-0001pr-GM
	for lttng-dev@lists.lttng.org; Fri, 14 Mar 2014 16:50:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id E4115340222
	for <lttng-dev@lists.lttng.org>; Fri, 14 Mar 2014 20:50:12 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 66szlhAQQXo5 for <lttng-dev@lists.lttng.org>;
	Fri, 14 Mar 2014 20:50:10 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 988D13402DC
	for <lttng-dev@lists.lttng.org>; Fri, 14 Mar 2014 20:50:10 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id GBqKDFssO4nn for <lttng-dev@lists.lttng.org>;
	Fri, 14 Mar 2014 20:50:10 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id 6C564340222
	for <lttng-dev@lists.lttng.org>; Fri, 14 Mar 2014 20:50:10 +0000 (UTC)
In-Reply-To: <1387436488.3593.1394830119067.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgZXZlcnlvbmUsCgpJIHB1c2hlZCBhIG5ldyBmZWF0dXJlcyBpbiBMVFRuZy1VU1QgdGhhdCBJ
J20gc3VyZSBldmVyeW9uZSB3aWxsIGxpa2UuCgpVU0FHRSBXSVRIIFRSQUNFRgoKICAgICAgIFRo
ZSBzaW1wbGVzdCB3YXkgdG8gYWRkIGluc3RydW1lbnRhdGlvbiB0byB5b3VyICBjb2RlICBpcyAg
YnkgIGZhciAgdGhlCiAgICAgICB0cmFjZWYoKSBBUEkuIFRvIHlvdSBpdCwgaW4gYSBudXRzaGVs
bDoKCiAgICAgICAxKSAjaW5jbHVkZSA8bHR0bmcvdHJhY2VmLmg+CgogICAgICAgMikgLyogaW4g
eW91ciBjb2RlLCB1c2UgbGlrZSBhIHByaW50ZiAqLwogICAgICAgICAgdHJhY2VmKCJteSBtZXNz
YWdlLCB0aGlzIGludGVnZXIgJWQiLCAxMjM0KTsKCiAgICAgICAzKSBMaW5rIHlvdXIgcHJvZ3Jh
bSBhZ2FpbnN0IGxpYmx0dG5nLXVzdC5zby4KCiAgICAgICA0KSBFbmFibGUgdGhlIFVTVCBldmVu
dCAibHR0bmdfdXN0X3RyYWNlZjpldmVudCIgd2hlbiB0cmFjaW5nIHdpdGggdGhlCiAgICAgICAg
ICBmb2xsb3dpbmcgc2VxdWVuY2Ugb2YgY29tbWFuZHMgZnJvbSBsdHRuZy10b29sczoKCiAgICAg
ICAgICBsdHRuZyAgY3JlYXRlOyBsdHRuZyBlbmFibGUtZXZlbnQgLXUgImx0dG5nX3VzdF90cmFj
ZWY6ZXZlbnQiOyBsdHRuZyBzdGFydAogICAgICAgICAgWy4uLiBydW4geW91ciBwcm9ncmFtIC4u
Ll0KICAgICAgICAgIGx0dG5nIHN0b3A7IGx0dG5nIHZpZXcKCiAgICAgICBUaGF0J3MgaXQhCgog
ICAgICAgSWYgeW91IHdhbnQgdG8gaGF2ZSBtb3JlIGZsZXhpYmlsaXR5IGFuZCBjb250cm9sIG9u
ICB0aGUgIGV2ZW50ICBuYW1lcywKICAgICAgIHBheWxvYWQgIHR5cGluZywgIGV0YywgIHlvdSAg
Y2FuIGNvbnRpbnVlIHJlYWRpbmcgb24gYW5kIHVzZSB0aGUgdHJhY2XigJAKICAgICAgIHBvaW50
cyBiZWxvdy4gInRyYWNlZigpIiBpcyB0aGVyZSBmb3IgcXVpY2sgYW5kIGRpcnR5IGFkIGhvYyBp
bnN0cnVtZW7igJAKICAgICAgIHRhdGlvbiwgd2hlcmVhcyB0cmFjZXBvaW50LmggaXMgbWVhbnQg
Zm9yIHRob3JvdWdoIGluc3RydW1lbnRhdGlvbiBvZiBhCiAgICAgICBjb2RlIGJhc2UgdG8gYmUg
aW50ZWdyYXRlZCB3aXRoIGFuIHVwc3RyZWFtIHByb2plY3QuCgpGZWVkYmFjayBpcyB3ZWxjb21l
IQoKVGhhbmtzLAoKTWF0aGlldQoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4K
aHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK

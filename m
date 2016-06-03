From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [lttng-ust PATCH v3 0/1] Identify UST threads by
	changing thread names
Date: Fri,  3 Jun 2016 12:45:01 -0400
Message-ID: <cover.1464971957.git.raphael.beamonte__9401.38225346363$1464972877$gmane$org@gmail.com>
References: <cover.1461269886.git.raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
 [209.85.192.54])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E50E0A37AE
 for <lttng-dev@lists.lttng.org>; Fri,  3 Jun 2016 16:45:19 +0000 (UTC)
Received: by mail-qg0-f54.google.com with SMTP id 93so14452349qgx.2
 for <lttng-dev@lists.lttng.org>; Fri, 03 Jun 2016 09:45:19 -0700 (PDT)
In-Reply-To: <cover.1461269886.git.raphael.beamonte@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
Cc: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
List-Id: lttng-dev@lists.lttng.org

SGksCgpUaGlzIGlzIHRoZSB1cGRhdGUgb2YgdGhlIFJGQyBwYXRjaCBmb2xsb3dpbmcgeW91ciBj
b21tZW50cy4KVGhpcyBwYXRjaCB1cGRhdGVzIHRoZSBwdGhyZWFkX3NldG5hbWVfbnAvcHRocmVh
ZF9zZXRfbmFtZV9ucCB2ZXJzaW9uIG9mCnRoZSBSRkMgcGF0Y2gsIGFuZCBpbmNsdWRlcyB0aGUg
Zm9sbG93aW5nIGNoYW5nZXM6Ci0gQWRkIGEgTFRUTkdfVVNUX1BST0NOQU1FX1NVRkZJWCBtYWNy
byBpbiBjb21wYXQuaCB0aGF0IGNvbnRhaW5zIHRoZQogIHN0cmluZyB0byBiZSBhZGRlZCBhdCB0
aGUgZW5kIG9mIHRoZSBwcm9jZXNzIG5hbWUKLSBGaXggdGhlIGxpbWl0IHZhbHVlICh3YXMgNCBp
bnN0ZWFkIG9mIDUsIG5vdyB1c2VzIGRpcmVjdGx5IHN0cmxlbiBvbgogIHRoZSBMVFROR19VU1Rf
UFJPQ05BTUVfU1VGRklYIG1hY3JvIHZhbHVlKQotIFJlbW92ZXMgdGhlIG1hY3JvIHVzZWQgdG8g
Y2FsbCB0aGUgbHR0bmdfdXN0X3NldHVzdHByb2NuYW1lIGZ1bmN0aW9uLAogIGFuIGVtcHR5IGx0
dG5nX3VzdF9zZXR1c3Rwcm9jbmFtZSBpcyBjYWxsZWQgaW5zdGVhZCB3aGVuIHRoZSBzZXQqbmFt
ZQogIHB0aHJlYWQgZnVuY3Rpb25zIGFyZSBub3QgYXZhaWxhYmxlCi0gUmVwbGFjZWQgJ2x0dG5n
X3VzdF9zZXR1c3Rwcm9jbmFtZSgpJyBwZXIgJ2x0dG5nX3VzdF9zZXR1c3Rwcm9jbmFtZSh2b2lk
KScKICBpbiB0aGUgZnVuY3Rpb24gZGVjbGFyYXRpb24uCgpUaGlzIHNob3VsZCBhZGRyZXNzIGFs
bCB0aGUgY29tbWVudHMgeW91IGhhZCEKQW55IG90aGVyIHRob3VnaHRzIG9yIGNvbW1lbnRzPwoK
VGhhbmtzIGEgbG90IQpSYXBoYcOrbAoKClJhcGhhw6tsIEJlYW1vbnRlICgxKToKICBBZGQgLXVz
dCB0byB0aGUgbmFtZSBvZiBVU1QgdGhyZWFkcyBvZiB0aGUgYXBwbGljYXRpb24KCiBjb25maWd1
cmUuYWMgICAgICAgICAgICAgICAgICB8ICA1ICsrKysrCiBsaWJsdHRuZy11c3QvTWFrZWZpbGUu
YW0gICAgICB8ICAxICsKIGxpYmx0dG5nLXVzdC9jb21wYXQuaCAgICAgICAgIHwgNTEgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogbGlibHR0bmctdXN0L2x0dG5n
LXVzdC1jb21tLmMgfCAgNiArKysrKwogNCBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgotLSAKMi44LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==

From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Port: don't quote wc output in
	test scripts
Date: Thu, 31 Aug 2017 16:54:06 -0400
Message-ID: <CA+jJMxtu48gh9nCZikVbPTSg-h1C6ZVJp9qSAsKzbkOTtKyFMA__37815.9081134529$1504212872$gmane$org@mail.gmail.com>
References: <1504117766-13198-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3xjvk83911zD4B
 for <lttng-dev@lists.lttng.org>; Thu, 31 Aug 2017 20:54:08 +0000 (UTC)
Received: by mail-qt0-x242.google.com with SMTP id e2so613366qta.3
 for <lttng-dev@lists.lttng.org>; Thu, 31 Aug 2017 13:54:08 -0700 (PDT)
In-Reply-To: <1504117766-13198-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIDMwIEF1Z3VzdCAyMDE3IGF0IDE0OjI5LCBN
aWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gVGhlICd3Yycg
Y29tbWFuZCBvbiBtYWNPUyBwcmVmaXhlcyB0aGUgY291bnQgaXQgcmV0dXJucyB3aXRoIHNwYWNl
cywgaWYKPiB3ZSBxdW90ZSB0aGUgb3V0cHV0IGl0IHdvbid0IGJlIHByb3Blcmx5IGNvbnZlcnRl
ZCB0byBpbnRlZ2VyIGZvciB0aGUKPiBjb21wYXJpc29uLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHRlc3RzL2NsaS9p
bnRlcnNlY3Rpb24vdGVzdF9pbnRlcnNlY3Rpb24uaW4gfCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0
cy9jbGkvaW50ZXJzZWN0aW9uL3Rlc3RfaW50ZXJzZWN0aW9uLmluIGIvdGVzdHMvY2xpL2ludGVy
c2VjdGlvbi90ZXN0X2ludGVyc2VjdGlvbi5pbgo+IGluZGV4IDA3YTI2N2YuLjdjZWE5YmUgMTAw
NjQ0Cj4gLS0tIGEvdGVzdHMvY2xpL2ludGVyc2VjdGlvbi90ZXN0X2ludGVyc2VjdGlvbi5pbgo+
ICsrKyBiL3Rlc3RzL2NsaS9pbnRlcnNlY3Rpb24vdGVzdF9pbnRlcnNlY3Rpb24uaW4KPiBAQCAt
MjYsOSArMjYsOSBAQCB0ZXN0X2ludGVyc2VjdCgpIHsKPiAgICAgICAgIHRvdGFsZXZlbnRzPSIk
MiIKPiAgICAgICAgIGludGVyc2VjdD0iJDMiCj4KPiAtICAgICAgIHRlc3QgIiQoIiR7QlRfQklO
fSIgIiR0cmFjZSIgfCB3YyAtbCkiID0gIiR0b3RhbGV2ZW50cyIKPiArICAgICAgIHRlc3QgJCgi
JHtCVF9CSU59IiAiJHRyYWNlIiB8IHdjIC1sKSA9ICIkdG90YWxldmVudHMiCj4gICAgICAgICBv
ayAkPyAiJHRvdGFsZXZlbnRzIGV2ZW50cyBpbiB0aGUgd2hvbGUgdHJhY2UiCj4gLSAgICAgICB0
ZXN0ICIkKCIke0JUX0JJTn0iIC0tc3RyZWFtLWludGVyc2VjdGlvbiAiJHRyYWNlIiAyPi9kZXYv
bnVsbHwgd2MgLWwpIiA9ICIkaW50ZXJzZWN0Igo+ICsgICAgICAgdGVzdCAkKCIke0JUX0JJTn0i
IC0tc3RyZWFtLWludGVyc2VjdGlvbiAiJHRyYWNlIiAyPi9kZXYvbnVsbHwgd2MgLWwpID0gIiRp
bnRlcnNlY3QiCj4gICAgICAgICBvayAkPyAiJGludGVyc2VjdCBldmVudHMgaW4gcGFja2V0cyBp
bnRlcnNlY3RpbmciCj4gIH0KPgo+IC0tCj4gMi43LjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFy
bmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==

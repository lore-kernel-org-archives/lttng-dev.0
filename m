From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] babeltrace: add test for babeltrace --list
Date: Wed, 14 Sep 2016 14:04:51 -0400
Message-ID: <CA+jJMxutf9aBni73W=JHn95tXXTqTrs3XXo=yvQcCtGHAPepAg__6571.57338359884$1473876304$gmane$org@mail.gmail.com>
References: <1471540228-24555-1-git-send-email-nathan_lynch@mentor.com>
 <c58c6445-dfe0-0835-4bea-d4b944509200@mentor.com>
 <CA+jJMxuGjA9MBm_gh_zLmPGiCQEv7S9OAS-ODhwOW-4dVwDT3A@mail.gmail.com>
 <0500974e-6635-3b63-f29f-2687b82407a1@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-f181.google.com (mail-yb0-f181.google.com
 [209.85.213.181])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C1913A3D4F
 for <lttng-dev@lists.lttng.org>; Wed, 14 Sep 2016 18:05:47 +0000 (UTC)
Received: by mail-yb0-f181.google.com with SMTP id u125so18604399ybg.3
 for <lttng-dev@lists.lttng.org>; Wed, 14 Sep 2016 11:04:52 -0700 (PDT)
In-Reply-To: <0500974e-6635-3b63-f29f-2687b82407a1@mentor.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Nathan Lynch <Nathan_Lynch@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFR1ZSwgU2VwIDEzLCAyMDE2IGF0IDE6NTUg
UE0sIE5hdGhhbiBMeW5jaCA8TmF0aGFuX0x5bmNoQG1lbnRvci5jb20+IHdyb3RlOgo+IE9uIDA5
LzEzLzIwMTYgMTI6NDcgUE0sIErDqXLDqW1pZSBHYWxhcm5lYXUgd3JvdGU6Cj4+IFRoZSBwYXRj
aCBsb29rcyBnb29kIHRvIG1lLCBidXQgd291bGQgeW91IG1pbmQgY2hhbmdpbmcgdGhlIGhlYWRl
ciBvZgo+PiB0ZXN0X2Zvcm1hdHMgdG8gdGhlIGZ1bGwgR1BMIGhlYWRlciArIGNvcHlyaWdodCBt
ZW50aW9uLCBhcyBpcyBkb25lCj4+IGhlcmU6Cj4+Cj4+IGh0dHBzOi8vcmF3LmdpdGh1YnVzZXJj
b250ZW50LmNvbS9lZmZpY2lvcy9iYWJlbHRyYWNlL21hc3Rlci90ZXN0cy9iaW4vaW50ZXJzZWN0
aW9uL3Rlc3RfaW50ZXJzZWN0aW9uLmluCj4+Cj4+IEkgY2FuIHBlcmZvcm0gdGhlIGNoYW5nZSBt
eXNlbGYsIGJ1dCBJIHdhbnQgdG8gbWFrZSBzdXJlIGl0J3Mgb2theS4KPgo+IEl0J3MgZmluZSB3
aXRoIG1lLCB0aGFua3MuCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6
Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
ZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==

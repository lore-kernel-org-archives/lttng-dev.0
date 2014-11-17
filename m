From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Add missing URCU_TLS
 access to error_log_time
Date: Mon, 17 Nov 2014 13:07:08 -0500
Message-ID: <CA+jJMxsq_YOAdavPjaKS7B1R5y2R+-ByKfrGO1Vt1dMWk4bL5g__732.367291539226$1416247677$gmane$org@mail.gmail.com>
References: <1415380622-22533-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f47.google.com ([209.85.215.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1XqQhm-0002Zq-LZ
 for lttng-dev@lists.lttng.org; Mon, 17 Nov 2014 13:07:20 -0500
Received: by mail-la0-f47.google.com with SMTP id gq15so3104990lab.34
 for <lttng-dev@lists.lttng.org>; Mon, 17 Nov 2014 10:07:08 -0800 (PST)
In-Reply-To: <1415380622-22533-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIEZyaSwgTm92IDcsIDIwMTQgYXQgMTI6MTcg
UE0sIENocmlzdGlhbiBCYWJldXgKPGNocmlzdGlhbi5iYWJldXhAZWZmaWNpb3MuY29tPiB3cm90
ZToKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gQmFiZXV4IDxjaHJpc3RpYW4uYmFiZXV4QGVm
ZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2NvbW1vbi9lcnJvci5jIHwgMiArLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9z
cmMvY29tbW9uL2Vycm9yLmMgYi9zcmMvY29tbW9uL2Vycm9yLmMKPiBpbmRleCA1NWQ1NmU2Li41
NzcwNzBlIDEwMDY0NAo+IC0tLSBhL3NyYy9jb21tb24vZXJyb3IuYwo+ICsrKyBiL3NyYy9jb21t
b24vZXJyb3IuYwo+IEBAIC00OSw3ICs0OSw3IEBAIGNvbnN0IGNoYXIgKmxvZ19hZGRfdGltZSh2
b2lkKQo+ICAgICAgICAgfQo+Cj4gICAgICAgICAvKiBGb3JtYXQgdGltZSBpbiB0aGUgVExTIHZh
cmlhYmxlLiAqLwo+IC0gICAgICAgcmV0ID0gc25wcmludGYoVVJDVV9UTFMoZXJyb3JfbG9nX3Rp
bWUpLnN0ciwgc2l6ZW9mKGVycm9yX2xvZ190aW1lLnN0ciksCj4gKyAgICAgICByZXQgPSBzbnBy
aW50ZihVUkNVX1RMUyhlcnJvcl9sb2dfdGltZSkuc3RyLCBzaXplb2YoVVJDVV9UTFMoZXJyb3Jf
bG9nX3RpbWUpLnN0ciksCj4gICAgICAgICAgICAgICAgICAgICAgICAgIiUwMmQ6JTAyZDolMDJk
LiUwNmxkIiwKPiAgICAgICAgICAgICAgICAgICAgICAgICB0bS50bV9ob3VyLCB0bS50bV9taW4s
IHRtLnRtX3NlYywgdHAudHZfbnNlYyk7Cj4gICAgICAgICBpZiAocmV0IDwgMCkgewo+IC0tCj4g
Mi4xLjEKPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+
IGh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZm
aWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==

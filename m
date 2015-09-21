From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: int printed as uint
Date: Mon, 21 Sep 2015 16:15:47 -0400
Message-ID: <CA+jJMxuvNbfKXakOdCg+Hsztq7+2TqMNzOpPfSh4qGjpvjO-WQ__40092.4092311927$1442866629$gmane$org@mail.gmail.com>
References: <1442863170-18376-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Ze7VB-0002fh-6c
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 16:16:01 -0400
Received: by ykft14 with SMTP id t14so114457673ykf.0
 for <lttng-dev@lists.lttng.org>; Mon, 21 Sep 2015 13:15:47 -0700 (PDT)
In-Reply-To: <1442863170-18376-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuNy4KClRoYW5rcyEKSsOpcsOpbWllCgpPbiBN
b24sIFNlcCAyMSwgMjAxNSBhdCAzOjE5IFBNLCBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVm
ZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVh
bnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9jb21tb24vdXN0LWNvbnN1bWVyL3VzdC1j
b25zdW1lci5jIHwgNiArKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9zcmMvY29tbW9uL3VzdC1jb25zdW1lci91
c3QtY29uc3VtZXIuYyBiL3NyYy9jb21tb24vdXN0LWNvbnN1bWVyL3VzdC1jb25zdW1lci5jCj4g
aW5kZXggMDhlNmVlMC4uNDgxYmJlYiAxMDA2NDQKPiAtLS0gYS9zcmMvY29tbW9uL3VzdC1jb25z
dW1lci91c3QtY29uc3VtZXIuYwo+ICsrKyBiL3NyYy9jb21tb24vdXN0LWNvbnN1bWVyL3VzdC1j
b25zdW1lci5jCj4gQEAgLTQ3LDcgKzQ3LDcgQEAKPgo+ICAjaW5jbHVkZSAidXN0LWNvbnN1bWVy
LmgiCj4KPiAtI2RlZmluZSBVSU5UX01BWF9TVFJfTEVOIDExICAgIC8qIGluY2x1ZGVzIFwwICov
Cj4gKyNkZWZpbmUgSU5UX01BWF9TVFJfTEVOIDEyICAgICAvKiBpbmNsdWRlcyBcMCAqLwo+Cj4g
IGV4dGVybiBzdHJ1Y3QgbHR0bmdfY29uc3VtZXJfZ2xvYmFsX2RhdGEgY29uc3VtZXJfZGF0YTsK
PiAgZXh0ZXJuIGludCBjb25zdW1lcl9wb2xsX3RpbWVvdXQ7Cj4gQEAgLTI0OCwxMiArMjQ4LDEy
IEBAIGVycm9yOgo+ICBzdGF0aWMKPiAgaW50IGdldF9zdHJlYW1fc2htX3BhdGgoY2hhciAqc3Ry
ZWFtX3NobV9wYXRoLCBjb25zdCBjaGFyICpzaG1fcGF0aCwgaW50IGNwdSkKPiAgewo+IC0gICAg
ICAgY2hhciBjcHVfbnJbVUlOVF9NQVhfU1RSX0xFTl07ICAvKiB1bnNpZ25lZCBpbnQgbWF4IGxl
biAqLwo+ICsgICAgICAgY2hhciBjcHVfbnJbSU5UX01BWF9TVFJfTEVOXTsgIC8qIGludCBtYXgg
bGVuICovCj4gICAgICAgICBpbnQgcmV0Owo+Cj4gICAgICAgICBzdHJuY3B5KHN0cmVhbV9zaG1f
cGF0aCwgc2htX3BhdGgsIFBBVEhfTUFYKTsKPiAgICAgICAgIHN0cmVhbV9zaG1fcGF0aFtQQVRI
X01BWCAtIDFdID0gJ1wwJzsKPiAtICAgICAgIHJldCA9IHNucHJpbnRmKGNwdV9uciwgVUlOVF9N
QVhfU1RSX0xFTiwgIiV1IiwgY3B1KTsKPiArICAgICAgIHJldCA9IHNucHJpbnRmKGNwdV9uciwg
SU5UX01BWF9TVFJfTEVOLCAiJWkiLCBjcHUpOwo+ICAgICAgICAgaWYgKHJldCA8IDApIHsKPiAg
ICAgICAgICAgICAgICAgUEVSUk9SKCJzbnByaW50ZiIpOwo+ICAgICAgICAgICAgICAgICBnb3Rv
IGVuZDsKPiAtLQo+IDEuOS4xCj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1Mg
SW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=

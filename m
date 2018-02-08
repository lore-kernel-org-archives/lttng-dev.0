From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: Re: [PATCH lttng-ust 2/8] Fix: missing event removal
	from the event hashtable
Date: Thu, 8 Feb 2018 15:42:06 -0500
Message-ID: <CADcCL0iVq=qA5Teck2dL3wkXjn0ZVaUUt8q7Fv64ihhAEUUNiA__2386.01232781566$1518122446$gmane$org@mail.gmail.com>
References: <1517600891-23632-1-git-send-email-francis.deslauriers@efficios.com>
 <1517600891-23632-3-git-send-email-francis.deslauriers@efficios.com>
 <785880654.17806.1518036643540.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 by lists.lttng.org (Postfix) with ESMTPS id 3zcqrN6VH7zDPk
 for <lttng-dev@lists.lttng.org>; Thu,  8 Feb 2018 20:42:28 +0000 (UTC)
Received: by mail-io0-x244.google.com with SMTP id t22so7226441ioa.7
 for <lttng-dev@lists.lttng.org>; Thu, 08 Feb 2018 12:42:28 -0800 (PST)
In-Reply-To: <785880654.17806.1518036643540.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

MjAxOC0wMi0wNyAxNTo1MCBHTVQtMDU6MDAgTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVz
bm95ZXJzQGVmZmljaW9zLmNvbT46Cj4KPgo+IC0tLS0tIE9uIEZlYiAyLCAyMDE4LCBhdCAyOjQ4
IFBNLCBGcmFuY2lzIERlc2xhdXJpZXJzIGZyYW5jaXMuZGVzbGF1cmllcnNAZWZmaWNpb3MuY29t
IHdyb3RlOgo+Cj4gSXMgdGhpcyByZWFsbHkgYSBmaXggPyBPciBpcyBpdCBhIHByZXBhcmF0aW9u
IHN0ZXAgaW4gb3JkZXIgdG8gYmUgYWJsZSB0bwo+IHJlbW92ZSBldmVudHMgYmVmb3JlIHRoZSBl
bmQgb2YgdGhlIHNlc3Npb24gbGlmZXRpbWUgPwoKSXQncyBub3QgYSBmaXggaW4gdGhlIHNlbnNl
IHRoYXQgaXQgd2FzIG5vdCBjYXVzaW5nIGlzc3VlcyBiZWNhdXNlIGl0CndhcyBvbmx5IGNhbGxl
ZCBhdCBzZXNzaW9uIGRlc3RydWN0aW9uLgpCdXQgaXQncyBhIGZpeCBpbiB0aGUgc2Vuc2UgdGhh
dCB0aGUgX2x0dG5nX2V2ZW50X2Rlc3Ryb3kgZnVuY3Rpb24gd2FzCm5vdCBkb2luZyBhbGwgdGhl
IHdvcmsgbmVjZXNzYXJ5IHRvIGRlc3Ryb3kgYW4gZXZlbnQgcGFzc2VkIGFzCmFyZ3VtZW50LiBU
YWtlbiBieSBpdHNlbGYsIGEgY2FsbCB0byB0aGlzIGZ1bmN0aW9uIHdvdWxkIGxlYXZlIG9uZSBv
Zgp0aGUgaGxpc3RzIG9mIHRoZSBoYXNoIHRhYmxlIGluIGEgaW5jb3JyZWN0IHN0YXRlIGJ5IGZy
ZWVpbmcgYW4KZWxlbWVudCB3aXRob3V0IGNkc19obGlzdF9kZWwoKSBpdCBmcm9tIHRoZSBobGlz
dCBiZWZvcmUuCgpUaGF0IHdhcyBteSB0aG91Z2h0IHByb2Nlc3MuIFdoYXQgZG8geW91IHRoaW5r
PwoKVGhhbmsgeW91LApGcmFuY2lzCgo+IFRoYW5rcywKPgo+IE1hdGhpZXUKPgo+Cj4+IFNpZ25l
ZC1vZmYtYnk6IEZyYW5jaXMgRGVzbGF1cmllcnMgPGZyYW5jaXMuZGVzbGF1cmllcnNAZWZmaWNp
b3MuY29tPgo+PiAtLS0KPj4gbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jIHwgNCArKysrCj4+
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2xpYmx0
dG5nLXVzdC9sdHRuZy1ldmVudHMuYyBiL2xpYmx0dG5nLXVzdC9sdHRuZy1ldmVudHMuYwo+PiBp
bmRleCBmNGE3Y2NjLi43NDE5Zjc4IDEwMDY0NAo+PiAtLS0gYS9saWJsdHRuZy11c3QvbHR0bmct
ZXZlbnRzLmMKPj4gKysrIGIvbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jCj4+IEBAIC04ODMs
NyArODgzLDExIEBAIHZvaWQgX2x0dG5nX2V2ZW50X2Rlc3Ryb3koc3RydWN0IGx0dG5nX2V2ZW50
ICpldmVudCkKPj4gewo+PiAgICAgICBzdHJ1Y3QgbHR0bmdfZW5hYmxlcl9yZWYgKmVuYWJsZXJf
cmVmLCAqdG1wX2VuYWJsZXJfcmVmOwo+Pgo+PiArICAgICAvKiBSZW1vdmUgZnJvbSBldmVudCBs
aXN0LiAqLwo+PiAgICAgICBjZHNfbGlzdF9kZWwoJmV2ZW50LT5ub2RlKTsKPj4gKyAgICAgLyog
UmVtb3ZlIGZyb20gZXZlbnQgaGFzaCB0YWJsZS4gKi8KPj4gKyAgICAgY2RzX2hsaXN0X2RlbCgm
ZXZlbnQtPmhsaXN0KTsKPj4gKwo+PiAgICAgICBsdHRuZ19kZXN0cm95X2NvbnRleHQoZXZlbnQt
PmN0eCk7Cj4+ICAgICAgIGx0dG5nX2ZyZWVfZXZlbnRfZmlsdGVyX3J1bnRpbWUoZXZlbnQpOwo+
PiAgICAgICAvKiBGcmVlIGV2ZW50IGVuYWJsZXIgcmVmcyAqLwo+PiAtLQo+PiAyLjcuNAo+Cj4g
LS0KPiBNYXRoaWV1IERlc25veWVycwo+IEVmZmljaU9TIEluYy4KPiBodHRwOi8vd3d3LmVmZmlj
aW9zLmNvbQoKCgotLSAKRnJhbmNpcyBEZXNsYXVyaWVycwpTb2Z0d2FyZSBkZXZlbG9wZXIKRWZm
aWNpT1MgaW5jLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=

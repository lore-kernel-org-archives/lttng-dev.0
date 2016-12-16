From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: free previous instance
 of url (alloc_url) on default live url assignation
Date: Fri, 16 Dec 2016 07:48:09 -0500
Message-ID: <CA+jJMxsqRgxQSJd52g_eZdL+2AEm1tDP-k8U9T+WBnuJocOmoQ__12506.3313091689$1481892511$gmane$org@mail.gmail.com>
References: <1481578757-27974-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3tg9C45Tw1ztHG
 for <lttng-dev@lists.lttng.org>; Fri, 16 Dec 2016 12:50:24 +0000 (UTC)
Received: by mail-ua0-x242.google.com with SMTP id 51so2408933uai.1
 for <lttng-dev@lists.lttng.org>; Fri, 16 Dec 2016 04:48:10 -0800 (PST)
In-Reply-To: <1481578757-27974-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuOSBhbmQgc3RhYmxlLTIuOC4KClRoYW5rcyBmb3Ig
dGhlIGZpeCBhbmQgdGhhbmtzIFBoaWwgZm9yIHRoZSByZXZpZXchCkrDqXLDqW1pZQoKT24gMTIg
RGVjZW1iZXIgMjAxNiBhdCAxNjozOSwgSm9uYXRoYW4gUmFqb3R0ZQo8am9uYXRoYW4ucmFqb3R0
ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBS
YWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNy
Yy9iaW4vbHR0bmcvY29tbWFuZHMvY3JlYXRlLmMgfCA0ICsrKysKPiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMv
Y3JlYXRlLmMgYi9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2NyZWF0ZS5jCj4gaW5kZXggMGY3ZDFh
NC4uNDBkMmE3NyAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2NyZWF0ZS5j
Cj4gKysrIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9jcmVhdGUuYwo+IEBAIC0zNDIsNiArMzQy
LDEwIEBAIHN0YXRpYyBpbnQgY3JlYXRlX3Nlc3Npb24odm9pZCkKPgo+ICAgICAgICAgLyogVXNl
IGRlZmF1bHQgbGl2ZSBVUkwgaWYgTk8gdXJsIGlzL2FyZSBmb3VuZC4gKi8KPiAgICAgICAgIGlm
ICgob3B0X2xpdmVfdGltZXIgJiYgIW9wdF91cmwpICYmIChvcHRfbGl2ZV90aW1lciAmJiAhb3B0
X2RhdGFfdXJsKSkgewo+ICsgICAgICAgICAgICAgICAvKiBPdmVycmlkZSB0aGUgdXJsICovCj4g
KyAgICAgICAgICAgICAgIGZyZWUodXJsKTsKPiArICAgICAgICAgICAgICAgdXJsID0gTlVMTDsK
PiArCj4gICAgICAgICAgICAgICAgIHJldCA9IGFzcHJpbnRmKCZhbGxvY191cmwsICJuZXQ6Ly8x
MjcuMC4wLjEiKTsKPiAgICAgICAgICAgICAgICAgaWYgKHJldCA8IDApIHsKPiAgICAgICAgICAg
ICAgICAgICAgICAgICBQRVJST1IoImFzcHJpbnRmIGRlZmF1bHQgbGl2ZSBVUkwiKTsKPiAtLQo+
IDIuNy40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8v
d3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=

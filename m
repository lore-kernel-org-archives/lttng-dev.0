From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: add element length check
	in lttng_index_file_open
Date: Fri, 16 Dec 2016 07:48:33 -0500
Message-ID: <CA+jJMxt1BkQiO-S4pHj0+zH34x0rr5ZO_Z0xpCJUF_wmEcawtg__18431.4003600322$1481892527$gmane$org@mail.gmail.com>
References: <1481800399-10077-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3tg9CX3MmnztHc
 for <lttng-dev@lists.lttng.org>; Fri, 16 Dec 2016 12:50:48 +0000 (UTC)
Received: by mail-ua0-x242.google.com with SMTP id 50so4173760uae.2
 for <lttng-dev@lists.lttng.org>; Fri, 16 Dec 2016 04:48:33 -0800 (PST)
In-Reply-To: <1481800399-10077-1-git-send-email-mathieu.desnoyers@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuOSBhbmQgc3RhYmxlLTIuOC4KClRoYW5rcyEKSsOp
csOpbWllCgpPbiAxNSBEZWNlbWJlciAyMDE2IGF0IDA2OjEzLCBNYXRoaWV1IERlc25veWVycwo8
bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPiBIYW5kbGUgY2FzZXMgd2hl
cmUgdGhlIGluZGV4IGZpbGUgaGVhZGVyIHdvdWxkIGNvbnRhaW4gYSBjb3JydXB0ZWQKPiB2YWx1
ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVy
c0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9jb21tb24vaW5kZXgvaW5kZXguYyB8IDQgKysr
Kwo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvc3Jj
L2NvbW1vbi9pbmRleC9pbmRleC5jIGIvc3JjL2NvbW1vbi9pbmRleC9pbmRleC5jCj4gaW5kZXgg
YmE2OWNkYy4uZWNkNGQ0NSAxMDA2NDQKPiAtLS0gYS9zcmMvY29tbW9uL2luZGV4L2luZGV4LmMK
PiArKysgYi9zcmMvY29tbW9uL2luZGV4L2luZGV4LmMKPiBAQCAtMjQ2LDYgKzI0NiwxMCBAQCBz
dHJ1Y3QgbHR0bmdfaW5kZXhfZmlsZSAqbHR0bmdfaW5kZXhfZmlsZV9vcGVuKGNvbnN0IGNoYXIg
KnBhdGhfbmFtZSwKPiAgICAgICAgICAgICAgICAgRVJSKCJJbnZhbGlkIGhlYWRlciB2ZXJzaW9u
Iik7Cj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfY2xvc2U7Cj4gICAgICAgICB9Cj4gKyAg
ICAgICBpZiAoZWxlbWVudF9sZW4gPiBzaXplb2Yoc3RydWN0IGN0Zl9wYWNrZXRfaW5kZXgpKSB7
Cj4gKyAgICAgICAgICAgICAgIEVSUigiSW5kZXggZWxlbWVudCBsZW5ndGggdG9vIGxvbmciKTsK
PiArICAgICAgICAgICAgICAgZ290byBlcnJvcl9jbG9zZTsKPiArICAgICAgIH0KPgo+ICAgICAg
ICAgaW5kZXhfZmlsZS0+ZmQgPSByZWFkX2ZkOwo+ICAgICAgICAgaW5kZXhfZmlsZS0+bWFqb3Ig
PSBtYWpvcjsKPiAtLQo+IDIuMS40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNp
T1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=

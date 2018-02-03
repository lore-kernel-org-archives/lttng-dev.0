From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v5 1/2] lttng-relayd: use TCP
 keep-alive mechanism to detect dead-peer
Date: Sat, 3 Feb 2018 15:13:19 -0500
Message-ID: <CA+jJMxtF+ttQ+Q5u7osWFb63keEO4hSEStYz=yBxKEFB7a8X_A__40777.050323277$1517688729$gmane$org@mail.gmail.com>
References: <1516653815-31654-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <CA+jJMxsjQVWAjdfCjAC__f09BCsA73-mvy8X=_DcJaiDw+-+wQ@mail.gmail.com>
 <20180201231053.GA15056@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3zYlRS5z72zs2P
 for <lttng-dev@lists.lttng.org>; Sat,  3 Feb 2018 20:13:40 +0000 (UTC)
Received: by mail-yw0-x243.google.com with SMTP id x62so15766526ywg.11
 for <lttng-dev@lists.lttng.org>; Sat, 03 Feb 2018 12:13:40 -0800 (PST)
In-Reply-To: <20180201231053.GA15056@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

T24gMSBGZWJydWFyeSAyMDE4IGF0IDE4OjEwLCBKb25hdGhhbiBSYWpvdHRlLUp1bGllbgo8am9u
YXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBUaGFua3MsCj4KPiBP
biBUaHUsIEZlYiAwMSwgMjAxOCBhdCAwNjowMzoxM1BNIC0wNTAwLCBKw6lyw6ltaWUgR2FsYXJu
ZWF1IHdyb3RlOgo+PiBNZXJnZWQgd2l0aCBzb21lIGNoYW5nZXMuCj4KPiBEbyB5b3UgcGxhbiBv
biBiYWNrcG9ydGluZyB0aGlzPyBHaXZlbiB0aGF0IGl0IHByZXZlbnQgZmQgbGVha3MgZm9yIGxv
bmcgcnVubmluZwo+IHJlbGF5ZCB3aGVyZSBkZWFkIHBlZXIgaXMgY29tbW9uLgoKWWVzLiBJdCBp
cyBub3cgcGFydCBvZiB0aGUgc3RhYmxlLTIuMTAgYW5kIHN0YWJsZS0yLjkgYnJhbmNoZXMuCgpK
w6lyw6ltaWUKCj4KPiBDaGVlcnMKPgo+Pgo+PiBUaGFua3MhCj4+IErDqXLDqW1pZQo+Pgo+PiBP
biAyMiBKYW51YXJ5IDIwMTggYXQgMTU6NDMsIEpvbmF0aGFuIFJham90dGUKCgoKLS0gCkrDqXLD
qW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=

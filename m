From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools v5 1/2] lttng-relayd: use TCP
 keep-alive mechanism to detect dead-peer
Date: Thu, 1 Feb 2018 18:10:53 -0500
Message-ID: <20180201231053.GA15056__34948.6876781613$1517526558$gmane$org@joraj-alpa>
References: <1516653815-31654-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <CA+jJMxsjQVWAjdfCjAC__f09BCsA73-mvy8X=_DcJaiDw+-+wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zXbSx0jnSzpKr
 for <lttng-dev@lists.lttng.org>; Thu,  1 Feb 2018 23:10:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CA+jJMxsjQVWAjdfCjAC__f09BCsA73-mvy8X=_DcJaiDw+-+wQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

VGhhbmtzLAoKT24gVGh1LCBGZWIgMDEsIDIwMTggYXQgMDY6MDM6MTNQTSAtMDUwMCwgSsOpcsOp
bWllIEdhbGFybmVhdSB3cm90ZToKPiBNZXJnZWQgd2l0aCBzb21lIGNoYW5nZXMuCgpEbyB5b3Ug
cGxhbiBvbiBiYWNrcG9ydGluZyB0aGlzPyBHaXZlbiB0aGF0IGl0IHByZXZlbnQgZmQgbGVha3Mg
Zm9yIGxvbmcgcnVubmluZwpyZWxheWQgd2hlcmUgZGVhZCBwZWVyIGlzIGNvbW1vbi4KCkNoZWVy
cwoKPiAKPiBUaGFua3MhCj4gSsOpcsOpbWllCj4gCj4gT24gMjIgSmFudWFyeSAyMDE4IGF0IDE1
OjQzLCBKb25hdGhhbiBSYWpvdHRlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==

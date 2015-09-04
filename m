From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/3] Build: look for python >=
 3.0 when building python bindings
Date: Fri, 4 Sep 2015 15:06:06 -0400
Message-ID: <CA+jJMxvo0REX61uRs-OgL8ZXQoZ_KA-5JmtNy2+VMbXsOci5FA__28487.294764682$1441393732$gmane$org@mail.gmail.com>
References: <1438902016-17511-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <1438902016-17511-2-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZXwJQ-0004R5-6W
 for lttng-dev@lists.lttng.org; Fri, 04 Sep 2015 15:06:16 -0400
Received: by ykdg206 with SMTP id g206so30170271ykd.1
 for <lttng-dev@lists.lttng.org>; Fri, 04 Sep 2015 12:06:06 -0700 (PDT)
In-Reply-To: <1438902016-17511-2-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFRodSwgQXVnIDYsIDIwMTUgYXQgNzowMCBQ
TSwgSm9uYXRoYW4gUmFqb3R0ZQo8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29t
PiB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpv
dHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIGNvbmZpZ3VyZS5hYyB8IDIgKy0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvY29uZmlndXJlLmFjIGIvY29uZmlndXJlLmFjCj4gaW5kZXggMzEyYjlmNy4uMzI0YjU5
NiAxMDA2NDQKPiAtLS0gYS9jb25maWd1cmUuYWMKPiArKysgYi9jb25maWd1cmUuYWMKPiBAQCAt
MzM5LDcgKzMzOSw3IEBAIEFNX0NPTkRJVElPTkFMKFtQWVRIT05fQklORElOR10sIFt0ZXN0ICJ4
JHtlbmFibGVfcHl0aG9uX2JpbmRpbmc6LXllc30iID0geHllc10pCj4KPiAgaWYgdGVzdCAieCR7
ZW5hYmxlX3B5dGhvbl9iaW5kaW5nOi15ZXN9IiA9IHh5ZXM7IHRoZW4KPiAgICBBWF9QS0dfU1dJ
Rygkc3dpZ192ZXJzaW9uLCBbXSwgWyBBQ19NU0dfRVJST1IoW1NXSUcgJHN3aWdfdmVyc2lvbiBv
ciBuZXdlciBpcyBuZWVkZWRdKSBdKQo+IC0gIEFNX1BBVEhfUFlUSE9OCj4gKyAgQU1fUEFUSF9Q
WVRIT04oWzMuMF0pCj4KPiAgICBBQ19BUkdfVkFSKFtQWVRIT05fSU5DTFVERV0sIFtJbmNsdWRl
IGZsYWdzIGZvciBweXRob24sIGJ5cGFzc2luZyBweXRob24tY29uZmlnXSkKPiAgICBBQ19BUkdf
VkFSKFtQWVRIT05fQ09ORklHXSwgW1BhdGggdG8gcHl0aG9uLWNvbmZpZ10pCj4gLS0KPiAyLjEu
NAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

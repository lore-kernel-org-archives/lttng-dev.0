From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Problem with vpid in lttng output
Date: Mon, 2 Sep 2019 15:33:49 -0400
Message-ID: <20190902193349.GA15770__43059.9198605464$1567452856$gmane$org@joraj-alpa>
References: <AM0PR07MB590692B318D8FC8187D54EEB96BE0@AM0PR07MB5906.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46MgHr2QQRzsBf
 for <lttng-dev@lists.lttng.org>; Mon,  2 Sep 2019 15:34:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 9502F2574CA
 for <lttng-dev@lists.lttng.org>; Mon,  2 Sep 2019 15:33:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <AM0PR07MB590692B318D8FC8187D54EEB96BE0@AM0PR07MB5906.eurprd07.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Aleksander Twardowski <aleksander.twardowski@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgQWxla3NhbmRlciwKCk9uIE1vbiwgU2VwIDAyLCAyMDE5IGF0IDEyOjAxOjQ2UE0gKzAwMDAs
IEFsZWtzYW5kZXIgVHdhcmRvd3NraSB2aWEgbHR0bmctZGV2IHdyb3RlOgo+IEhpLAo+IAo+IEkg
ZG8gbm90IGtub3cgaWYgSSBhbSBhZGRyZXNzaW5nIHByb2JsZW0gY29ycmVjdGx5IGJ1dCBsZXTi
gJlzIHRyeSDwn5iKCj4gSSBoYXZlIGEgcHJvYmxlbSwgb2NjdXJyaW5nIHZlcnkgcmFyZWx5LCB3
aXRoIHZwaWQgaW4gbHR0bmcgb3V0cHV0Lgo+IFNvbWV0aW1lcywgSSBkbyBub3Qga25vdyB3aHks
IHZwaWQgaXMgbm90IHZpc2libGUuCj4gCj4gUHJvcGVyIGx0dG5nIGxvZzoKPiBbMTQ6MDg6MzUu
MTU2MzMzNjcwXSAoKzAuMDAwMDEwNzI0KSBzZWxpbHN4MTc5NSBjb21fZXJpY3Nzb25fY3NpbV91
cDpFUlJPUjogeyBjcHVfaWQgPSAwIH0sIHsgdnBpZCA9IDE2ODI2IH0sIHsgc3JjID0gIi9ob21l
L2VhbGV0d2EvcmVwb3MvYnB1LXVwL3NyYy9ScHVwLmNwcDoxMjU6Iiwgb2JqID0gIkdFTkVSQUwi
LCBtc2cgPSAiRmFpbGVkIHRvIGluaXRpYWxpemUgU0RTIGNvbm5lY3Rpb24iIH0KClNpZGUgbm90
ZTogbWFrZSBzdXJlIHRvIHJlZGFjdCBpbmZvcm1hdGlvbiB0aGF0IGNvdWxkIGJlIHNlbnNpdGl2
ZS4gSGVyZSB0aGUKcGF5bG9hZCBhbmQgZXZlbnQgbmFtZSBjb3VsZCBiZSBjb25zaWRlcmVkIHNl
bnNpdGl2ZS4gSXQgaXMgdXAgdG8geW91IHRvCmV2YWx1YXRlIHdoYXQgaXMgc2Vuc2l0aXZlIGFu
ZCB3aGF0IGlzIG5vdC4KCj4gCj4gUHJvYmxlbWF0aWMgbHR0bmcgbG9nOgo+IOKAnFsxNDowODoz
NS4xNTYzMzM2NzBdICgrMC4wMDAwMTA3MjQpIHNlbGlsc3gxNzk1IGNvbV9lcmljc3Nvbl9jc2lt
X3VwOkVSUk9SOiB7IGNwdV9pZCA9IDAgfSwgeyBzcmMgPSAiL2hvbWUvZWFsZXR3YS9yZXBvcy9i
cHUtdXAvc3JjL1JwdXAuY3BwOjEyNToiLCBvYmogPSAiR0VORVJBTCIsIG1zZyA9ICJGYWlsZWQg
dG8gaW5pdGlhbGl6ZSBTRFMgY29ubmVjdGlvbiIgfeKAnQoKRG9lcyB0aGlzIHNpdHVhdGlvbiBo
YXBwZW4gaW5zaWRlIHRoZSBzYW1lIHRyYWNlPyBPciBkb2VzIGl0IHNlZW1zIHRvIGhhcHBlbnMK
YmV0d2VlbiB0cmFjZXM/Cgo+IAo+IElmIHlvdSBjYW4gaGVscCBtZSwgdGVsbCBtZSBpbiB3aGlj
aCBjYXNlcyB0aGlzIHByb2JsZW0gb2NjdXJyaW5nIHRoYXQgd291bGQgYmUgZ3JlYXQuCgpXZSBh
cmUgbm90IGF3YXJlIG9mIGFueSBvbmdvaW5nIGlzc3VlIHdpdGggdGhlIGNvbnRleHQgc3Vic3lz
dGVtLiBBIGZpcnN0IHN0ZXAKd291bGQgYmUgdG8gdmFsaWRhdGUgdGhhdCB0aGUgImx0dG5nIGFk
ZC1jb250ZXh0IiAob3IgZXF1aXZhbGVudCkgd2FzIHBlcmZvcm1lZAp3aXRob3V0IGFueSBlcnJv
ciBmb3IgdGhlIHNlc3Npb24gb2YgdGhlIHRyYWNlIHdpdGggdGhlIHZwaWQgaW5mb3JtYXRpb24K
bWlzc2luZy4gTm90ZSB0aGF0IHlvdSBjYW5ub3QgYWRkIGNvbnRleHQgZmllbGQgZm9yIGEgdHJh
Y2luZyBzZXNzaW9uIGlmIGl0IHdhcwpzdGFydGVkIGF0IGxlYXN0IG9uY2UuCgpDaGVlcnMKCi0t
IApKb25hdGhhbiBSYWpvdHRlLUp1bGllbgpFZmZpY2lPUwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=

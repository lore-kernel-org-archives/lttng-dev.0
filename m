From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: don't destroy the sockets
 if the snapshot was successful
Date: Wed, 10 Dec 2014 16:37:13 -0500
Message-ID: <CA+jJMxsO9E0-0QH9kMHXieWFZOhKmtRvArBALgbo2r=LUbEbnw__697.540996088897$1418247483$gmane$org@mail.gmail.com>
References: <1418161085-18739-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Xyowh-0004lR-4D
 for lttng-dev@lists.lttng.org; Wed, 10 Dec 2014 16:37:21 -0500
Received: by mail-qg0-f43.google.com with SMTP id i50so2813280qgf.2
 for <lttng-dev@lists.lttng.org>; Wed, 10 Dec 2014 13:37:13 -0800 (PST)
In-Reply-To: <1418161085-18739-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGFsbCB0aGUgd2F5IHRvIDIuNC4KClRoYW5rcyEKSsOpcsOpbWllCgpPbiBUdWUsIERl
YyA5LCAyMDE0IGF0IDQ6MzggUE0sIEp1bGllbiBEZXNmb3NzZXoKPGpkZXNmb3NzZXpAZWZmaWNp
b3MuY29tPiB3cm90ZToKPiBNaXNzaW5nIGEgZ290byB0byBza2lwIHRoZSBlcnJvciBjb25kaXRp
b24gdGhhdCB3YXMgZGVzdHJveWluZyB0aGUKPiByZWxheWQgc29ja2V0cyBldmVuIGlmIGEgc25h
cHNob3Qgd2FzIHN1Y2Nlc3NmdWwuIFdlIHdhbnQgdG8ga2VlcCB0aGVtCj4gb3BlbiB0byByZXVz
ZSB0aGVtIGZvciB0aGUgbmV4dCBzbmFwc2hvdHMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKdWxpZW4g
RGVzZm9zc2V6IDxqZGVzZm9zc2V6QGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9sdHRu
Zy1zZXNzaW9uZC9jbWQuYyB8IDIgKysKPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21kLmMgYi9zcmMvYmlu
L2x0dG5nLXNlc3Npb25kL2NtZC5jCj4gaW5kZXggMTFmZjliNC4uNTg1MDZiMiAxMDA2NDQKPiAt
LS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL2NtZC5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC9jbWQuYwo+IEBAIC0yOTc5LDExICsyOTc5LDEzIEBAIHN0YXRpYyBpbnQgcmVjb3Jk
X2tlcm5lbF9zbmFwc2hvdChzdHJ1Y3QgbHR0X2tlcm5lbF9zZXNzaW9uICprc2VzcywKPiAgICAg
ICAgIH0KPgo+ICAgICAgICAgcmV0ID0gTFRUTkdfT0s7Cj4gKyAgICAgICBnb3RvIGVuZDsKPgo+
ICBlcnJvcl9zbmFwc2hvdDoKPiAgICAgICAgIC8qIENsZWFuIHVwIGNvcGllZCBzb2NrZXRzIHNv
IHRoaXMgb3V0cHV0IGNhbiB1c2Ugc29tZSBvdGhlciBsYXRlciBvbi4gKi8KPiAgICAgICAgIGNv
bnN1bWVyX2Rlc3Ryb3lfb3V0cHV0X3NvY2tldHMob3V0cHV0LT5jb25zdW1lcik7Cj4gIGVycm9y
Ogo+ICtlbmQ6Cj4gICAgICAgICByZXR1cm4gcmV0Owo+ICB9Cj4KPiAtLQo+IDEuOS4xCj4KCgoK
LS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9z
LmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=

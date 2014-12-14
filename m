From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: bug #857 -- babeltrace may core dump if index file
 is too short (with patch)
Date: Sun, 14 Dec 2014 14:46:04 -0500
Message-ID: <CAB4xu_3m73Dq2emRLdYz_=nvj4N3Ls6SshACb=2-1aTOA5Kwug__15269.6958314211$1418586438$gmane$org@mail.gmail.com>
References: <CADjtVtb6J6ird2fYgWibLzq4tFmjNtv8G23Z+Krk6Fqabcc5Pw@mail.gmail.com>
 <CA+jJMxu1vGN_CoqdK6he8nfE-0P3nyFh9_9oFAs_bpjpP8tmJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1Y0F7o-0008KP-AN
 for lttng-dev@lists.lttng.org; Sun, 14 Dec 2014 14:46:41 -0500
Received: by mail-lb0-f177.google.com with SMTP id b6so8145205lbj.36
 for <lttng-dev@lists.lttng.org>; Sun, 14 Dec 2014 11:46:34 -0800 (PST)
In-Reply-To: <CA+jJMxu1vGN_CoqdK6he8nfE-0P3nyFh9_9oFAs_bpjpP8tmJA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: craig harmer <charmster@gmail.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, charmer-lttng.org@punchdown.org
List-Id: lttng-dev@lists.lttng.org

T24gU3VuLCBEZWMgMTQsIDIwMTQgYXQgMTo0NyBQTSwgSsOpcsOpbWllIEdhbGFybmVhdQo8amVy
ZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+IE9uIFNhdCwgRGVjIDEzLCAy
MDE0IGF0IDEwOjA4IFBNLCBjcmFpZyBoYXJtZXIgPGNoYXJtc3RlckBnbWFpbC5jb20+IHdyb3Rl
Ogo+ID4gaGkgYWxsLAo+ID4KPiA+IGkgb3BlbmVkIGEgYnVnIGF0IGJ1Z3MubHR0bmcub3JnIGFi
b3V0IGEgcHJvYmxlbSB0aGF0IGkgaGFkIHdoZXJlIGJhYmVsdHJhY2UKPiA+IHdvdWxkIGV4aXQs
IHBvc3NpYmx5IHdpdGggYSBjb3JlIGR1bXAsIGlmIG9uZSB0aGUgdHJhY2UncyBpbmRleCBmaWxl
cyB3YXMKPiA+IHRvbyBzaG9ydC4KPiA+Cj4gPiB5b3UgY2FuIHJlYWQgdGhlIGJ1Zywgd2l0aCBw
YXRjaCwgYXQgQnVnICM4NTcgYmFiZWx0cmFjZSB3aWxsIGV4aXQgKG9mdGVuCj4gPiB3aXRoIGEg
Y29yZSBkdW1wKSBpZiBhbiBpbmRleCBmaWxlIGlzIHRvbyBzaG9ydAo+ID4KPiA+IGkgc3VibWl0
dGVkIGEgcGF0Y2ggZm9yIHRoZSBwcm9ibGVtIGFsc28gZml4ZXMgYSBmZXcgb3RoZXIgcGxhY2Vz
IHRoYXQgc2hvcnQKPiA+IHJlYWRzIGFyZSBub3QgaGFuZGxlZCBwcm9wZXJseS4KPiA+Cj4gPiB0
aGVyZSBoYXNuJ3QgYmVlbiBhbnkgYWN0aXZpdHkgb24gdGhlIGJ1ZyBzaW5jZSBpIHN1Ym1pdHRl
ZCB0aGUgcGF0Y2ggYWJvdXQKPiA+IDEgbW9udGggYWdvLCBzbyBpJ20gd29uZGVyaW5nIGlmIGkg
bmVlZCB0byBzdWJtaXQgdGhlIHBhdGNoIHRvIHRoaXMgbGlzdCBhcwo+ID4gd2VsbC4KPiA+Cj4K
PiBIaSBDcmFpZyEKPgo+IEkgZG8gcmVjb21tZW5kIHBlb3BsZSBzZW5kIHRoZSBwYXRjaGVzIHRv
IHRoZSBtYWlsaW5nIGxpc3QgYW5kIGxpbmsgdG8KPiBpdCBpbiB0aGUgYnVnIHRyYWNrZXIuIFRo
aXMgbWFrZXMgaXQgZWFzaWVyIHRvIHRyYWNrIHdoZXRoZXIgb3Igbm90IGEKPiBwYXRjaCBoYXMg
YmVlbiBtZXJnZWQuCgpBbHNvLCBzZWUgdGhpczogPGh0dHA6Ly9sdHRuZy5vcmcvY29tbXVuaXR5
LyNjb250cmlidXRvcnMtZ3VpZGU+LgoKUGhpbAo+Cj4gVGhlIGJ1ZyB0cmFja2VyIHNlZW1zIGRv
d24gYXQgdGhlIG1vbWVudCAoaW50ZXJuYWwgc2VydmVyIGVycm9yKS4gSSdsbAo+IGxvb2sgYXQg
dGhlIHBhdGggb25jZSBpdCBpcyBiYWNrIHVwLgo+Cj4gVGhhbmtzLAo+IErDqXLDqW1pZQo+Cj4g
PiBjaGVlcnMsCj4gPgo+ID4gY3JhaWcuCj4gPgo+ID4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiA+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiA+IGx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiA+IGh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+ID4KPgo+Cj4KPiAtLQo+IErDqXLDqW1pZSBH
YWxhcm5lYXUKPiBFZmZpY2lPUyBJbmMuCj4gaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KPgo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2
IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

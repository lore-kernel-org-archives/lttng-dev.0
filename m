From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Porting LTTNG or Barectf to Android
Date: Mon, 20 Nov 2017 12:12:18 -0500
Message-ID: <CA+jJMxsuncZark5OfqXzBEA39s8hayDBvpRj8nqTxn3j2_4SHg__47790.7009808861$1511197953$gmane$org@mail.gmail.com>
References: <CAAuy2AQaGrH=dA8BVy2bxv=NXgJnfud5FzE25=YN6ORasjUE5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3ygZyr5cTGzhrW
 for <lttng-dev@lists.lttng.org>; Mon, 20 Nov 2017 17:12:20 +0000 (UTC)
Received: by mail-wr0-x242.google.com with SMTP id k61so8730042wrc.4
 for <lttng-dev@lists.lttng.org>; Mon, 20 Nov 2017 09:12:20 -0800 (PST)
In-Reply-To: <CAAuy2AQaGrH=dA8BVy2bxv=NXgJnfud5FzE25=YN6ORasjUE5w@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Nwafor, Ebelechukwu" <ebelechukwu.nwafor@bison.howard.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGksCgpDaGFybGVzIEJyacOocmUgcG9zdGVkIGEgc2VyaWVzIG9uIHBhdGNoIG9uIHRoZSBNTCBb
MV0gaW4gMjAxNCB0aGF0CnBvcnRlZCBMVFRuZyB0byBBbmRyb2lkIGFuZCBteSB1bmRlcnN0YW5k
aW5nIGlzIHRoYXQgaXQgbWFkZSBrZXJuZWwKdHJhY2luZyBwb3NzaWJsZS4gVXNlciBzcGFjZSB0
cmFjaW5nIHN0aWxsIG5lZWRlZCBhIGxvdCBvZiB3b3JrLgoKT2YgY291cnNlIHRob3NlIHBhdGNo
ZXMgd29uJ3QgYXBwbHkgb24gbWFzdGVyLCBidXQgaXQgZ2l2ZXMgYSBnb29kCmlkZWEgb2Ygd2hh
dCdzIG5lZWRlZC4gQXQgdGhlIHRpbWUgSSBkaWRuJ3QgbWVyZ2UgdGhlbSBiZWNhdXNlIHdlIGhh
ZApubyB3YXkgdG8gdGVzdCB0aGUgcGF0Y2hlcyAoY29udGludW91c2x5KS4KClJlZ2FyZHMsCkrD
qXLDqW1pZQoKWzFdIGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL3BpcGVybWFpbC9sdHRuZy1kZXYv
MjAxNC1PY3RvYmVyLzAyMzY3OC5odG1sCgpPbiAxNiBOb3ZlbWJlciAyMDE3IGF0IDA5OjM5LCBO
d2Fmb3IsIEViZWxlY2h1a3d1CjxlYmVsZWNodWt3dS5ud2Fmb3JAYmlzb24uaG93YXJkLmVkdT4g
d3JvdGU6Cj4gSGVsbG8gRXZlcnlvbmUuCj4KPiBJIGFtIHdvcmtpbmcgb24gZ2VuZXJhdGluZyBD
VEYgZm9yIGFuZHJvaWQgYW5kIEkgd2FzIHdvbmRlcmluZyBpZiBhbnlvbmUgaGFzCj4gaGFkIGFu
eSBzdWNjZXNzL2V4cGVyaWVuY2Ugd2l0aCBwb3J0aW5nIGJhcmVjdGYgb3IgTFRUTkcgdG8gYW5k
cm9pZCB0aGUKPiBwbGF0Zm9ybT8KPgo+IC0tCj4gRWJlbGVjaHVrd3UgTndhZm9yLAo+IEdyYWR1
YXRlIFN0dWRlbnQsCj4gSG93YXJkIFVuaXZlcnNpdHkuCj4KPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBs
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1
CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

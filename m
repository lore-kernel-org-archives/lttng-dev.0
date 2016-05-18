From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: unchecked return value in
	relayd live.c
Date: Wed, 18 May 2016 15:24:05 -0400
Message-ID: <CA+jJMxuSYrb=rME5z8GBrjKqcNWh4JHVgkYV1C5izne+OAcxjg__6533.36607288129$1463599461$gmane$org@mail.gmail.com>
References: <1463501593-5871-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f65.google.com (mail-qg0-f65.google.com
 [209.85.192.65])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 65338A35B4
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 19:24:06 +0000 (UTC)
Received: by mail-qg0-f65.google.com with SMTP id z70so159118qge.3
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 12:24:06 -0700 (PDT)
In-Reply-To: <1463501593-5871-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFR1ZSwgTWF5IDE3LCAyMDE2IGF0IDEyOjEz
IFBNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3
cm90ZToKPiBDSUQgMTMyMzEzNyAoIzEgb2YgMSk6IFVuY2hlY2tlZCByZXR1cm4gdmFsdWUgKENI
RUNLRURfUkVUVVJOKTMwLgo+IGNoZWNrX3JldHVybjogQ2FsbGluZyB2aWV3ZXJfc3RyZWFtX2dl
dCB3aXRob3V0IGNoZWNraW5nIHJldHVybiB2YWx1ZQo+IChhcyBpcyBkb25lIGVsc2V3aGVyZSA1
IG91dCBvZiA2IHRpbWVzKS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctcmVs
YXlkL2xpdmUuYyB8IDUgKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUu
YyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYwo+IGluZGV4IDgyYmQyYmQuLjBhNjY0MDUg
MTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jCj4gKysrIGIvc3JjL2Jp
bi9sdHRuZy1yZWxheWQvbGl2ZS5jCj4gQEAgLTMzOSw3ICszMzksMTAgQEAgaW50IG1ha2Vfdmll
d2VyX3N0cmVhbXMoc3RydWN0IHJlbGF5X3Nlc3Npb24gKnNlc3Npb24sCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKiBFbnN1cmUgYSBzZWxmLXJlZmVyZW5jZSBpcyBwcmVzZXJ2
ZWQgZXZlbgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogYWZ0ZXIgd2UgaGF2
ZSBwdXQgb3VyIGxvY2FsIHJlZmVyZW5jZS4KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAqLwo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlld2VyX3N0cmVhbV9n
ZXQodnN0cmVhbSk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXZpZXdl
cl9zdHJlYW1fZ2V0KHZzdHJlYW0pKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEVSUigiVW5hYmxlIHRvIGdldCBzZWxmLXJlZmVyZW5jZSBvbiB2aWV3ZXIgc3Ry
ZWFtLCBsb2dpYyBlcnJvci4iKTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYWJvcnQoKTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKCF2c3RyZWFtLT5zZW50X2ZsYWcgJiYgbmJfdW5zZW50KSB7Cj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIFVwZGF0ZSBudW1iZXIgb2YgdW5zZW50
IHN0cmVhbSBjb3VudGVyLiAqLwo+IC0tCj4gMi4xLjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFy
bmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==

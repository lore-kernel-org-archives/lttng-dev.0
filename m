From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/3] Fix: relayd: make viewer
 streams consider metadata sent
Date: Sat, 5 Sep 2015 12:13:20 -0400
Message-ID: <CA+jJMxuDN0OY-SNkcrbn__D0yVsNXUhW2kki5AwR6yTJmBUsHg__40746.610883116$1441469668$gmane$org@mail.gmail.com>
References: <1441315050-17271-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZYG5m-0002gl-3x
 for lttng-dev@lists.lttng.org; Sat, 05 Sep 2015 12:13:28 -0400
Received: by ykek143 with SMTP id k143so47153486yke.2
 for <lttng-dev@lists.lttng.org>; Sat, 05 Sep 2015 09:13:20 -0700 (PDT)
In-Reply-To: <1441315050-17271-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFRodSwgU2VwIDMsIDIwMTUgYXQgNToxNyBQ
TSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3Jv
dGU6Cj4gVGhlIG1ldGFkYXRhIHN0cmVhbSBkb2VzIG5vdCB1c2UgcHJldiBzZXEsIGFuZCBpcyB0
aGVyZWZvcmUgbm90IHNlbnQgdG8KPiB2aWV3ZXJzIGlmIHdlIGRlcGVuZCBvbiBwcmV2IHNlcS4g
VXNlIHRoZSBtZXRhZGF0YV9yZWNlaXZlZCBmaWVsZAo+IGluc3RlYWQgdG8gYWNoaWV2ZSB0aGUg
c2FtZSBwdXJwb3NlOiBpZiBhIHZpZXdlciB0cnkgdG8gYXR0YWNoIHRvIGEKPiBzZXNzaW9uIHRo
YXQgaGFzIG5vdCByZWNlaXZlZCBtZXRhZGF0YSB5ZXQsIGl0IHdpbGwgZ2V0IGFuZCBlcnJvcgo+
IChtZXRhZGF0YSBzdHJlYW0gY2Fubm90IGJlIGZvdW5kIHdoZW4gYXR0YWNoaW5nKS4KPgo+IFNp
Z25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lv
cy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYyB8IDEwICsrKysrKysr
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXJlbGF5ZC9saXZlLmMgYi9zcmMvYmluL2x0dG5n
LXJlbGF5ZC9saXZlLmMKPiBpbmRleCA0NTg2ZTliLi4yZDBiNjg3IDEwMDY0NAo+IC0tLSBhL3Ny
Yy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xp
dmUuYwo+IEBAIC0zMTYsOCArMzE2LDE0IEBAIGludCBtYWtlX3ZpZXdlcl9zdHJlYW1zKHN0cnVj
dCByZWxheV9zZXNzaW9uICpzZXNzaW9uLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICogU3RyZWFtIGhhcyBubyBkYXRhLCBkb24ndCBjb25z
aWRlciBpdCB5ZXQuCj4gICAgICAgICAgICAgICAgICAgICAgICAgICovCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKHN0cmVhbS0+cHJldl9zZXEgPT0gLTFVTEwpIHsKPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gbmV4dDsKPiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoc3RyZWFtLT5pc19tZXRhZGF0YSkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKCFzdHJlYW0tPm1ldGFkYXRhX3JlY2VpdmVkKSB7Cj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gbmV4dDsKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHN0cmVhbS0+cHJldl9zZXEgPT0gLTFVTEwp
IHsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBuZXh0Owo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIH0KPiAgICAgICAgICAgICAgICAgICAgICAgICB2c3RyZWFtID0gdmlld2VyX3N0cmVhbV9n
ZXRfYnlfaWQoc3RyZWFtLT5zdHJlYW1faGFuZGxlKTsKPiAgICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoIXZzdHJlYW0pIHsKPiAtLQo+IDIuMS40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5l
YXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=

From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.10.4 - KeKriek
Date: Mon, 30 Apr 2018 15:56:42 -0400
Message-ID: <20180430195641.GB16908__27590.1909255937$1525118093$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 by lists.lttng.org (Postfix) with ESMTPS id 40Zb0G3zrPz1817
 for <lttng-dev@lists.lttng.org>; Mon, 30 Apr 2018 15:56:46 -0400 (EDT)
Received: by mail-qk0-x241.google.com with SMTP id x22so7507190qkb.12
 for <lttng-dev@lists.lttng.org>; Mon, 30 Apr 2018 12:56:46 -0700 (PDT)
Received: from gmail.com (192-222-157-41.qc.cable.ebox.net. [192.222.157.41])
 by smtp.gmail.com with ESMTPSA id
 z55-v6sm8904507qth.11.2018.04.30.12.56.43
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 30 Apr 2018 12:56:44 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKVGhlIGZvdXJ0aCBidWctZml4IHJlbGVhc2Ugb2YgTFRUbmctVG9vbHMgMi4xMCAt
IEtlS3JpZWsgaGFzIGp1c3QgYmVlbgpyZWxlYXNlZC4gVGhpcyByZWxlYXNlIGFkZHJlc3NlcyBh
IG51bWJlciBvZiBpc3N1ZXMgbGlzdGVkIGJlbG93LgoKMjAxOC0wNC0zMCBsdHRuZy10b29scyAy
LjEwLjQgKENFUk4gYW5ub3VuY2VzIFdXVyBwcm90b2NvbHMgd2lsbCBiZSBmcmVlKQogICAgICAg
ICogRml4IGJ1aWxkOiBpbl9naXRfcmVwbyBpcyB1c2VkIGJlZm9yZSBiZWluZyBzZXQKICAgICAg
ICAqIEFkZCBEQkcgc3RhdGVtZW50IGZvciBUQ1Aga2VlcC1hbGl2ZSBvcHRpb25zCiAgICAgICAg
KiBGaXg6IHVucHJpdmlsaWVnZWQgc2Vzc2lvbmQgYWdlbnQgcG9ydCBjbGFzaGVzIHdpdGggcm9v
dCBzZXNzaW9uZAogICAgICAgICogRml4OiBlcnJvbmVvdXMgdXNlIG9mIGV4dGVybiBrZXl3b3Jk
CiAgICAgICAgKiBGaXg6IGZhaWx1cmUgdG8gbGF1bmNoIGFnZW50IHRocmVhZCBpcyBub3QgcmVw
b3J0ZWQKICAgICAgICAqIEZpeDogYWdlbnQgbWF5IG5vdCBiZSByZWFkeSBvbiBsYXVuY2gKICAg
ICAgICAqIEZpeDogY2hlY2tpbmcgZm9yIGV4aXN0aW5nIHNlc3Npb24gZGFlbW9uIGlzIGRvbmUg
YWZ0ZXIgZGFlbW9uaXppbmcKICAgICAgICAqIEZpeDogbHR0bmcgbG9ncyBuYW5vc2Vjb25kcwog
ICAgICAgICogRml4OiBzdHJlYW1fcGVyX2NoYW5faWRfaHQgc2hvdWxkIGFsbG93IGR1cGxpY2F0
ZXMKICAgICAgICAqIEZpeDogcmVsYXlkIHNlbmRfY29tbWFuZCgpIHV0aWwgbm90IGxvZ2dpbmcg
b24gZmFpbHVyZQogICAgICAgICogRml4OiBjcmVhdGVfb3V0cHV0X3BhdGgoKSByZWxheWQgdXRp
bCBpcyBub3QgY29uc3QtY29ycmVjdAogICAgICAgICogRml4OiBrZXJuZWwgc25hcHNob3QgaGFu
ZGxpbmcgb2YgRUFHQUlOCiAgICAgICAgKiBGaXggdmFsaWRhdGVfdHJhY2VfZW1wdHkgdGVzdCBj
aGVjawogICAgICAgICogRml4OiBjaXJjdWxhciBpbmNsdXNpb24gb2YgbHR0bmcuaCByZXN1bHRz
IGluIHdhcm5pbmcKICAgICAgICAqIEZpeDogY2hhbm5lbCBsb2NrIG11c3QgYmUgdGFrZW4gdG8g
Y2hlY2sgZm9yIHBlbmRpbmcgbm90aWZpY2F0aW9ucwogICAgICAgICogRml4OiBxdWlldCBvcHRp
b24gaXMgbm90IHNldCBpbiBzZXNzaW9uZC1jb25maWcKICAgICAgICAqIEZpeDogaG9sZCBjb25z
dW1lciBzb2NrZXQgbG9jayBmb3IgY29uc3VtZXJfc2VuZF9tc2cKICAgICAgICAqIEZpeDogdXNl
IG9mZl90IHR5cGUgZm9yIGxzZWVrIGZ1bmN0aW9uIHJldHVybiB2YWx1ZSB0byBhdm9pZCBvdmVy
ZmxvdwogICAgICAgICogRml4OiBkb3VibGUgc2ltaWxhciBjb25kaXRpb24KCkFzIGFsd2F5cywg
cGxlYXNlIHJlcG9ydCBhbnkgaXNzdWUgeW91IG1heSBlbmNvdW50ZXIgdG8gYnVncy5sdHRuZy5v
cmcKb3Igb24gdGhpcyBtYWlsaW5nIGxpc3QuCgpQcm9qZWN0IHdlYnNpdGU6IGh0dHBzOi8vbHR0
bmcub3JnCgpEb3dubG9hZCBsaW5rOgpodHRwczovL2x0dG5nLm9yZy9maWxlcy9sdHRuZy10b29s
cy9sdHRuZy10b29scy0yLjEwLjQudGFyLmJ6MgoKR1BHIHNpZzoKaHR0cHM6Ly9sdHRuZy5vcmcv
ZmlsZXMvbHR0bmctdG9vbHMvbHR0bmctdG9vbHMtMi4xMC40LnRhci5iejIuYXNjCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==

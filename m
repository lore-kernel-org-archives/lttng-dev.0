From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: 'lttng create' does not create the session directory
Date: Mon, 6 Jun 2016 11:48:53 -0400
Message-ID: <57559B65.5080306__43216.8390755125$1465228076$gmane$org@gydle.com>
References: <575593B9.8040107@gydle.com>
 <CAE_Gge0gEFG9LKU2ZA1Gmr01XMvuO5ec3hJENqvF1p0uP4F5hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 81E8CA36D0
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jun 2016 15:47:39 +0000 (UTC)
In-Reply-To: <CAE_Gge0gEFG9LKU2ZA1Gmr01XMvuO5ec3hJENqvF1p0uP4F5hQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?Q?Rapha=c3=abl_Beamonte?= <raphael.beamonte@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

CgpPbiAwNi8wNi8yMDE2IDExOjMzIEFNLCBSYXBoYcOrbCBCZWFtb250ZSB3cm90ZToKPiAyMDE2
LTA2LTA2IDExOjE2IEdNVC0wNDowMCBTZWJhc3RpZW4gQm9pc3ZlcnQgPHNib2lzdmVydEBneWRs
ZS5jb20+Ogo+PiBIaSwKPj4KPj4gSSBhbSB1c2luZyBMVFRuZyB0byB0cmFjZSBhbiBhbGlnbmVy
IG9mIEROQSBvcHRpY2FsIGFzc2V0cyB0aGF0IHdlIGFyZQo+PiBkZXZlbG9waW5nIGF0IEd5ZGxl
IEluYy4gTFRUbmcgaXMgdmVyeSB1c2VmdWwuCj4+Cj4+IEkgaW5zdGFsbGVkIGl0IHdpdGggdGhl
IFBQQSAoImRlYiBodHRwOi8vcHBhLmxhdW5jaHBhZC5uZXQvbHR0bmcvcHBhL3VidW50dSIpLgo+
Pgo+PiBJIGRvbid0IGtub3cgd2hhdCBoYXMgY2hhbmdlZCBpbiBteSBzZXR1cCwgYnV0IHNpbmNl
IHRoaXMgbW9ybmluZyBsdHRuZyBpcyBub3QKPj4gY3JlYXRpbmcgc2Vzc2lvbiBkaXJlY3Rvcmll
cy4KPj4KPj4KPj4gWjEkIGx0dG5nIC0tdmVyc2lvbgo+PiBsdHRuZyAoTFRUbmcgVHJhY2UgQ29u
dHJvbCkgMi43LjMgLSBIZXJiZSDDoCBEw6l0b3VybmUKPj4KPj4gWjEkIGx0dG5nIGNyZWF0ZQo+
PiBTZXNzaW9uIGF1dG8tMjAxNjA2MDYtMTAxOTUzIGNyZWF0ZWQuCj4+IFRyYWNlcyB3aWxsIGJl
IHdyaXR0ZW4gaW4gL2hvbWUvc2JvaXN2ZXJ0L2x0dG5nLXRyYWNlcy9hdXRvLTIwMTYwNjA2LTEw
MTk1Mwo+Pgo+PiBaMSQgbHMgL2hvbWUvc2JvaXN2ZXJ0L2x0dG5nLXRyYWNlcy9hdXRvLTIwMTYw
NjA2LTEwMTk1Mwo+PiBsczogY2Fubm90IGFjY2VzcyAvaG9tZS9zYm9pc3ZlcnQvbHR0bmctdHJh
Y2VzL2F1dG8tMjAxNjA2MDYtMTAxOTUzOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5Cj4+Cj4+
Cj4+IEkgaGF2ZSBlbm91Z2ggZGlzayBzcGFjZS4KPj4KPj4gSSBhbSBub3Qgc3VyZSB3aGF0IGlz
IGNhdXNpbmcgdGhpcy4KPiAKPiBIaSBTZWJhc3RpZW4sCj4gCj4gSWYgSSdtIG5vdCBtaXN0YWtl
biwgbHR0bmcgd2lsbCBvbmx5IGNyZWF0ZSB0aGUgZGlyZWN0b3J5IGlmIHRoZXJlIGlzCj4gZGF0
YSB0byB3cml0ZS4gVHJ5IGFkZGluZyBrZXJuZWwgZXZlbnRzIGFuZCBzdGFydCB0aGUgdHJhY2lu
ZywgeW91J2xsCj4gaGF2ZSB0aGUgZGlyZWN0b3J5Lgo+IAoKVGhhbmtzLgoKSSBkaWQgbm90IGtu
b3cgdGhhdC4KCgoKPiBSYXBoYcOrbAo+IAo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+PiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4+IGx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKPj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=

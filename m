From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [lttng-tools PATCH 0/2] utils_expand_path as
	realpath(3) for non-existing directories
Date: Thu,  7 Nov 2013 23:32:12 -0500
Message-ID: <1383885134-21397-1-git-send-email-raphael.beamonte__26543.2658409283$1383885206$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1VedkS-0000tI-2I
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 23:32:45 -0500
Received: by mail-ie0-f174.google.com with SMTP id qd12so2426418ieb.19
	for <lttng-dev@lists.lttng.org>; Thu, 07 Nov 2013 20:32:38 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

VGhlIHV0aWxzX2V4cGFuZF9wYXRoIGZ1bmN0aW9uIG9mIGx0dG5nLXRvb2xzLCBpbiBzcmMvY29t
bW9uL3V0aWxzLmMsCndhcyBtZWFudCB0byByZXBsYWNlIHRoZSByZWFscGF0aCgzKSBmdW5jdGlv
biBvZiBnbGliYyBpbiBjYXNlcyB3ZQp3YW50IHRvIGFsbG93IG5vbi1leGlzdGluZyBwYXRocywg
c3VjaCBhcyBzcGVjaWZ5aW5nIHRoZSBvdXRwdXQgZGlyZWN0b3J5CmZvciBhIHRyYWNlLgpXaGls
ZSB1c2luZyB0aGUgbHR0bmctdG9vbHMgY29tbWFuZCBsaW5lIHRvIGNyZWF0ZSBzb21lIHRyYWNl
cywgSSBmb3VuZApvdXQgdGhhdCBzb21lIHVzZSBjYXNlcyB3ZXJlbid0IHdvcmtpbmcuIEZvciBp
bnN0YW5jZSwgdXNpbmcgcGF0aHMgbGlrZQoiZm9vIiwgImJhci8iIG9yICJiYXIvZm9vIiB3aGVu
IHRoZSAiYmFyIiBkaXJlY3RvcnkgZG9lcyBub3QgZXhpc3Qgd2FzCm5vdCB3b3JraW5nLgoKVGhp
cyBzZXJpZXMgb2YgdHdvICgyKSBwYXRjaGVzIGFpbXMgdG8gY29ycmVjdCB0aGUgYmVoYXZpb3Ig
b2YgdGhlCnV0aWxzX2V4cGFuZF9wYXRoIGZ1bmN0aW9uLCBpbnRyb2R1Y2luZyBhIG5ldyB1dGls
c19yZXNvbHZlX3JlbGF0aXZlCmZ1bmN0aW9uIG1lYW50IHRvIHJlc29sdmUgcmVsYXRpdmUgcGF0
aHMgKCIuLyIgYW5kICIuLi8iKSBpbiB0aGUgbWlkZGxlCm9mIGEgcGF0aCBzdHJpbmcuCgoKUmFw
aGHDq2wgQmVhbW9udGUgKDIpOgogIEludHJvZHVjZSBhIG5ldyB1dGlsc19yZXNvbHZlX3JlbGF0
aXZlIGZ1bmN0aW9uCiAgQ29ycmVjdCB0aGUgYmVoYXZpb3Igb2YgdGhlIHV0aWxzX2V4cGFuZF9w
YXRoIGZ1bmN0aW9uCgogc3JjL2NvbW1vbi91dGlscy5jIHwgIDEyMCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCiBzcmMvY29tbW9uL3V0aWxzLmgg
fCAgICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMTAwIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9u
cygtKQoKLS0gCjEuNy4xMC40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=

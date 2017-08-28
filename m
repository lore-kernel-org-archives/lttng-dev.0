From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix test: OOT build of
	test_trace_copy and test_trimmer
Date: Mon, 28 Aug 2017 12:12:08 -0400
Message-ID: <1503936728-12827-1-git-send-email-mjeanson__10704.4530254372$1503936765$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xgxcX3hP0zfGR
 for <lttng-dev@lists.lttng.org>; Mon, 28 Aug 2017 16:12:27 +0000 (UTC)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogdGVzdHMvY2xpL3Rlc3RfdHJhY2VfY29weS5pbiB8IDIgKy0KIHRlc3RzL2NsaS90ZXN0X3Ry
aW1tZXIuaW4gICAgfCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9jbGkvdGVzdF90cmFjZV9jb3B5LmluIGIv
dGVzdHMvY2xpL3Rlc3RfdHJhY2VfY29weS5pbgppbmRleCA1ZDFlN2I0Li4zNmUyNzE4IDEwMDY0
NAotLS0gYS90ZXN0cy9jbGkvdGVzdF90cmFjZV9jb3B5LmluCisrKyBiL3Rlc3RzL2NsaS90ZXN0
X3RyYWNlX2NvcHkuaW4KQEAgLTE1LDcgKzE1LDcgQEAKICMgdGhpcyBwcm9ncmFtOyBpZiBub3Qs
IHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4sIDUxCiAjIEZyYW5r
bGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0EuCiAKLS4g
IkBhYnNfdG9wX3NyY2RpckAvdGVzdHMvdXRpbHMvY29tbW9uLnNoIgorLiAiQGFic190b3BfYnVp
bGRkaXJAL3Rlc3RzL3V0aWxzL2NvbW1vbi5zaCIKIAogY2xlYW5fdG1wKCkgewogCXJtIC1yZiAi
JHtvdXRfcGF0aH0iICIke3RleHRfb3V0cHV0MX0iICIke3RleHRfb3V0cHV0Mn0iCmRpZmYgLS1n
aXQgYS90ZXN0cy9jbGkvdGVzdF90cmltbWVyLmluIGIvdGVzdHMvY2xpL3Rlc3RfdHJpbW1lci5p
bgppbmRleCA5MzAzY2RmLi41YTY4N2M2IDEwMDY0NAotLS0gYS90ZXN0cy9jbGkvdGVzdF90cmlt
bWVyLmluCisrKyBiL3Rlc3RzL2NsaS90ZXN0X3RyaW1tZXIuaW4KQEAgLTE1LDcgKzE1LDcgQEAK
ICMgdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5k
YXRpb24sIEluYy4sIDUxCiAjIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3Rvbiwg
TUEgMDIxMTAtMTMwMSBVU0EuCiAKLS4gIkBhYnNfdG9wX3NyY2RpckAvdGVzdHMvdXRpbHMvY29t
bW9uLnNoIgorLiAiQGFic190b3BfYnVpbGRkaXJAL3Rlc3RzL3V0aWxzL2NvbW1vbi5zaCIKIAog
VFJBQ0VfUEFUSD0iJHtCVF9DVEZfVFJBQ0VTfS9zdWNjZWVkL3drLWhlYXJ0YmVhdC11LyIKIAot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==

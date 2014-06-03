From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [lttng-tools PATCH] Fix: remove the default GIT_VERSION
	define to allow different version control
Date: Tue,  3 Jun 2014 14:30:09 -0400
Message-ID: <b857bc6a10d6b74a31f80a3c26d6f43cbc22b955.1401819810.git.raphael.beamonte__11190.6114071191$1401820392$gmane$org@gmail.com>
References: <538E1204.6080304@voxpopuli.im>
 <cover.1401819810.git.raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <raphael.beamonte@gmail.com>) id 1WrtTb-0001EC-5y
 for lttng-dev@lists.lttng.org; Tue, 03 Jun 2014 14:30:28 -0400
Received: by mail-ig0-f176.google.com with SMTP id a13so966918igq.9
 for <lttng-dev@lists.lttng.org>; Tue, 03 Jun 2014 11:30:17 -0700 (PDT)
In-Reply-To: <cover.1401819810.git.raphael.beamonte@gmail.com>
In-Reply-To: <cover.1401819810.git.raphael.beamonte@gmail.com>
References: <cover.1401819810.git.raphael.beamonte@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogUmFwaGHDq2wgQmVhbW9udGUgPHJhcGhhZWwuYmVhbW9udGVAZ21haWwu
Y29tPgotLS0KIGluY2x1ZGUvdmVyc2lvbi5oLnRtcGwgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3Zl
cnNpb24uaC50bXBsIGIvaW5jbHVkZS92ZXJzaW9uLmgudG1wbAppbmRleCA2MzllNmQ3Li4yY2Fi
NzMzIDEwMDY0NAotLS0gYS9pbmNsdWRlL3ZlcnNpb24uaC50bXBsCisrKyBiL2luY2x1ZGUvdmVy
c2lvbi5oLnRtcGwKQEAgLTIwLDE1ICsyMCwxMyBAQAogI2lmbmRlZiBWRVJTSU9OX0gKICNkZWZp
bmUgVkVSU0lPTl9ICiAKLSNkZWZpbmUgR0lUX1ZFUlNJT04KLQogLyoKICAqIERlZmluZSB0aGUg
bWFjcm8gY29udGFpbmluZyB0aGUgRlVMTCB2ZXJzaW9uCiAgKi8KICNpZmRlZiBHSVRfVkVSU0lP
TgogI2RlZmluZSBGVUxMX1ZFUlNJT04gIiIgR0lUX1ZFUlNJT04KICNlbHNlIC8qIEdJVF9WRVJT
SU9OICovCi0jZGVmaW5lIEZVTExfVkVSU0lPTiAidiIgVkVSU0lPTgorI2RlZmluZSBGVUxMX1ZF
UlNJT04gIiIgVkVSU0lPTgogI2VuZGlmIC8qIEdJVF9WRVJTSU9OICovCiAKICNlbmRpZiAvKiBW
RVJTSU9OX0ggKi8KLS0gCjIuMC4wLnJjMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK

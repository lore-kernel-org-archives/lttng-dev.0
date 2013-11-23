From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [lttng-tools PATCH 5/5] Tests: add valid test cases to
	test_utils_expand_path
Date: Sat, 23 Nov 2013 17:32:28 -0500
Message-ID: <1385245948-23011-6-git-send-email-raphael.beamonte__13936.7561940619$1385246338$gmane$org@gmail.com>
References: <20131115154539.GA6986@thessa>
	<1385245948-23011-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1VkLkt-0004vh-UX
	for lttng-dev@lists.lttng.org; Sat, 23 Nov 2013 17:32:56 -0500
Received: by mail-ie0-f175.google.com with SMTP id x13so4400083ief.6
	for <lttng-dev@lists.lttng.org>; Sat, 23 Nov 2013 14:32:42 -0800 (PST)
In-Reply-To: <1385245948-23011-1-git-send-email-raphael.beamonte@gmail.com>
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

U2lnbmVkLW9mZi1ieTogUmFwaGHDq2wgQmVhbW9udGUgPHJhcGhhZWwuYmVhbW9udGVAZ21haWwu
Y29tPgotLS0KIHRlc3RzL3VuaXQvdGVzdF91dGlsc19leHBhbmRfcGF0aC5jIHwgICAgMiArKwog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3VuaXQv
dGVzdF91dGlsc19leHBhbmRfcGF0aC5jIGIvdGVzdHMvdW5pdC90ZXN0X3V0aWxzX2V4cGFuZF9w
YXRoLmMKaW5kZXggNmI4MDliOC4uNjU1ODJmZiAxMDA2NDQKLS0tIGEvdGVzdHMvdW5pdC90ZXN0
X3V0aWxzX2V4cGFuZF9wYXRoLmMKKysrIGIvdGVzdHMvdW5pdC90ZXN0X3V0aWxzX2V4cGFuZF9w
YXRoLmMKQEAgLTcwLDYgKzcwLDggQEAgc3RhdGljIHN0cnVjdCB2YWxpZF90ZXN0X2lucHV0IHZh
bGlkX3Rlc3RzX2lucHV0c1tdID0gewogCXsgIi4iLAkJCQkiLiIsCQkiIgkJfSwKIAl7ICIvLi4v
YS9iL2MvZC9lIiwJCSIiLAkJIi9hL2IvYy9kL2UiCX0sCiAJeyAiL2EvYi9jL2QvLi4vLi4vLi4v
Li4vLi4vZSIsCSIiLAkJIi9lIgkJfSwKKwl7ICIvLi4iLAkJCSIiLAkJIi8iCQl9LAorCXsgIi9h
Ly4uIiwJCQkiIiwJCSIvIgkJfSwKIH07CiBjaGFyICoqdmFsaWRfdGVzdHNfZXhwZWN0ZWRfcmVz
dWx0czsKIHN0YXRpYyBjb25zdCBpbnQgbnVtX3ZhbGlkX3Rlc3RzID0KLS0gCjEuNy4xMC40CgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=

From: Yuxin Ren <ryx@gwmail.gwu.edu>
Subject: Question about lock in synchronize_rcu implementation
	of URCU
Date: Wed, 27 Apr 2016 21:34:16 -0400
Message-ID: <CAAKbDrfmcqEE7_6p_J0DPVO85yDGJ0GCbi5k9Lm19g4VaLgOWw__38134.9317649894$1461807279$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f52.google.com (mail-lf0-f52.google.com
 [209.85.215.52])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id B7A4FA3255
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 01:34:17 +0000 (UTC)
Received: by mail-lf0-f52.google.com with SMTP id j11so77564255lfb.1
 for <lttng-dev@lists.lttng.org>; Wed, 27 Apr 2016 18:34:17 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

SGksCgpJIGFtIGxlYXJuaW5nIHRoZSBVUkNVIGNvZGUuCgpXaHkgZG8gd2UgbmVlZCByY3VfZ3Bf
bG9jayBpbiBzeW5jaHJvbml6ZV9yY3U/Cmh0dHBzOi8vZ2l0aHViLmNvbS91cmN1L3VzZXJzcGFj
ZS1yY3UvYmxvYi9tYXN0ZXIvdXJjdS5jI0w0MDEKCkluIHRoZSBjb21tZW50LCBpdCBzYXlzIHRo
aXMgbG9jayBlbnN1cmVzIG11dHVhbCBleGNsdXNpb24gYmV0d2Vlbgp0aHJlYWRzIGNhbGxpbmcg
c3luY2hyb25pemVfcmN1KCkuCkJ1dCBvbmx5IHRoZSBmaXJzdCB0aHJlYWQgYWRkZWQgdG8gd2Fp
dGVyIHF1ZXVlIGNhbiBwcm9jZWVkIHRvIGRldGVjdApncmFjZSBwZXJpb2QuCkhvdyBjYW4gbXVs
dGlwbGUgdGhyZWFkcyBjdXJyZW50bHkgcGVyZm9ybSB0aGUgZ3JhY2UgdGhyZWFkPwoKVGhhbmtz
IGEgbG90IQpZdXhpbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=

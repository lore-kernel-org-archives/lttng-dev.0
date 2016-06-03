From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [lttng-ust RFC PATCH v2 0/1] Identify UST threads by
	changing thread names
Date: Fri,  3 Jun 2016 11:16:59 -0400
Message-ID: <cover.1464966729.git.raphael.beamonte__35385.8027061962$1464967063$gmane$org@gmail.com>
References: <cover.1461269886.git.raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f66.google.com (mail-qg0-f66.google.com
 [209.85.192.66])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 4B7D2A3784
 for <lttng-dev@lists.lttng.org>; Fri,  3 Jun 2016 15:17:16 +0000 (UTC)
Received: by mail-qg0-f66.google.com with SMTP id k43so728550qgk.3
 for <lttng-dev@lists.lttng.org>; Fri, 03 Jun 2016 08:17:16 -0700 (PDT)
In-Reply-To: <cover.1461269886.git.raphael.beamonte@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
Cc: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
List-Id: lttng-dev@lists.lttng.org

SGksCgpUaGlzIGlzIHRoZSB1cGRhdGUgb2YgdGhlIFJGQyBwYXRjaCBmb2xsb3dpbmcgeW91ciBj
b21tZW50cy4KVGhpcyBwYXRjaCB1cGRhdGVzIHRoZSBwdGhyZWFkX3NldG5hbWVfbnAvcHRocmVh
ZF9zZXRfbmFtZV9ucCB2ZXJzaW9uIG9mCnRoZSBSRkMgcGF0Y2gsIGFuZCBpbmNsdWRlcyB0aGUg
Zm9sbG93aW5nIGNoYW5nZXM6Ci0gQ2hlY2sgaW4gY29uZmlndXJlLmFjIHdoZXRoZXIgdGhlIHB0
aHJlYWRfc2V0bmFtZV9ucCBvcgogIHB0aHJlYWRfc2V0X25hbWVfbnAgZnVuY3Rpb25zIGV4aXN0
cy4gSWYgaXQncyBub3QgdGhlIGNhc2UsCiAgY3VycmVudCBiZWhhdmlvciBpcyBwcmVzZXJ2ZWQu
Ci0gVXBkYXRlIGNvbXBhdC5oIHRvIGRlZmluZSBhIG1hY3JvIGZvciB0aGUgcHRocmVhZF9zZXQq
bmFtZV9ucAogIGZ1bmN0aW9uIHRvIHVzZSBpbiBvcmRlciB0byByZWR1Y2UgcmVwZWF0ZWQgY29k
ZS4KLSBVcGRhdGUgY29tcGF0LmggYW5kIGx0dG5nLXVzdC1jb21tLmMgdG8gdXNlIGEgbWFjcm8g
dG8gY2FsbCB0aGUKICBsdHRuZ191c3Rfc2V0dXN0cHJvY25hbWUgZnVuY3Rpb24gaW4gb3JkZXIg
Zm9yIHRoYXQgbWFjcm8gdG8gYmUKICBlbXB0eSB3aGVuIHRoZSByZXF1aXJlZCBwdGhyZWFkX3Nl
dG4qYW1lX25wIGlzIG5vdCBhdmFpbGFibGUuCi0gVXBkYXRlIGNvbXBhdC5oIHRvIGZpeCBzcHJp
bnRmIHVzYWdlIHdpdGggdGhlIHNhbWUgdmFyaWFibGUgdG8KICByZWFkIGZyb20gYW5kIHdyaXRl
IHRvLgotIFRoZSBwYXRjaCBoYXMgYmVlbiByZWJhc2VkIG9uIGN1cnJlbnQgbHR0bmctdXN0J3Mg
bWFzdGVyIGJyYW5jaC4KClRoaXMgcGF0Y2ggc3RpbGwgY29udGFpbnMgdGhlIGxpbmsgdG8gdGhl
IHB0aHJlYWQgbGlicmFyeSBpbiB0aGUKbGlibHR0bmctdXN0L01ha2VmaWxlLmFtIGZpbGUsIHdo
aWNoIHN0aWxsIHNlZW1zIHJlcXVpcmVkIHRvIGF2b2lkCmNvbXBpbGF0aW9uIHdhcm5pbmdzIGFi
b3V0IGltcGxpY2l0IGZ1bmN0aW9uIGRlY2xhcmF0aW9uLgoKVGhvdWdodHMgYW5kIGNvbW1lbnRz
PwoKVGhhbmtzIQpSYXBoYcOrbAoKClJhcGhhw6tsIEJlYW1vbnRlICgxKToKICBBZGQgLXVzdCB0
byB0aGUgbmFtZSBvZiBVU1QgdGhyZWFkcyBvZiB0aGUgYXBwbGljYXRpb24KCiBjb25maWd1cmUu
YWMgICAgICAgICAgICAgICAgICB8ICA1ICsrKysrCiBsaWJsdHRuZy11c3QvTWFrZWZpbGUuYW0g
ICAgICB8ICAxICsKIGxpYmx0dG5nLXVzdC9jb21wYXQuaCAgICAgICAgIHwgNDggKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogbGlibHR0bmctdXN0L2x0dG5nLXVz
dC1jb21tLmMgfCAgNiArKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKLS0gCjIuOC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=

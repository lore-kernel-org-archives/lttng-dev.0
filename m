From: <rongqing.li@windriver.com>
Subject: [PATCH] Fixed alignment problems on targets not
	supporting unaligned access.
Date: Thu, 15 May 2014 16:50:49 +0800
Message-ID: <1400143849-17275-1-git-send-email-rongqing.li__22883.8371149779$1400160497$gmane$org@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.windriver.com ([147.11.146.13])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Rongqing.Li@windriver.com>) id 1WkrNR-0008U1-48
 for lttng-dev@lists.lttng.org; Thu, 15 May 2014 04:51:04 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s4F8oo35027249
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
 for <lttng-dev@lists.lttng.org>; Thu, 15 May 2014 01:50:50 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

RnJvbTogRnJlZHJpayBNYXJrc3Ryw7ZtIDxmcmVkcmlrLm1hcmtzdHJvbUBnbWFpbC5jb20+CgpB
Y2Nlc3NpbmcgZmxvYXRzLCBkb3VibGVzIGFuZCA2NCBiaXQgaW50IGF0IHVuYWxpZ24gYWRkcmVz
c2VzIGlzIG5vdApzdXBwb3J0ZWQgb24gYWxsIGNvbmZpZ3VyYXRpb25zIG9mIGFybSBwcm9jZXNz
b3JzIGFuZCBpZiBpdCBpcyBpdCdzCmVtdWFsdGVkIGFuZCBzbG93LiBUaGlzIHBhdGNoIHJlcGxh
Y2VzIGRpcmVjdCBhc3NpZ25tZW50cyB3aXRoIG1lbWNweS4KClNpZ25lZC1vZmYtYnk6IEZyZWRy
aWsgTWFya3N0cuaemm0gPGZyZWRyaWsubWFya3N0cm9tQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1i
eTogTGkgUm9uZ1FpbmcgPHJvbmdxaW5nLmxpQHdpbmRyaXZlci5jb20+Ci0tLQogc3JjL2xpYi9s
dHRuZy1jdGwvZmlsdGVyL2ZpbHRlci12aXNpdG9yLWdlbmVyYXRlLWJ5dGVjb2RlLmMgfCAgICA0
ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvc3JjL2xpYi9sdHRuZy1jdGwvZmlsdGVyL2ZpbHRlci12aXNpdG9yLWdlbmVy
YXRlLWJ5dGVjb2RlLmMgYi9zcmMvbGliL2x0dG5nLWN0bC9maWx0ZXIvZmlsdGVyLXZpc2l0b3It
Z2VuZXJhdGUtYnl0ZWNvZGUuYwppbmRleCA3NjJkNjA0Li44YzZkYzk2IDEwMDY0NAotLS0gYS9z
cmMvbGliL2x0dG5nLWN0bC9maWx0ZXIvZmlsdGVyLXZpc2l0b3ItZ2VuZXJhdGUtYnl0ZWNvZGUu
YworKysgYi9zcmMvbGliL2x0dG5nLWN0bC9maWx0ZXIvZmlsdGVyLXZpc2l0b3ItZ2VuZXJhdGUt
Ynl0ZWNvZGUuYwpAQCAtMjIyLDcgKzIyMiw3IEBAIGludCB2aXNpdF9ub2RlX2xvYWQoc3RydWN0
IGZpbHRlcl9wYXJzZXJfY3R4ICpjdHgsIHN0cnVjdCBpcl9vcCAqbm9kZSkKIAkJaWYgKCFpbnNu
KQogCQkJcmV0dXJuIC1FTk9NRU07CiAJCWluc24tPm9wID0gRklMVEVSX09QX0xPQURfUzY0Owot
CQkqKGludDY0X3QgKikgaW5zbi0+ZGF0YSA9IG5vZGUtPnUubG9hZC51Lm51bTsKKwkJbWVtY3B5
KGluc24tPmRhdGEsICZub2RlLT51LmxvYWQudS5udW0sIHNpemVvZihpbnQ2NF90KSk7CiAJCXJl
dCA9IGJ5dGVjb2RlX3B1c2goJmN0eC0+Ynl0ZWNvZGUsIGluc24sIDEsIGluc25fbGVuKTsKIAkJ
ZnJlZShpbnNuKTsKIAkJcmV0dXJuIHJldDsKQEAgLTIzNyw3ICsyMzcsNyBAQCBpbnQgdmlzaXRf
bm9kZV9sb2FkKHN0cnVjdCBmaWx0ZXJfcGFyc2VyX2N0eCAqY3R4LCBzdHJ1Y3QgaXJfb3AgKm5v
ZGUpCiAJCWlmICghaW5zbikKIAkJCXJldHVybiAtRU5PTUVNOwogCQlpbnNuLT5vcCA9IEZJTFRF
Ul9PUF9MT0FEX0RPVUJMRTsKLQkJKihkb3VibGUgKikgaW5zbi0+ZGF0YSA9IG5vZGUtPnUubG9h
ZC51LmZsdDsKKwkJbWVtY3B5KGluc24tPmRhdGEsICZub2RlLT51LmxvYWQudS5mbHQsIHNpemVv
Zihkb3VibGUpKTsKIAkJcmV0ID0gYnl0ZWNvZGVfcHVzaCgmY3R4LT5ieXRlY29kZSwgaW5zbiwg
MSwgaW5zbl9sZW4pOwogCQlmcmVlKGluc24pOwogCQlyZXR1cm4gcmV0OwotLSAKMS43LjEwLjQK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==

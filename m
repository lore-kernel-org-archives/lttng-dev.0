From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 22/24] Fix: illegal memory access in
	test_create_kernel_event
Date: Mon, 16 May 2016 21:43:01 -0400
Message-ID: <1463449383-6553-23-git-send-email-mathieu.desnoyers__48317.7678579979$1463449464$gmane$org@efficios.com>
References: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id ACE9EA3574
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 01:43:28 +0000 (UTC)
In-Reply-To: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Rm91bmQgYnkgQ292ZXJpdHk6CkNJRCAxMjQzMDMwICgjMSBvZiAxKTogQnVmZmVyIG5vdCBudWxs
IHRlcm1pbmF0ZWQgKEJVRkZFUl9TSVpFX1dBUk5JTkcpMS4KYnVmZmVyX3NpemVfd2FybmluZzog
Q2FsbGluZyBzdHJuY3B5IHdpdGggYSBtYXhpbXVtIHNpemUgYXJndW1lbnQgb2YgMjU2CmJ5dGVz
IG9uIGRlc3RpbmF0aW9uIGFycmF5IGV2Lm5hbWUgb2Ygc2l6ZSAyNTYgYnl0ZXMgbWlnaHQgbGVh
dmUgdGhlCmRlc3RpbmF0aW9uIHN0cmluZyB1bnRlcm1pbmF0ZWQuCgpTaWduZWQtb2ZmLWJ5OiBN
YXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgotLS0KIHRl
c3RzL3VuaXQvdGVzdF9rZXJuZWxfZGF0YS5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdW5pdC90
ZXN0X2tlcm5lbF9kYXRhLmMgYi90ZXN0cy91bml0L3Rlc3Rfa2VybmVsX2RhdGEuYwppbmRleCBm
MWUxYjM4Li5mZGU0NmY3IDEwMDY0NAotLS0gYS90ZXN0cy91bml0L3Rlc3Rfa2VybmVsX2RhdGEu
YworKysgYi90ZXN0cy91bml0L3Rlc3Rfa2VybmVsX2RhdGEuYwpAQCAtMzIsNyArMzIsNyBAQAog
I2RlZmluZSBSQU5ET01fU1RSSU5HX0xFTgkxMQogCiAvKiBOdW1iZXIgb2YgVEFQIHRlc3RzIGlu
IHRoaXMgZmlsZSAqLwotI2RlZmluZSBOVU1fVEVTVFMgMTAKKyNkZWZpbmUgTlVNX1RFU1RTIDEx
CiAKIC8qIEZvciBlcnJvci5oICovCiBpbnQgbHR0bmdfb3B0X3F1aWV0ID0gMTsKQEAgLTEzNCw3
ICsxMzQsOSBAQCBzdGF0aWMgdm9pZCB0ZXN0X2NyZWF0ZV9rZXJuZWxfZXZlbnQodm9pZCkKIAlz
dHJ1Y3QgbHR0bmdfZXZlbnQgZXY7CiAKIAltZW1zZXQoJmV2LCAwLCBzaXplb2YoZXYpKTsKLQlz
dHJuY3B5KGV2Lm5hbWUsIGdldF9yYW5kb21fc3RyaW5nKCksIExUVE5HX0tFUk5FTF9TWU1fTkFN
RV9MRU4pOworCW9rKGx0dG5nX3N0cm5jcHkoZXYubmFtZSwgZ2V0X3JhbmRvbV9zdHJpbmcoKSwK
KwkJCUxUVE5HX0tFUk5FTF9TWU1fTkFNRV9MRU4pLAorCQkiVmFsaWRhdGUgc3RyaW5nIGxlbmd0
aCIpOwogCWV2LnR5cGUgPSBMVFROR19FVkVOVF9UUkFDRVBPSU5UOwogCWV2LmxvZ2xldmVsX3R5
cGUgPSBMVFROR19FVkVOVF9MT0dMRVZFTF9BTEw7CiAKLS0gCjIuMS40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=

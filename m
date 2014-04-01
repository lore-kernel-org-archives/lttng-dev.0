From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-ust] Fix: Override AM_PATH_PYTHON's
	default action-if-not-found
Date: Tue,  1 Apr 2014 11:49:58 -0400
Message-ID: <1396367398-31434-1-git-send-email-jeremie.galarneau__45700.4518401392$1396367484$gmane$org@efficios.com>
References: <OFEFA91F70.CE626678-ONC2257CAD.004B5DA5-C2257CAD.004C1B49@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WV0wy-0000gw-Fp
 for lttng-dev@lists.lttng.org; Tue, 01 Apr 2014 11:50:14 -0400
Received: by mail-qg0-f53.google.com with SMTP id i50so954265qgf.40
 for <lttng-dev@lists.lttng.org>; Tue, 01 Apr 2014 08:50:02 -0700 (PDT)
In-Reply-To: <OFEFA91F70.CE626678-ONC2257CAD.004B5DA5-C2257CAD.004C1B49@il.ibm.com>
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

QU1fUEFUSF9QWVRIT04ncyBkZWZhdWx0IGFjdGlvbiBhYm9ydHMgY29uZmlndXJlLiBUaGlzIGZp
eCBlbnN1cmVzIHRoYXQKY29uZmlndXJlIGZvbGxvd3MgdGhyb3VnaCB3aXRoIGEgbm9vcC4KClNp
Z25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmlj
aW9zLmNvbT4KLS0tCiBjb25maWd1cmUuYWMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25m
aWd1cmUuYWMKaW5kZXggZDQ5MjZlNC4uYjA0ZDRlMyAxMDA2NDQKLS0tIGEvY29uZmlndXJlLmFj
CisrKyBiL2NvbmZpZ3VyZS5hYwpAQCAtMjg4LDcgKzI4OCw3IEBAIEFDX0RFRklORV9VTlFVT1RF
RChbTFRUTkdfU1lTVEVNX1JVTkRJUl0sIFsiJGx0dG5nX3N5c3RlbV9ydW5kaXIiXSwKIGx0dG5n
bGliamF2YWRpcj0iJHtsaWJkaXJ9L2x0dG5nL2phdmEiCiBBQ19TVUJTVChsdHRuZ2xpYmphdmFk
aXIpCiAKLUFNX1BBVEhfUFlUSE9OKFsyLjddLEJVSUxEX0dFTl9UUF9FWEFNUExFUz0xKQorQU1f
UEFUSF9QWVRIT04oWzIuN10sQlVJTERfR0VOX1RQX0VYQU1QTEVTPTEsWzpdKQogQU1fQ09ORElU
SU9OQUwoW0JVSUxEX0dFTl9UUF9FWEFNUExFU10sIFt0ZXN0ICRCVUlMRF9HRU5fVFBfRVhBTVBM
RVNdLCBbQnVpbGQgZXhhbXBsZXMgcmVxdWlyaW5nIGx0dG5nLWdlbi10cF0pCiAKIEFDX0NPTkZJ
R19GSUxFUyhbCi0tIAoxLjkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK

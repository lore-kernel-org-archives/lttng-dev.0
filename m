From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH] FIX: Align buffers on 4 bytes for 64bit
	access
Date: Thu, 15 May 2014 09:34:18 -0400
Message-ID: <CAFXXi0=j4LmhAEpGcr1gByatjk12Pgh_WOH7ZkvGkBTYk8zLHQ__1868.62843479521$1400162835$gmane$org@mail.gmail.com>
References: <1400144250-26852-1-git-send-email-rongqing.li@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1WkvoE-00020H-T0
 for lttng-dev@lists.lttng.org; Thu, 15 May 2014 09:34:55 -0400
Received: by mail-ie0-f172.google.com with SMTP id as1so1001931iec.31
 for <lttng-dev@lists.lttng.org>; Thu, 15 May 2014 06:34:49 -0700 (PDT)
In-Reply-To: <1400144250-26852-1-git-send-email-rongqing.li@windriver.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: rongqing.li@windriver.com
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SSBzdWdnZXN0IGFkZGluZyBhIGNvbW1lbnQgYWJvdmUgdGhhdCBsaW5lIGV4cGxhaW5pbmcgd2hh
dCBpdCBkb2VzLgoKT24gMTUgTWF5IDIwMTQgMDQ6NTcsICA8cm9uZ3FpbmcubGlAd2luZHJpdmVy
LmNvbT4gd3JvdGU6Cj4gRnJvbTogRnJlZHJpayBNYXJrc3Ryw7ZtIDxmcmVkcmlrLm1hcmtzdHJv
bUBnbWFpbC5jb20+Cj4KPiBTaWduZWQtb2ZmLWJ5OiBGcmVkcmlrIE1hcmtzdHLmnpptIDxmcmVk
cmlrLm1hcmtzdHJvbUBnbWFpbC5jb20+Cj4gLS0tCj4gIGZvcm1hdHMvY3RmL21ldGFkYXRhL29i
anN0YWNrLmMgfCAgICAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9mb3JtYXRzL2N0Zi9tZXRhZGF0YS9vYmpzdGFjay5jIGIvZm9ybWF0cy9j
dGYvbWV0YWRhdGEvb2Jqc3RhY2suYwo+IGluZGV4IDllMjY0YTQuLjk2NDNiOWIgMTAwNjQ0Cj4g
LS0tIGEvZm9ybWF0cy9jdGYvbWV0YWRhdGEvb2Jqc3RhY2suYwo+ICsrKyBiL2Zvcm1hdHMvY3Rm
L21ldGFkYXRhL29ianN0YWNrLmMKPiBAQCAtMTE4LDYgKzExOCw4IEBAIHZvaWQgKm9ianN0YWNr
X2FsbG9jKHN0cnVjdCBvYmpzdGFjayAqb2Jqc3RhY2ssIHNpemVfdCBsZW4pCj4gICAgICAgICBz
dHJ1Y3Qgb2Jqc3RhY2tfbm9kZSAqbGFzdF9ub2RlOwo+ICAgICAgICAgdm9pZCAqcDsKPgo+ICsg
ICAgICAgbGVuID0gKGxlbiArIDMpICYgfjM7Cj4gKwo+ICAgICAgICAgLyogR2V0IGxhc3Qgbm9k
ZSAqLwo+ICAgICAgICAgbGFzdF9ub2RlID0gYnRfbGlzdF9lbnRyeShvYmpzdGFjay0+aGVhZC5w
cmV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBvYmpzdGFja19ub2RlLCBub2Rl
KTsKPiAtLQo+IDEuNy4xMC40Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKPiBodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

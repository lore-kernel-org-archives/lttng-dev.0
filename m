Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2F3C7618A
	for <lttng-dev@archiver.kernel.org>; Mon, 20 Mar 2023 18:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679337449;
	bh=+xC4QEqC3/wVRoO3FRs1EAvWvt4R5WyCOkshJB9wSHg=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=sOJA0O5ijNxq60gjEBCP/M49viKpiGqjY0NXd5dn+TQIRJ7zKlVbq6yKENGxCnrpw
	 RMcVKltSv/C8esk/hV5MKFZuzP4AmzzHFa0pyBNcPNwGPfssJpGqV9AUMdfyJ27N9V
	 MHGWGpm+CLh9Rt/zViX1rjVKoADjW4VNdhdatBaEFQ1iXVg2+3dCZ7jSIhwMF7pqgr
	 iA6Yy0ddtyV4LWBqg4bKcmnQ5RuAYDHylwCWOZw4Z3zJqWe52EBTDSc9dI2GlHaSOt
	 W5t8aL/34xwLgI5smLCdiojwQ40RGep91jn9vmZts4jx6mauCLIt5LiFFSD+huOPAM
	 Ls60B7NZtrg+A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgNkx5gq0z2Gbk;
	Mon, 20 Mar 2023 14:37:29 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgNkw4Tffz2DkY
 for <lttng-dev@lists.lttng.org>; Mon, 20 Mar 2023 14:37:28 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PgNkw0y3Zzr7p;
 Mon, 20 Mar 2023 14:37:28 -0400 (EDT)
Message-ID: <e7384cff-06a6-6e1e-9abc-ce7932760964@efficios.com>
Date: Mon, 20 Mar 2023 14:37:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev@lists.lttng.org, paulmck <paulmck@kernel.org>
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-8-ondrej@sury.org>
In-Reply-To: <20230317213755.455957-8-ondrej@sury.org>
Subject: Re: [lttng-dev] [PATCH 7/7] Experiment: Add explicit memory barrier
 in free_completion()
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMy0wMy0xNyAxNzozNywgT25kxZllaiBTdXLDvSB2aWEgbHR0bmctZGV2IHdyb3RlOgo+
IEZJWE1FOiBUaGlzIGlzIGV4cGVyaW1lbnQgdGhhdCBhZGRzIGV4cGxpY2l0IG1lbW9yeSBiYXJy
aWVyIGluIHRoZQo+IGZyZWVfY29tcGxldGlvbiBpbiB0aGUgd29ya3F1ZXVlLmMsIHNvIFRocmVh
ZFNhbml0aXplciBrbm93cyBpdCdzIG9rIHRvCj4gZnJlZSB0aGUgcmVzb3VyY2VzLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IE9uZMWZZWogU3Vyw70gPG9uZHJlakBzdXJ5Lm9yZz4KPiAtLS0KPiAgIHNy
Yy93b3JrcXVldWUuYyB8IDEgKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4g
Cj4gZGlmZiAtLWdpdCBhL3NyYy93b3JrcXVldWUuYyBiL3NyYy93b3JrcXVldWUuYwo+IGluZGV4
IDEwMzlkNzIuLmYyMTkwN2YgMTAwNjQ0Cj4gLS0tIGEvc3JjL3dvcmtxdWV1ZS5jCj4gKysrIGIv
c3JjL3dvcmtxdWV1ZS5jCj4gQEAgLTM3Nyw2ICszNzcsNyBAQCB2b2lkIGZyZWVfY29tcGxldGlv
bihzdHJ1Y3QgdXJjdV9yZWYgKnJlZikKPiAgIAlzdHJ1Y3QgdXJjdV93b3JrcXVldWVfY29tcGxl
dGlvbiAqY29tcGxldGlvbjsKPiAgIAo+ICAgCWNvbXBsZXRpb24gPSBjYWFfY29udGFpbmVyX29m
KHJlZiwgc3RydWN0IHVyY3Vfd29ya3F1ZXVlX2NvbXBsZXRpb24sIHJlZik7Cj4gKwlhc3NlcnQo
IXVyY3VfcmVmX2dldF91bmxlc3NfemVybygmY29tcGxldGlvbi0+cmVmKSk7CgpQZXJoYXBzIHdo
YXQgd2UgcmVhbGx5IHdhbnQgaGVyZSBpcyBhbiBBTk5PVEFURV9VTlBVQkxJU0hfTUVNT1JZX1JB
TkdFKCkgCm9mIHNvbWUgc29ydCA/CgpUaGFua3MsCgpNYXRoaWV1Cgo+ICAgCWZyZWUoY29tcGxl
dGlvbik7Cj4gICB9Cj4gICAKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0
dHBzOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK

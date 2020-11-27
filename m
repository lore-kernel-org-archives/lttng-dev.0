Return-Path: <SRS0=ImaU=FB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E06C2D0E4
	for <lttng-dev@archiver.kernel.org>; Fri, 27 Nov 2020 14:06:02 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170BC206CA
	for <lttng-dev@archiver.kernel.org>; Fri, 27 Nov 2020 14:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="b0ByilEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170BC206CA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CjGck45Y7z1Ph5;
	Fri, 27 Nov 2020 09:05:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1606485959;
	bh=7YR2/P7bytCJ6RvbTo/Lx9JgAhhq6RT5SDx+L6hghk4=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=b0ByilELjnmNI/9eR6BuhdKSrCg2U3T08y7gGTWf9VIYh2sAAZc5QnZ0JbCC+Y58H
	 WJzEyssD30pWZMFUGUe841i6qTUAmBuaAVUSZRnNJDek0IfqLmTIQw4p74l9EH/WMC
	 NoidK5mcgo6aSRlUHb55gKyh8nax2xeCPcVk7icsOqa0DWUDY9DqEODa6zGi0TPWqs
	 vhIdbcFKQhl5/nkSSjKYsX7v6I8Ly6B3pqTCnVVa25CrdZKSSNGm6p27PiU6lbB2bK
	 XwIK+nFKN1sBVxpWBw7XCfZkIcVPgt2ShSD0j5d/Yk/Va3tvRKTv73Bk47ykF5Drvy
	 9y0CTl+qRABjw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CjGch0t41z1Pf6
 for <lttng-dev@lists.lttng.org>; Fri, 27 Nov 2020 09:05:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 973FB27B4FB
 for <lttng-dev@lists.lttng.org>; Fri, 27 Nov 2020 09:05:49 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id gHsx81bpGueb; Fri, 27 Nov 2020 09:05:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4EEB227B73F;
 Fri, 27 Nov 2020 09:05:49 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4EEB227B73F
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id kFn_Ibp1puAs; Fri, 27 Nov 2020 09:05:49 -0500 (EST)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 2C94927B4F8;
 Fri, 27 Nov 2020 09:05:49 -0500 (EST)
Date: Fri, 27 Nov 2020 09:05:48 -0500
To: =?utf-8?B?54aK5q+T5Y2O?= <xiongyuhua@zju.edu.cn>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20201127140548.GB3947@joraj-alpa>
References: <40a80cf.2b99.176086d97b1.Coremail.xiongyuhua@zju.edu.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <40a80cf.2b99.176086d97b1.Coremail.xiongyuhua@zju.edu.cn>
Subject: Re: [lttng-dev] Some confusion about cpu usage of the
 lttng-consumerd process
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGksCgpPbiBGcmksIE5vdiAyNywgMjAyMCBhdCAwMjozOToyOFBNICswODAwLCDnhormr5PljY4g
dmlhIGx0dG5nLWRldiB3cm90ZToKPiBIae+8jGRlYXIuCj4gCj4gSSBoYXZlIGJlZW4gdXNpbmcg
bHR0bmcgdG8gbW9uaXRvciBteSBzZXJ2ZXIgdGhlc2UgZGF5c++8jGJ1dCBJIGZvdW5kIHNvbWV0
aGluZyBpbnRlcmVzdGluZy4KPiAKPiBUaGUgY3B1IHVzYWdlIG9mIGx0dG5nIHZhcmllcyB3aXRo
IHRoZSBudW1iZXIgb2YgY3B1IGNvcmVzIG9mIHRoZSBzZXJ2ZXIuCgpXaGljaCBpcyBhIGJpdCBl
eHBlY3RlZCBzaW5jZSBtb3JlIENQVSBtZWFucyBtb3JlICJkYXRhIiBzb3VyY2UgZnJvbSB0aGUg
cG9pbnQKb2YgdmlldyBvZiBsdHRuZyBoZW5jZSBtb3JlICJ3b3JrIiBvdmVyYWxsLgoKPiAKPiBP
biB0aGUgc2VydmVyLCBJIGNyZWF0ZSBhIHRyYWNpbmcgc2Vzc2lvbiBpbiBsaXZlIG1vZGUsIHVz
aW5nICJsdHRuZyBjcmVhdGUgbXktc2Vzc2lvbiAtLWxpdmUiLiAKPiAKPiBUaGVuLEkgU3RhcnQg
dGhlIGJhYmVsdHJhY2UyIGFuZCBjb25maWd1cmUgaXQgdG8gY29ubmVjdCB0byB0aGUgcmVsYXkg
ZGFlbW9uLHVzaW5nICItLWlucHV0LWZvcm1hdD1sdHRuZy1saXZlIiBtb2RlLgo+IAo+IEkgdXNl
ZCA1IGNsb3VkIHNlcnZlcnPvvIwxY29yZTRHIDJjb3JlOEcgNGNvcmUxNkcgOGNvcmUxNkcgOGNv
cmUxNkcuCj4gCj4gQW5kLHRoZSBzYW1lIHRlc3Qgc2NyaXB0IHdhcyBleGVjdXRlZCBhYm92ZSB0
byBwcm92aWRlIHRoZSBzYW1lIHdvcmtsb2FkLgoKV2Ugd291bGQgbmVlZCB0aGUgdGVzdCBzY3Jp
cHQgdG8gaGF2ZSBzb21lIGNvbnRleHQgaGVyZSBvZiB0aGUgd29ya2xvYWQuCgo+IAo+IEFzIHdl
IGFsbCBrbm93LGx0dG5nIGhhcyA1IHByb2Nlc3NlcywKPiAKPiAxLmx0dG5nLXJ1bmFzICAgIC0t
ZGFlbW9uaXplCj4gCj4gMi5sdHRuZy1ydW5hcyAgICAgIC1rIC0tY29uc3VtZXJkLWNtZC1zb2Nr
IC92YXIvcnVuL2x0dG5nL2tjb25zdW1lcmQvY29tbWFuZCAtLWNvbnN1bWVyZC1lcnItc29jayAv
dmFyL3J1bi9sdHRuZy9rY29uc3VtZXJkL2Vycm9yIC0tZ3JvdXAgdHJhY2luZwoKQmFzZWQgb24g
dGhpcyB5b3UgYXJlIHBlcmZvcm1pbmcga2VybmVsIHRyYWNpbmcuCgo+IAo+IDMubHR0bmctc2Vz
c2lvbmQgLS1kYWVtb25pemUKPiAKPiA0Lmx0dG5nLXJlbGF5ZCAtTCB0Y3A6Ly9sb2NhbGhvc3Q6
NTM0NAo+IAo+IDUubHR0bmctY29uc3VtZXJkICAtayAtLWNvbnN1bWVyZC1jbWQtc29jayAvdmFy
L3J1bi9sdHRuZy9rY29uc3VtZXJkL2NvbW1hbmQgLS1jb25zdW1lcmQtZXJyLXNvY2sgL3Zhci9y
dW4vbHR0bmcva2NvbnN1bWVyZC9lcnJvciAtLWdyb3VwIHRyYWNpbmcKPiAKPiAKPiBUaGUgQ1BV
IHVzYWdlIG9mIHRoZSBmaXJzdCBmb3VyIHByb2Nlc3NlcyBpcyBiZWxvdyAyJSBvbiB0aGUgNSBz
ZXJ2ZXJzLGJ1dCB0aGUgbHR0bmctY29uc3VtZXJkIHByb2Nlc3MgaXMgZGlmZmVyZW50Lgo+IAo+
IE9uIDEtY29yZeOAgTItY29yZeOAgTQtY29yZSBzZXJ2ZXJz77yMdGhlIENQVSB1c2FnZSBvZiB0
aGUgbHR0bmctY29uc3VtZXJkIHByb2Nlc3MgaXMgYmVsb3cgMiUuCgpIb3cgaXMgdGhlIGNwdSB1
c2FnZSBtZWFzdXJlZCBoZXJlPwoKPiAKPiBCdXQgb24gdHdvIDgtY29yZSBtYWNoaW5lcywgdGhl
IGNwdSB1c2FnZSBvZiB0aGUgbHR0bmctY29uc3VtZXJkIHByb2Nlc3MgcmVhY2hlZCAxMCUgb3Ig
bW9yZS4KCkNvbnN1bWVyZCBpcyByZXNwb25zaWJsZSBvZiAiZmV0Y2hpbmciIGRhdGEgZnJvbSB0
aGUgcmluZyBidWZmZXJzIGFuZCAic2F2aW5nIgppdCBlaXRoZXIgbG9jYWxseSAodHJhY2Ugb24g
ZGlzaykgb3IgcmVtb3RlbHkgKHN0cmVhbWluZy9saXZlIHNlc3Npb24pLiBDUFUgdXNhZ2UKc2hv
dWxkIGJlIGEgYml0IGNvcnJlbGF0ZWQgd2l0aCB0aGUgZXZlbnQgcHJvZHVjdGlvbiByYXRlLiBE
aWQgeW91IGhhdmUgYSBsb29rIGF0IHRoZQpudW1iZXIgb2YgZXZlbnRzIGdlbmVyYXRlZCBmb3Ig
YSBzaW1pbGFyIGludGVydmFsPwoKPiBBbmQsdGhlIGNwdSB1c2FnZSBvZiB0aGUgYmFiZWx0cmFj
ZSBwcm9jZXNzIGlzIG5vdCBtdWNoIGRpZmZlcmVudCxqdXN0IHRoZSBjcHUgdXNhZ2Ugb2YgdGhl
IGx0dG5nLWNvbnN1bWVyZCBwcm9jZXNzIHZhcmllcyB3aXRoIHRoZSBudW1iZXIgb2YgY3B1IGNv
cmVzIG9mIHRoZSBzZXJ2ZXIuCj4gCj4gV2h5IGl0IGlzIGxpa2UgdGhpc++8n0hvdyBzaG91bGQg
dGhpcyBwaGVub21lbm9uIGJlIGFuYWx5emVkPwo+IAo+IExvb2tpbmcgZm9yd2FyZCB0byB5b3Vy
IHJlcGx5Lgo+IAo+IHRoYW5rcywKPiB5dWh1YQo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgoKLS0gCkpvbmF0aGFuIFJham90dGUtSnVsaWVuCkVm
ZmljaU9TCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==

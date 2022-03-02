Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46474C433EF
	for <lttng-dev@archiver.kernel.org>; Wed,  2 Mar 2022 22:18:38 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4K87mr2x8tz6Nd;
	Wed,  2 Mar 2022 17:18:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646259517;
	bh=Luwu5CmlrcSVuOrDCuM1Rq4tc8r9Skdq3A2yClUeYj8=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=uF86F9Vbod96oh/n5J7CSjh2GW6iRNsNF/AggZaRcZB8uOVfJ80TM6UQVOfBK4SrL
	 qAwtEHBG/zPi3QNuPzVKZnYck5ygudNwjiPvGxxEwkW9jmzUrPgxxqtRfXC0eXb44W
	 Kr0JG37fhUqHOqLZ9lwmTHbO4lbEG/V8ndMtRv6QNjRKJb09VIAhlySqVl0ak0NZJH
	 66AjDwhg8vWGy90gN47/Qj2PKhHTnlGPEcRvBuzvurbALvtsI3BAc8Lh2/Yi0GviPg
	 e5yT4SbPzqpKN/3bvuxi5FgEmTaGWtnEl4bw8CkKtlbFspsjt5hbPqIVrmUWOFzq6r
	 98tQzWlHDP6Lw==
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by lists.lttng.org (Postfix) with ESMTPS id 4K87mp5L5vz6Bw
 for <lttng-dev@lists.lttng.org>; Wed,  2 Mar 2022 17:18:34 -0500 (EST)
Received: by mail-wr1-x436.google.com with SMTP id j17so5014776wrc.0
 for <lttng-dev@lists.lttng.org>; Wed, 02 Mar 2022 14:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=0Nj9w1G6lAx+CJ3+Jv2JMU1hCw3Je8I7B8cSfFtKs8o=;
 b=0QwGSOjo62yp5k3LX82Gei23ZEhhJH8VeuKRIfXQRMRnXX+BIjbxTKVnHq/Ux1W56c
 yLLEsZiULxJSOc/pET1CvcgmaND9Szqa0qwl+SEod9Scm0ePGED6AB4FQ743DMZYcb3P
 B43DKBVXozgmZbV6GZn1AW7lrTTJDQIjh1qoD/eiNAPxKO5aagpF+q9Q+ZE8kILMpiou
 arGmlOC2UvRE7ddJ7YDXIxQbSpMwmh8WqE0j2FTC1K0aUV3QK5TQSZ/65ROHAE4tOxoB
 5EVYxH9f391gtsDPUCJzmkdGmZL1mvd79GLWqqAxQ/p+U4Ld+HZF6rNInQ/w+6pDzuui
 O2NQ==
X-Gm-Message-State: AOAM532Xg78BA4yQlYMHsJnA+KAtAJXBRfHDcqT/sIvvvQxDLun8HQqS
 fMM+1JSlPYMDa6YP5UMcbAwWyG+AxMSFFJmCnVU98Tun0eg=
X-Google-Smtp-Source: ABdhPJyyBqsMk9qs4Njow5c55GrdZEVCE9l7xF+5Eu0Acsrs5FIyWm0cRrAr5B3l8RH8ntvsgoo8xWPcQ/F4ym+R7yU=
X-Received: by 2002:a5d:47a5:0:b0:1e8:88b3:16b7 with SMTP id
 5-20020a5d47a5000000b001e888b316b7mr25179310wrb.417.1646259513099; Wed, 02
 Mar 2022 14:18:33 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 2 Mar 2022 14:18:21 -0800
Message-ID: <CAJMh_qWB8JOPWNNRt+rFNk1--FTTfSUUjQjRJXg2GLaR4gfJgw@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Parsing in-memory CTF packets with babeltrace2
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
From: Jon Lamb via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jon Lamb <lamb.jon.io@gmail.com>
Content-Type: multipart/mixed; boundary="===============2207246292236911719=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2207246292236911719==
Content-Type: multipart/alternative; boundary="0000000000007c875405d943a9f9"

--0000000000007c875405d943a9f9
Content-Type: text/plain; charset="UTF-8"

Hi,



I'm working on an program that is to receive CTF stream packets

and convert the contained events to a different format.

After reading through the babeltrace2 C API docs, I'm not

sure if it's possible to access the internal AST and parser

utilities used by the internal plugins, either manually

or through a source component plugin.



With a metadata text file at hand, is there a way to parse

CTF stream packet sitting in memory?



I'm trying to avoid having to write the in-memory packets to disk

first, and then use the source.ctf.fs component class to read them

back in as babeltrace2 API types.



For context, I have a few micros instrumented with barectf.

Depending on the deployment mode, I'm either sending CTF stream

packets out over serial or reading a ring buffer of packets via JTAG.



I can see this also being useful in a couple other dimensions I'd
eventually like to consider too:
* Implementing something lttng-relayd friendly for live viewer support
(parsing some of the packet header fields)
* Stream clock overflow bookkeeping (it'd let me reduce the probe effect of
have to manage a 32 or 64 bit clock on a 16 bit MCU)

Best,
Jon

--0000000000007c875405d943a9f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGksIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+SSYjMzk7bSB3b3JraW5nIG9u
IGFuIHByb2dyYW0gdGhhdCBpcyB0byByZWNlaXZlIENURiBzdHJlYW0gcGFja2V0cyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+YW5kIGNvbnZlcnQgdGhlIGNvbnRhaW5lZCBldmVudHMg
dG8gYSBkaWZmZXJlbnQgZm9ybWF0LiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCA8YnI+QWZ0ZXIgcmVhZGluZyB0aHJvdWdoIHRoZSBiYWJlbHRyYWNlMiBDIEFQSSBkb2Nz
LCBJJiMzOTttIG5vdCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+c3Vy
ZSBpZiBpdCYjMzk7cyBwb3NzaWJsZSB0byBhY2Nlc3MgdGhlIGludGVybmFsIEFTVCBhbmQgcGFy
c2VyIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj51dGlsaXRpZXMgdXNlZCBi
eSB0aGUgaW50ZXJuYWwgcGx1Z2lucywgZWl0aGVyIG1hbnVhbGx5IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj5vciB0aHJvdWdoIGEgc291cmNlIGNvbXBvbmVudCBw
bHVnaW4uIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+V2l0aCBhIG1ldGFkYXRhIHRleHQgZmls
ZSBhdCBoYW5kLCBpcyB0aGVyZSBhIHdheSB0byBwYXJzZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj5DVEYgc3RyZWFtIHBhY2tldCBzaXR0aW5nIGluIG1lbW9yeT8gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPkkmIzM5O20gdHJ5aW5nIHRvIGF2b2lkIGhhdmluZyB0
byB3cml0ZSB0aGUgaW4tbWVtb3J5IHBhY2tldHMgdG8gZGlzayDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCA8YnI+Zmlyc3QsIGFuZCB0aGVuIHVzZSB0aGUgc291cmNlLmN0Zi5mcyBjb21wb25lbnQg
Y2xhc3MgdG8gcmVhZCB0aGVtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPmJhY2sgaW4gYXMg
YmFiZWx0cmFjZTIgQVBJIHR5cGVzLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPkZv
ciBjb250ZXh0LCBJIGhhdmUgYSBmZXcgbWljcm9zIGluc3RydW1lbnRlZCB3aXRoIGJhcmVjdGYu
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj5EZXBlbmRpbmcgb24gdGhlIGRl
cGxveW1lbnQgbW9kZSwgSSYjMzk7bSBlaXRoZXIgc2VuZGluZyBDVEYgc3RyZWFtIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDxicj5wYWNrZXRzIG91dCBvdmVyIHNlcmlhbCBvciByZWFkaW5n
IGEgcmluZyBidWZmZXIgb2YgcGFja2V0cyB2aWEgSlRBRy4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJy
PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIDxicj5JIGNhbiBzZWUgdGhpcyBhbHNvIGJlaW5nIHVzZWZ1bCBpbiBhIGNvdXBs
ZSBvdGhlciBkaW1lbnNpb25zIEkmIzM5O2QgZXZlbnR1YWxseSBsaWtlIHRvIGNvbnNpZGVyIHRv
bzogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+KiBJbXBsZW1lbnRpbmcgc29t
ZXRoaW5nIGx0dG5nLXJlbGF5ZCBmcmllbmRseSBmb3IgbGl2ZSB2aWV3ZXIgc3VwcG9ydCAocGFy
c2luZyBzb21lIG9mIHRoZSBwYWNrZXQgaGVhZGVyIGZpZWxkcyk8YnI+KiBTdHJlYW0gY2xvY2sg
b3ZlcmZsb3cgYm9va2tlZXBpbmcgKGl0JiMzOTtkIGxldCBtZSByZWR1Y2UgdGhlIHByb2JlIGVm
ZmVjdCBvZiBoYXZlIHRvIG1hbmFnZSBhIDMyIG9yIDY0IGJpdCBjbG9jayBvbiBhIDE2IGJpdCBN
Q1UpPGJyPjxicj5CZXN0LDxkaXY+Sm9uPC9kaXY+PC9kaXY+DQo=
--0000000000007c875405d943a9f9--

--===============2207246292236911719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2207246292236911719==--

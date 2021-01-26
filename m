Return-Path: <SRS0=ECqA=G5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0A0C433DB
	for <lttng-dev@archiver.kernel.org>; Tue, 26 Jan 2021 15:19:29 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB0722B37
	for <lttng-dev@archiver.kernel.org>; Tue, 26 Jan 2021 15:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB0722B37
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DQ9Pp5J8vz11G7;
	Tue, 26 Jan 2021 10:19:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1611674367;
	bh=nwqdWKbm2q4EKyYWxGEp7rx9fv3lmQrTae6s6g2AfwY=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=k0dE0deMCNvwk82VdVVFkB+xvoao7s2gtQ/50kyhgg8LEYD+ggOTrgFJNeUxdW84Q
	 Ra915fbBKP+0u89ulOzhhsr/q9GL4ckD3det1gN/HCVTG4ZkQKhjkKA7D1fkbXSW8w
	 /Z66QNOs5FmqYiDinsLlz4ZOl0HrvvQtcGck7dxVqedPh0UPpyIIpBYH0o8ejA/Y4v
	 9Oavnb1P78B7CjD3iuSK3rb5F72s7jSkBhrTr0Hd1FGkxDsY5iIONGwuLecdJ86lI6
	 ekqTSqb2nbieCp52JE0ktCqk3rb2IHmd6+sbqs75a2+kGN4Hc/jiOharkCuGTlSH6+
	 /Pe8SPFwER1OQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DQ9Pm28Bhz10wJ
 for <lttng-dev@lists.lttng.org>; Tue, 26 Jan 2021 10:19:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D51B82F792A
 for <lttng-dev@lists.lttng.org>; Tue, 26 Jan 2021 10:19:18 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ZkavRGQoex2c for <lttng-dev@lists.lttng.org>;
 Tue, 26 Jan 2021 10:19:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 961D82F7468
 for <lttng-dev@lists.lttng.org>; Tue, 26 Jan 2021 10:19:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 961D82F7468
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 0JvfbIjxdqGd for <lttng-dev@lists.lttng.org>;
 Tue, 26 Jan 2021 10:19:18 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 8BFC72F77A5
 for <lttng-dev@lists.lttng.org>; Tue, 26 Jan 2021 10:19:18 -0500 (EST)
Date: Tue, 26 Jan 2021 10:19:18 -0500 (EST)
To: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1389106165.6573.1611674358449.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3991 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3980)
Thread-Index: 5+AEU0e4tawuTd2JT3Ht+0f1na3RkA==
Thread-Topic: Community input: Feedback on use of enumeration type within
 LTTng-UST
Subject: [lttng-dev] Community input: Feedback on use of enumeration type
 within LTTng-UST
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

We are currently working on the CTF2 specification [1] at EfficiOS, and there is
a user metric we would need to help us with a design decision with respect
to enumerations. This is where we would need community input.

The usage metrics in question are with respect to LTTng-UST enumeration types
(TRACEPOINT_ENUM) [2] used by tracepoint events within instrumented applications.

A tracepoint enumeration can be used by many events. What we are looking for is to get
an idea of the common use, and extreme cases as well.

Ideally, what we would need is:

- For each enumeration within your application instrumentation (TRACEPOINT_ENUM), how
  many events refer to each enumeration ? (average, mode, and maximum)
- For each TRACEPOINT_ENUM, how many labels do they possess ? (sum number of
  ctf_enum_value/ctf_enum_range/ctf_enum_auto entries) (average, mode, and maximum)
- For each TRACEPOINT_ENUM, for each label, what is the string length ? (average, mode, and maximum)

Based on this information, we can estimate the data overhead generated by repeating enumeration
labels in the LTTng-UST metadata. We need to decide whether we allow references to a single
enumeration description when it is used by many events, or if we require repeatedly serializing
the entire enumeration description for each event field using the enumeration.

Thanks,

Mathieu

[1] https://lists.lttng.org/pipermail/lttng-dev/2020-November/029777.html
[2] https://lttng.org/man/3/lttng-ust/v2.12/#doc-tracepoint-enum

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

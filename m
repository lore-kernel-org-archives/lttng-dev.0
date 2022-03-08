Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F43AC433F5
	for <lttng-dev@archiver.kernel.org>; Tue,  8 Mar 2022 15:59:32 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KCg4g3GmQz9VY;
	Tue,  8 Mar 2022 10:59:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646755172;
	bh=bw9SUVOmqG51dWmuUkJPJBRvgxBSGDd5dSciy/SiKqs=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=WSWyBq0gwJ0akB02D61ohnZvPgHvZBwTjCkaFs9nb1b7jt/z4utCbFd9gyoNhu4ou
	 jj21X3NpiROqnHGZZLY9Cf3Q42PZxLLI/uJr7rc96prPLKS+0CSPhq4kEVEvUssZaO
	 rn0LcTtlqAy1IYj3XNDnFU0JqJ4Go47qoP7G/MIg1HZAXUSMGPmi4mgl9a8Mf/V3MI
	 vH3j07120vuXpQCbK/uGeZgLi1ccAQXKdMo7Z+i6wv7KRrjF9mOgakmuzxD2ZTK6NB
	 qHU4LkyK4duYXFCg1my89UZe+HspIxerapq1f5GzpGLhGnnueYbz5DiT4IrWeGAkep
	 T90HsSdMHhrbQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KCg4d4FRhz9SG
 for <lttng-dev@lists.lttng.org>; Tue,  8 Mar 2022 10:59:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 060D9367F22
 for <lttng-dev@lists.lttng.org>; Tue,  8 Mar 2022 10:59:23 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id BaGnnBjD7vdP; Tue,  8 Mar 2022 10:59:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 85FFB367EA5;
 Tue,  8 Mar 2022 10:59:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 85FFB367EA5
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id xmdKTYp-sI5Z; Tue,  8 Mar 2022 10:59:22 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 76EF43677FD;
 Tue,  8 Mar 2022 10:59:22 -0500 (EST)
Date: Tue, 8 Mar 2022 10:59:22 -0500 (EST)
To: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 tracecompass-dev <tracecompass-dev@eclipse.org>
Message-ID: <270093074.129957.1646755162428.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - GC97 (Linux)/8.8.15_GA_4232)
Thread-Index: FVtoLdTTkTyaKSQFMfO7fn7womzHxA==
Thread-Topic: CTF 2: removal of the JSON text sequence auxiliary stream feature
Subject: [lttng-dev] CTF 2: removal of the JSON text sequence auxiliary
 stream feature
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <pproulx@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello,

Upon reflection, the JSON text sequence auxiliary streams of
CTF2-SPECRC-4.0 [1] and data streams are redundant concepts considering
that a CTF 2 data stream class may have a namespace and a name to
identify it as containing specific/auxiliary data.

Moreover, using data streams to transport "auxiliary" data means:

* Simpler implementation within existing CTF 1.8 tools: they can already
  read and/or write data streams.

  This means faster CTF 2 adoption.

* Simpler CTF 2 specification (JSON text sequence auxiliary stream
  concept is removed).

* More compact streams containing auxiliary data out of the box.

* A producer may attach user attributes to a data stream.

Note that if a data stream doesn't need a default clock, then its class
simply needs to not have any default clock class. This makes it possible
to have event records only containing data, without timing information.

The only lost benefit of not using JSON text sequence auxiliary streams
is not being able to read one without a CTF 2 data stream decoder.
However, I believe there's little point in doing so without having
access to a complete CTF 2 consumer to process the trace further anyway.

Considering all of the above, I'm about to release CTF2-SPECRC-5.0 which
removes the JSON text sequence auxiliary stream feature.

To remain backward compatible with CTF 1.8, however, CTF2-SPECRC-5.0
will specify a data stream class (having the `std` namespace) and event
record classes to make a data stream contain the trace environment
(`env` block in TSDL).

CTF 2 might also specify some "hidden" user attribute in the future to
indicate that a consumer should not display the instances of a given
data stream class. Indeed, should a data stream contain a symbol map,
for example, we don't want such data to show up in the output of a
Babeltrace 2 `sink.text.pretty` component or in the events editor of
Trace Compass.

Should you have any issue with this approach, please reply to this email
to illustrate your point of view.

Have a good day,

Philippe Proulx
EfficiOS Inc.
https://www.efficios.com/
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

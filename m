Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F764C433EF
	for <lttng-dev@archiver.kernel.org>; Tue,  8 Mar 2022 16:39:16 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KCgyW3kP4z9HD;
	Tue,  8 Mar 2022 11:39:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646757555;
	bh=skQ46pz+SQoAc4IbSXdkFK6xMKLIEhf8BKkMi0EuyCg=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=k4Dwwn2Y+IwohK5kfXtMpIhfzUsswTVLXe452iQO1p3mAuxeQBwAEfs8EFPYGsgCO
	 J6iAN2NNWIW3oze8KkQL6II7zTcGESZxzIOYNsZG4A7KaOHuteZpW4BOuRANvlaHo2
	 LwtZB5LEeBPXdvvCB/9Qdb9rbb6lqbcddzQEAdh4hOHsyUkKxI+rVUE6EeAsKWxmDr
	 3z20l19AGpt+4LVNH5+pomkFD1HLacBm9JoXqBCTeTeP1jYi0DK6He3VOITrs0lLEb
	 a1rAkdcsIlvzc7iXlUvaUdPGlABT0gu8vQDrHUQ7lRuZVv2EoNTapPnRuOowQgF7hh
	 nqjR6ZhRPnVSw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KCgyT3sHSz9QF
 for <lttng-dev@lists.lttng.org>; Tue,  8 Mar 2022 11:39:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 36A243885CF;
 Tue,  8 Mar 2022 11:39:02 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id I-_krsPg_Kpe; Tue,  8 Mar 2022 11:39:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BA0EE3885C3;
 Tue,  8 Mar 2022 11:39:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BA0EE3885C3
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id GDwa_SeosF46; Tue,  8 Mar 2022 11:39:01 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id AD333388980;
 Tue,  8 Mar 2022 11:39:01 -0500 (EST)
Date: Tue, 8 Mar 2022 11:39:01 -0500 (EST)
To: =?utf-8?B?54aK5q+T5Y2O?= <xiongyuhua@zju.edu.cn>
Message-ID: <38621111.130383.1646757541668.JavaMail.zimbra@efficios.com>
In-Reply-To: <662b3839.f16c8.17f6a594d6d.Coremail.xiongyuhua@zju.edu.cn>
References: <662b3839.f16c8.17f6a594d6d.Coremail.xiongyuhua@zju.edu.cn>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF97 (Linux)/8.8.15_GA_4232)
Thread-Topic: In lttng-live mode,
 if the printing speed cannot keep up with the generation speed
 of the parsed ctf data, where will the data be stored?
Thread-Index: lThsB5CwZqTR8UNX1s1mcon05v6RTQ==
Subject: Re: [lttng-dev] In lttng-live mode,
 if the printing speed cannot keep up with the generation speed of
 the parsed ctf data, where will the data be stored?
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, ychen@northwestern.edu
Content-Type: multipart/mixed; boundary="===============6435362099584033693=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6435362099584033693==
Content-Type: multipart/alternative; 
	boundary="=_10ce7b3d-065b-4167-8ead-07ec8b601564"

--=_10ce7b3d-065b-4167-8ead-07ec8b601564
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi 

> I wonder if my socket recv function is blocked on the other end, causing the
> socket send function to block in print_message function in babeltrace2;or when
> printing to the console, the printing speed can't keep up with the parsed CTF
> data generation speed and the print buffer is also full.

> In this case, how will Babeltrace2 handle the parsed CTF data that has not been
> sent yet, store them in a buffer, a queue or just discard them? Or would the
> blocking directly cause LTTng to discard the original CTF data at the ring
> buffer before LTTng Consumer daemon?
Not sure I understand your setup but when using lttng-live, you are effectively reading from the data that lttng-relayd is collecting, piece by piece. 
The producing side is not affected by the speed at which the reader (babeltrace2) consume data from lttng-relayd using the lttng-live protocol. 
There might be some corner case here and there but for most base usage of the "live" feature reader (babeltrace2) and producer(lttng/lttng-consumerd) 
are "decoupled". You can consider the "lttng-relayd" (and the trace on the filesystem) as the "buffer" here. 

--=_10ce7b3d-065b-4167-8ead-07ec8b601564
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi<br></div><div data-marker=3D"__QUOTED_TE=
XT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pa=
dding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorat=
ion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">
<p>
=09<span style=3D"font-size:14px;white-space:normal">I wonder if my socket =
recv function is blocked on the other end, causing the socket send function=
 to block in <span style=3D"color:#0550ae;font-family:'ui-monospace' , 'sfm=
ono-regular' , 'sf mono' , 'menlo' , 'consolas' , 'liberation mono' , monos=
pace;font-size:12px;white-space:pre;background-color:#ffffff">print_message=
 </span>function in babeltrace2;or when printing to the console, the printi=
ng speed can't keep up with the <span style=3D"font-size:14px;white-space:n=
ormal">parsed CTF&nbsp;</span>data generation speed and the print buffer is=
 also full.</span>
</p>
<p>
=09<span style=3D"font-size:14px">In this case, how will Babeltrace2 handle=
 the parsed CTF data that has not been sent yet, store them in a buffer, a =
queue or just discard them? Or would the blocking directly cause LTTng to d=
iscard the original CTF data at the ring buffer before LTTng Consumer daemo=
n?</span></p></blockquote><div><br></div><div>Not sure I understand your se=
tup but when using lttng-live, you are effectively reading from the data th=
at lttng-relayd is collecting, piece by piece. </div><div>The producing sid=
e is not affected by the speed at which the reader (babeltrace2) consume da=
ta from lttng-relayd using the lttng-live protocol.</div><div> There might =
be some corner case here and there but for most base usage of the "live" fe=
ature reader (babeltrace2) and producer(lttng/lttng-consumerd)</div><div> a=
re "decoupled". You can consider the "lttng-relayd" (and the trace on the f=
ilesystem) as the "buffer" here.</div></div></div></body></html>
--=_10ce7b3d-065b-4167-8ead-07ec8b601564--

--===============6435362099584033693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6435362099584033693==--

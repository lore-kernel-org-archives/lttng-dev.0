Return-Path: <SRS0=GPvk=MZ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFC8C4338F
	for <lttng-dev@archiver.kernel.org>; Mon,  2 Aug 2021 12:56:29 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A428260E09
	for <lttng-dev@archiver.kernel.org>; Mon,  2 Aug 2021 12:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A428260E09
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GddL26n6Bz5nP;
	Mon,  2 Aug 2021 08:56:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1627908987;
	bh=66pwL2D25NlX+IpZJHMTlctl8aSAmqAw2AGaRbnNxW0=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=mWVSo8sk8Jg24D+MuHzfSYSPp36/zAjCGkwSQ07tkWTvGAXL5dq5VkP/MHSr1yBEN
	 ZF5BjPAnt0MCwRxFBq3Vx4zTLSMhnAD+oMcgCIqYlqSbvFW4jblE1bwfP2xgeqdmAJ
	 9mifCeBHisgeWiOS+XticCnAWH7m3cKPLpeOfXgGRCrJnuAV0ZKQ2+DrRYEqBc1LMi
	 6mSPpjjf/9KiAy017RJT1f4ZmmZCTPuzE/eYFThT1FQv2cRORtpk1mZYhvgm3uXE15
	 L4iVpUX64MMLC66fSF7QCUULMsFuUFTy9TuEhTA+Zx1fQI+h7fzt1F4SvzL8hHNfO3
	 WszPWWLAiF0vA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4GddL131C2z5nM
 for <lttng-dev@lists.lttng.org>; Mon,  2 Aug 2021 08:56:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C935A35639E
 for <lttng-dev@lists.lttng.org>; Mon,  2 Aug 2021 08:56:19 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id YQ-BC93w4-FJ; Mon,  2 Aug 2021 08:56:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4D5863564A8;
 Mon,  2 Aug 2021 08:56:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4D5863564A8
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id k_LUJmBJZALV; Mon,  2 Aug 2021 08:56:19 -0400 (EDT)
Received: from [192.168.1.70] (unknown [142.59.56.168])
 by mail.efficios.com (Postfix) with ESMTPSA id 19A3D35650A;
 Mon,  2 Aug 2021 08:56:19 -0400 (EDT)
To: Evan Galea <evanjamesgalea@gmail.com>, lttng-dev@lists.lttng.org
References: <CAA+-46pQev9-S0_htpu7QT8cVF_Rv25deDjRQGMzgnzvRMG9VQ@mail.gmail.com>
Message-ID: <535d4d75-5ae6-b44a-9570-41a00ec96680@efficios.com>
Date: Mon, 2 Aug 2021 08:56:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAA+-46pQev9-S0_htpu7QT8cVF_Rv25deDjRQGMzgnzvRMG9VQ@mail.gmail.com>
Content-Language: en-US
Subject: Re: [lttng-dev] Assertion tgt_fc failed when trying to trace
 callstack-user
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Francis Deslauriers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Francis Deslauriers <francis.deslauriers@efficios.com>
Content-Type: multipart/mixed; boundary="===============4319493384225857046=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This is a multi-part message in MIME format.
--===============4319493384225857046==
Content-Type: multipart/alternative;
 boundary="------------2237A5D4F3235A18C466102E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2237A5D4F3235A18C466102E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Evan,

On 8/1/21 5:11 AM, Evan Galea via lttng-dev wrote:
> Hi there
>
> Thanks for help on my previous issue. I was able to get=20
> callstack-user=C2=A0to work and see it in my traces. However, in order =
to=20
> get it to run I needed to enable-event --kernel all. Is it necessary=20
> to have all kernel events enabled to run callstack-user? Or is it just=20
> one specific event?
>
> When I try to run it without enabling all kernel events the command is=20
> accepted and it runs but I get the following error when trying to view=20
> my traces:
>
> =C2=A0(=E2=95=AF=C2=B0=E2=96=A1=C2=B0)=E2=95=AF=EF=B8=B5 =E2=94=BB=E2=94=
=81=E2=94=BB ctf-meta-update-value-storing-indexes.c:65:=20
> update_field_class_stored_value_index(): Assertion `tgt_fc` failed.
> Aborted (core dumped)
>
> What does this error mean? Should I just continue to enable all kernel=20
> events?

It's a Babeltrace 2 error. Now, we need to find out if the root cause is=20
the LTTng kernel tracer or Babeltrace2 itself.

What is the "one specific event" you're enabling that seems to cause=20
this issue?

Do you have access to a Babeltrace 1.5 build? if so, could you try to=20
read that same trace using it?

Could you please share a small trace reproducing this issue?

What version of LTTng-tools, LTTng-Modules, and Babeltrace2 are you using=
?


Cheers,

Francis

>
> My current command setup, not sure if relevant
>
> lttng create &&
> lttng enable-channel mychannel --subbuf-size 100000000
> lttng enable-event --kernel --all &&
> lttng add-context -u -t vpid -t vtid -t procname &&
> lttng add-context --kernel --type callstack-user &&
> lttng add-context --kernel --type callstack-kernel &&
> lttng enable-event --jul jello
>
> again thank you for your time
>
> Evan Galea
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------2237A5D4F3235A18C466102E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>Hi Evan,</p>
    <div class=3D"moz-cite-prefix">On 8/1/21 5:11 AM, Evan Galea via
      lttng-dev wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CAA+-46pQev9-S0_htpu7QT8cVF_Rv25deDjRQGMzgnzvRMG9VQ@mail.gmai=
l.com">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      <div dir=3D"ltr">
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px">Hi there</div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px"><br>
        </div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px">Thanks for help on
          my previous issue. I was able to get callstack-user=C2=A0to wor=
k
          and see it in my traces. However, in order to get it to run I
          needed to enable-event --kernel all. Is it necessary to have
          all kernel events enabled to run callstack-user? Or is it just
          one specific event?</div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px"><br>
        </div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px">When I try to run it
          without enabling all kernel events the command is accepted and
          it runs but I get the following error when trying to view my
          traces:</div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px"><br>
        </div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px">
          <div style=3D"box-sizing:border-box">=C2=A0(=E2=95=AF=C2=B0=E2=96=
=A1=C2=B0)=E2=95=AF=EF=B8=B5 =E2=94=BB=E2=94=81=E2=94=BB
            ctf-meta-update-value-storing-indexes.c:65:
            update_field_class_stored_value_index(): Assertion `tgt_fc`
            failed.<br>
            Aborted (core dumped)</div>
          <div style=3D"box-sizing:border-box"><br>
          </div>
          <div style=3D"box-sizing:border-box">What does this error mean?
            Should I just continue to enable all kernel events?</div>
        </div>
      </div>
    </blockquote>
    <p>It's a Babeltrace 2 error. Now, we need to find out if the root
      cause is the LTTng kernel tracer or Babeltrace2 itself.</p>
    <p>What is the "one specific event" you're enabling that seems to
      cause this issue?<br>
    </p>
    <p>Do you have access to a Babeltrace 1.5 build? if so, could you
      try to read that same trace using it?</p>
    <p>Could you please share a small trace reproducing this issue?</p>
    <p>What version of LTTng-tools, LTTng-Modules, and Babeltrace2 are
      you using?</p>
    <p><br>
    </p>
    <p>Cheers,</p>
    <p>Francis<br>
    </p>
    <blockquote type=3D"cite"
cite=3D"mid:CAA+-46pQev9-S0_htpu7QT8cVF_Rv25deDjRQGMzgnzvRMG9VQ@mail.gmai=
l.com">
      <div dir=3D"ltr">
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px">
          <div style=3D"box-sizing:border-box"><br>
          </div>
          <div style=3D"box-sizing:border-box">My current command setup,
            not sure if relevant</div>
        </div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px"><br>
        </div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px">lttng create
          &amp;&amp;<br>
          lttng enable-channel mychannel --subbuf-size 100000000<br>
          lttng enable-event --kernel --all &amp;&amp;<br>
          lttng add-context -u -t vpid -t vtid -t procname &amp;&amp;<br>
          lttng add-context --kernel --type callstack-user &amp;&amp;<br>
          lttng add-context --kernel --type callstack-kernel &amp;&amp;<b=
r>
          lttng enable-event --jul jello</div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px"><br>
        </div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px">again thank you for
          your time</div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px"><br>
        </div>
        <div style=3D"box-sizing:border-box;font-family:&quot;Segoe
          UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe
          UI Emoji&quot;,sans-serif;font-size:14px">Evan Galea</div>
      </div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <pre class=3D"moz-quote-pre" wrap=3D"">____________________________=
___________________
lttng-dev mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttn=
g.org">lttng-dev@lists.lttng.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev">https://lists.lttng.org/cgi-bin/mailman/lis=
tinfo/lttng-dev</a>
</pre>
    </blockquote>
  </body>
</html>

--------------2237A5D4F3235A18C466102E--

--===============4319493384225857046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4319493384225857046==--

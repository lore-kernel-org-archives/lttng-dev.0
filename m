Return-Path: <SRS0=BhUn=M4=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D898AC4338F
	for <lttng-dev@archiver.kernel.org>; Thu,  5 Aug 2021 21:07:22 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E926960EBC
	for <lttng-dev@archiver.kernel.org>; Thu,  5 Aug 2021 21:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E926960EBC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Ggh542g2Rz6ND;
	Thu,  5 Aug 2021 17:07:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1628197640;
	bh=qc/F9Y5ZrL1udThywwSB935h9CFXptmeJljgMa1LRmA=;
	h=To:References:Cc:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RJgxOTDHAgN4NC5omOPgf1MOdcjKlNqloiO1vcd/T9dRuY5j5IKQh0/iz0yJV7ne0
	 VhNsfnrrZ24JdACrel+ZoenUEnOhJCDQEp7L5dQLVBoPNO/VgV+flFqz1l5Gx2BNkk
	 SyMjlCQzeUgD4ZgZPmzUAWkn7uBa6nKHypKWyhvBmcuCdMZWgWh9aZ9V0AHBjKgmuc
	 2mekkkyu8t5avI8h8uh7vNzLMfbGIu2EG7wDEMW6Qov9dS1TYQtmdoUfc1/dVjQ8Hc
	 KOqW/hjXHtChjI5eaAzsfC6/dWl7trzqbqb+3sDRrzAaQSfDnYvpcGQPRLJWDuYc+6
	 uLu7fS5RndLNA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Ggh530hs1z6c6
 for <lttng-dev@lists.lttng.org>; Thu,  5 Aug 2021 17:07:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 66EE7373651
 for <lttng-dev@lists.lttng.org>; Thu,  5 Aug 2021 17:07:12 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id tPP7E_0UF1VH; Thu,  5 Aug 2021 17:07:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3BABE373547;
 Thu,  5 Aug 2021 17:07:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3BABE373547
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id TXVlDgqlZx0b; Thu,  5 Aug 2021 17:07:11 -0400 (EDT)
Received: from [192.168.1.70] (unknown [142.59.56.168])
 by mail.efficios.com (Postfix) with ESMTPSA id 09A57373805;
 Thu,  5 Aug 2021 17:07:10 -0400 (EDT)
To: Evan Galea <evanjamesgalea@gmail.com>
References: <CAA+-46pQev9-S0_htpu7QT8cVF_Rv25deDjRQGMzgnzvRMG9VQ@mail.gmail.com>
 <535d4d75-5ae6-b44a-9570-41a00ec96680@efficios.com>
 <CAA+-46qpk52j9B56wpvsJ=WvE-TX_83r+A6o7hqTxGeTLLS8cQ@mail.gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <28459f83-bdae-a9c5-351f-96c9bc0de72d@efficios.com>
Date: Thu, 5 Aug 2021 17:07:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAA+-46qpk52j9B56wpvsJ=WvE-TX_83r+A6o7hqTxGeTLLS8cQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============8563682497453264754=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This is a multi-part message in MIME format.
--===============8563682497453264754==
Content-Type: multipart/alternative;
 boundary="------------A6F5BE0ED99480C9544E92AA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A6F5BE0ED99480C9544E92AA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Evan,

It turns out it's a Babeltrace 2 bug. Here the fix:=20
https://review.lttng.org/c/babeltrace/+/6257.

It should be merged into the master and stable-2.0 branches soon.


Thank you for reporting the issue,

Francis


On 8/4/21 3:55 AM, Evan Galea wrote:
> Hi Francis, thanks for your reply. As it turns out, running babeltrace=20
> on the file worked and I'm able to read the traces. I am running=20
> babeltrace 1.5.8, lttng 2.12.4, lttng-tools 2.12.x stable, and lttng=20
> modules 5.8.0-63. I attached the trace of the file.
>
>
> On Mon, Aug 2, 2021 at 8:56 AM Francis Deslauriers=20
> <francis.deslauriers@efficios.com=20
> <mailto:francis.deslauriers@efficios.com>> wrote:
>
>     Hi Evan,
>
>     On 8/1/21 5:11 AM, Evan Galea via lttng-dev wrote:
>>     Hi there
>>
>>     Thanks for help on my previous issue. I was able to get
>>     callstack-user=C2=A0to work and see it in my traces. However, in o=
rder
>>     to get it to run I needed to enable-event --kernel all. Is it
>>     necessary to have all kernel events enabled to run
>>     callstack-user? Or is it just one specific event?
>>
>>     When I try to run it without enabling all kernel events the
>>     command is accepted and it runs but I get the following error
>>     when trying to view my traces:
>>
>>     =C2=A0(=E2=95=AF=C2=B0=E2=96=A1=C2=B0)=E2=95=AF=EF=B8=B5 =E2=94=BB=
=E2=94=81=E2=94=BB ctf-meta-update-value-storing-indexes.c:65:
>>     update_field_class_stored_value_index(): Assertion `tgt_fc` failed=
.
>>     Aborted (core dumped)
>>
>>     What does this error mean? Should I just continue to enable all
>>     kernel events?
>
>     It's a Babeltrace 2 error. Now, we need to find out if the root
>     cause is the LTTng kernel tracer or Babeltrace2 itself.
>
>     What is the "one specific event" you're enabling that seems to
>     cause this issue?
>
>     Do you have access to a Babeltrace 1.5 build? if so, could you try
>     to read that same trace using it?
>
>     Could you please share a small trace reproducing this issue?
>
>     What version of LTTng-tools, LTTng-Modules, and Babeltrace2 are
>     you using?
>
>
>     Cheers,
>
>     Francis
>
>>
>>     My current command setup, not sure if relevant
>>
>>     lttng create &&
>>     lttng enable-channel mychannel --subbuf-size 100000000
>>     lttng enable-event --kernel --all &&
>>     lttng add-context -u -t vpid -t vtid -t procname &&
>>     lttng add-context --kernel --type callstack-user &&
>>     lttng add-context --kernel --type callstack-kernel &&
>>     lttng enable-event --jul jello
>>
>>     again thank you for your time
>>
>>     Evan Galea
>>
>>     _______________________________________________
>>     lttng-dev mailing list
>>     lttng-dev@lists.lttng.org  <mailto:lttng-dev@lists.lttng.org>
>>     https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev  <https=
://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
>

--------------A6F5BE0ED99480C9544E92AA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>Hi Evan,</p>
    <p>It turns out it's a Babeltrace 2 bug. Here the fix:=C2=A0
      <a class=3D"moz-txt-link-freetext" href=3D"https://review.lttng.org=
/c/babeltrace/+/6257">https://review.lttng.org/c/babeltrace/+/6257</a>.</=
p>
    <p>It should be merged into the master and stable-2.0 branches soon.<=
/p>
    <p><br>
    </p>
    <p>Thank you for reporting the issue,</p>
    <p>Francis<br>
    </p>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 8/4/21 3:55 AM, Evan Galea wrote:<b=
r>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CAA+-46qpk52j9B56wpvsJ=3DWvE-TX_83r+A6o7hqTxGeTLLS8cQ@mail.gm=
ail.com">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      <div dir=3D"ltr">Hi Francis, thanks for your reply. As it turns out=
,
        running babeltrace on the file worked and I'm able to read the
        traces. I am running babeltrace 1.5.8, lttng 2.12.4, lttng-tools
        2.12.x stable, and lttng modules 5.8.0-63. I attached the trace
        of the file.<br>
        <div><br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 2, 2021 at 8:56=
 AM
          Francis Deslauriers &lt;<a
            href=3D"mailto:francis.deslauriers@efficios.com"
            target=3D"_blank" moz-do-not-send=3D"true">francis.deslaurier=
s@efficios.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div>
            <p>Hi Evan,</p>
            <div>On 8/1/21 5:11 AM, Evan Galea via lttng-dev wrote:<br>
            </div>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>Hi there</div>
                <div><br>
                </div>
                <div>Thanks for help on my previous issue. I was able to
                  get callstack-user=C2=A0to work and see it in my traces=
.
                  However, in order to get it to run I needed to
                  enable-event --kernel all. Is it necessary to have all
                  kernel events enabled to run callstack-user? Or is it
                  just one specific event?</div>
                <div><br>
                </div>
                <div>When I try to run it without enabling all kernel
                  events the command is accepted and it runs but I get
                  the following error when trying to view my traces:</div=
>
                <div><br>
                </div>
                <div>
                  <div style=3D"box-sizing:border-box">=C2=A0(=E2=95=AF=C2=
=B0=E2=96=A1=C2=B0)=E2=95=AF=EF=B8=B5 =E2=94=BB=E2=94=81=E2=94=BB
                    ctf-meta-update-value-storing-indexes.c:65:
                    update_field_class_stored_value_index(): Assertion
                    `tgt_fc` failed.<br>
                    Aborted (core dumped)</div>
                  <div style=3D"box-sizing:border-box"><br>
                  </div>
                  <div style=3D"box-sizing:border-box">What does this
                    error mean? Should I just continue to enable all
                    kernel events?</div>
                </div>
              </div>
            </blockquote>
            <p>It's a Babeltrace 2 error. Now, we need to find out if
              the root cause is the LTTng kernel tracer or Babeltrace2
              itself.</p>
            <p>What is the "one specific event" you're enabling that
              seems to cause this issue?<br>
            </p>
            <p>Do you have access to a Babeltrace 1.5 build? if so,
              could you try to read that same trace using it?</p>
            <p>Could you please share a small trace reproducing this
              issue?</p>
            <p>What version of LTTng-tools, LTTng-Modules, and
              Babeltrace2 are you using?</p>
            <p><br>
            </p>
            <p>Cheers,</p>
            <p>Francis<br>
            </p>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>
                  <div style=3D"box-sizing:border-box"><br>
                  </div>
                  <div style=3D"box-sizing:border-box">My current command
                    setup, not sure if relevant</div>
                </div>
                <div><br>
                </div>
                <div>lttng create &amp;&amp;<br>
                  lttng enable-channel mychannel --subbuf-size 100000000<=
br>
                  lttng enable-event --kernel --all &amp;&amp;<br>
                  lttng add-context -u -t vpid -t vtid -t procname
                  &amp;&amp;<br>
                  lttng add-context --kernel --type callstack-user
                  &amp;&amp;<br>
                  lttng add-context --kernel --type callstack-kernel
                  &amp;&amp;<br>
                  lttng enable-event --jul jello</div>
                <div><br>
                </div>
                <div>again thank you for your time</div>
                <div><br>
                </div>
                <div>Evan Galea</div>
              </div>
              <br>
              <fieldset></fieldset>
              <pre>_______________________________________________
lttng-dev mailing list
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" moz-do-not=
-send=3D"true">lttng-dev@lists.lttng.org</a>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" ta=
rget=3D"_blank" moz-do-not-send=3D"true">https://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev</a>
</pre>
            </blockquote>
          </div>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------A6F5BE0ED99480C9544E92AA--

--===============8563682497453264754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8563682497453264754==--

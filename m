Return-Path: <SRS0=A40Q=63=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4ADCA90AF
	for <lttng-dev@archiver.kernel.org>; Wed, 13 May 2020 14:18:25 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B31204EF
	for <lttng-dev@archiver.kernel.org>; Wed, 13 May 2020 14:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Vnh7203u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B31204EF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49McGR228cz21m7;
	Wed, 13 May 2020 10:18:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1589379503;
	bh=A62pW9Td6VaJhsEmBSvYhQHRki78Eqxas7tiC4LK25k=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Vnh7203ugPvXjHRI/tg7tDXSq/We1IiEABGg9eiPiYoOLPwaDzsUqM5ja+O8FXpo2
	 w0JeKHwDbdDEp9YjztC8aRLYOEUeYGh1BNSq10Qnd1DJhfx7AHSMtuyjorXV1OT5FS
	 sOz9Oe10HRLofTrU50k2NngmXid2T3IIAT/yh8q44Gusgb7mJGwFzlQgXzk4ImctwJ
	 jOBnJdEP+NJ7Ehr5+z4jm/hF1nCGlRnBMUcADNSFwzeGTJymHEoDD/ktJ8ElFivcRD
	 Kuml7wq/rtq9HtZKnYbnLjcwgGcaYK7C1cxWXii+1s3lvoxoRCT72JLQi7t9POLDDp
	 hykenJVDboExg==
Received: from barracuda.ebox.ca (barracuda.ebox.ca [96.127.255.19])
 by lists.lttng.org (Postfix) with ESMTPS id 49McGP7295z21tc
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 10:18:21 -0400 (EDT)
X-ASG-Debug-ID: 1589378524-0c856e18f31459420001-YyuIcB
Received: from smtp.ebox.ca (smtp.ebox.ca [96.127.255.82]) by
 barracuda.ebox.ca with ESMTP id MCO6rLzHtrvLPmE4 (version=TLSv1
 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) for <lttng-dev@lists.lttng.org>;
 Wed, 13 May 2020 10:02:04 -0400 (EDT)
X-Barracuda-Envelope-From: gbastien@versatic.net
X-Barracuda-RBL-Trusted-Forwarder: 96.127.255.82
Received: from [192.168.47.170] (unknown [104.163.172.174])
 by smtp.ebox.ca (Postfix) with ESMTPS id 46AEB441B21
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 10:02:04 -0400 (EDT)
X-Barracuda-RBL-IP: 192.168.47.170
To: lttng-dev@lists.lttng.org
X-ASG-Orig-Subj: Re: [lttng-dev] Correctly using callstack-user context
References: <CAAS9doY1Ez7N=_H6e-w9eWg0LBJp+MMasuOEmzbO0DGyLSzViA@mail.gmail.com>
 <1486835767.11198.1589286441675.JavaMail.zimbra@efficios.com>
 <CAAS9dobxi52FyWn=9zVDkMMpmZztc1Q1msdiErMKhkDEYCtqCA@mail.gmail.com>
Autocrypt: addr=gbastien@versatic.net; prefer-encrypt=mutual; keydata=
 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
 jvgrBQ==
Message-ID: <bdeb584b-7c42-9e26-ce10-a1b008212541@versatic.net>
Date: Wed, 13 May 2020 10:02:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAS9dobxi52FyWn=9zVDkMMpmZztc1Q1msdiErMKhkDEYCtqCA@mail.gmail.com>
Content-Language: en-US
X-Barracuda-Connect: smtp.ebox.ca[96.127.255.82]
X-Barracuda-Start-Time: 1589378524
X-Barracuda-Encrypted: DHE-RSA-AES256-SHA
X-Barracuda-URL: https://96.127.255.19:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 4859
X-Virus-Scanned: by bsmtpd at ebox.ca
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=8.0 tests=HTML_MESSAGE
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81822
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.00 HTML_MESSAGE           BODY: HTML included in message
Subject: Re: [lttng-dev] Correctly using callstack-user context
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
From: Genevieve Bastien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Genevieve Bastien <gbastien@versatic.net>
Content-Type: multipart/mixed; boundary="===============2221153782573968286=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200513140204.wv2d2vM8fYlsWZYn-KChQ5BqcXK3V3B-6eGE2INacDo@z>

This is a multi-part message in MIME format.
--===============2221153782573968286==
Content-Type: multipart/alternative;
 boundary="------------030E079F2CB96675849F32D4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------030E079F2CB96675849F32D4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 5/13/20 9:42 AM, Christophe B=C3=A9dard via lttng-dev wrote:
>
> On Tue, 12 May 2020 at 08:27, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com
> <mailto:mathieu.desnoyers@efficios.com>> wrote:
>
>     How does your test program issue the system call ? Is it directly
>     with syscall() (see syscall(2) man page), or
>     does it call into libc ? Is your entire libc compiled with
>     -fno-omit-frame-pointer ?
>
>
> Indirectly, through libc/libstdc++. We use the default system libs
> (which I assume use -O, which in turn implies -fomit-frame-pointer).
> =C2=A0
>
>     As soon as one library in the chain to the system call is compiled
>     without frame pointers, this is where the
>     stack walk stops. This is usually libc.
>
>
> I see. Thanks for the information. Not sure we want to ship a custom
> libc unfortunately.
>
> Related question: how feasible would adding the callstack-user context
> to userspace=C2=A0events be? If it is feasible, is such a feature plann=
ed?

We had a very very experimental branch with it, using backtrace first,
then unwind. But it is not suggested, not performant. It's far from the
correct desired implementation, for which Mathieu could give more details=
=2E

It works, but not to be used in production. Students have used it in the
lab for some specific use case prototyping. I won't share the branch
here, but if you wish to try, let me know.

Genevi=C3=A8ve



--------------030E079F2CB96675849F32D4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Christophe,<br>
    </p>
    <div class="moz-cite-prefix">On 5/13/20 9:42 AM, Christophe Bédard
      via lttng-dev wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAS9dobxi52FyWn=9zVDkMMpmZztc1Q1msdiErMKhkDEYCtqCA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Tue, 12 May 2020 at
            08:27, Mathieu Desnoyers &lt;<a
              href="mailto:mathieu.desnoyers@efficios.com"
              target="_blank" moz-do-not-send="true">mathieu.desnoyers@efficios.com</a>&gt;
            wrote:</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div>
              <div
style="font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
                <div>
                  <div>How does your test program issue the system call
                    ? Is it directly with syscall() (see syscall(2) man
                    page), or<br>
                  </div>
                  <div>does it call into libc ? Is your entire libc
                    compiled with -fno-omit-frame-pointer ?</div>
                </div>
              </div>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>Indirectly, through libc/libstdc++. We use the default
            system libs (which I assume use -O, which in turn implies
            -fomit-frame-pointer).</div>
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div
style="font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
              <div>As soon as one library in the chain to the system
                call is compiled without frame pointers, this is where
                the<br>
              </div>
              <div>stack walk stops. This is usually libc.</div>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>I see. Thanks for the information. Not sure we want to
            ship a custom libc unfortunately.</div>
          <div><br>
          </div>
          <div>Related question: how feasible would adding the
            callstack-user context to userspace events be? If it is
            feasible, is such a feature planned?</div>
        </div>
      </div>
    </blockquote>
    <p>We had a very very experimental branch with it, using backtrace
      first, then unwind. But it is not suggested, not performant. It's
      far from the correct desired implementation, for which Mathieu
      could give more details.</p>
    <p> It works, but not to be used in production. Students have used
      it in the lab for some specific use case prototyping. I won't
      share the branch here, but if you wish to try, let me know.</p>
    <p>Geneviève</p>
    <p><br>
    </p>
  </body>
</html>

--------------030E079F2CB96675849F32D4--

--===============2221153782573968286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2221153782573968286==--

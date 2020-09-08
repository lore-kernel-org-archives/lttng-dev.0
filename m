Return-Path: <SRS0=aBhz=CR=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFF2C433E2
	for <lttng-dev@archiver.kernel.org>; Tue,  8 Sep 2020 21:01:49 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06AC020732
	for <lttng-dev@archiver.kernel.org>; Tue,  8 Sep 2020 21:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Yf+QuKNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AC020732
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BmHdQ5G7VzCqR;
	Tue,  8 Sep 2020 17:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1599598907;
	bh=eqVJx+2Vcp0LBufhU74tkzTymws52l5z+DRfFcmSksQ=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Yf+QuKNMfLeOBes8RbdsukKuChYl4qoBgUszQeWYVB0MmEkljNbrvNxK+ixYGTl/4
	 QTN0PweAsnS6ZHP8VY3z8GxpwPXaP9BhSYD++fJYYq1y3PNzWcrNROMSTX+ZnHmLSp
	 UUvgsRFI4V9l8QpGcYorN8JNT4obQCuJGDzghIsnLxazWOtavRwYD7noMoQe666vWX
	 /WZeZBtyOVVx+zShbH4tMXHNUnAO+DR/1RADLINGWNmgLVCqEBb0vULe78WLDHXco6
	 Q6AmdsD+i0zgFk0dP5Zp45QMnqr7UuyNu08e4Y4E6+8ZZ4gs12St0tb/9UtXL97lgE
	 CvV7NsLW/Q3+Q==
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by lists.lttng.org (Postfix) with ESMTPS id 4BmH9g0zmfzD8M
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2020 16:41:10 -0400 (EDT)
Received: by mail-ed1-x52e.google.com with SMTP id b12so407653edz.11
 for <lttng-dev@lists.lttng.org>; Tue, 08 Sep 2020 13:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SS7vN82BMD0pcZy3FKJ4c5GRDOyEh9epguOFrXnw1QI=;
 b=JLfx2QU7teYs5soGTMErwNiX6iAMyFCHgNNL6SGIyN2w3+uql5HUCP4yb+0BvdXm4z
 /5dNi+ycQBmjN88VJ6222ScdVDSWU4R8NjgByMZpi7VmxDg2mIf2uigN4gI+uh477zFs
 zw3vzXszcyGdRDHQzKZtqAy+RBiv4vMqdrm8ofGylQ2AqjHcaqOb+R2Ykdo0vWHRHQ8L
 vdV5pZ6UIVdkgeqjWHZlDE/QLimlVVuO2d8Fbn0/Q08ywweoct1iKGzOh+cYHliKnc2u
 MHXtqSD0ic3Y2Guo9Th7+JBioeLuuOfNqAAhCfNovwGT59A1zbznOO5PrrTSdCTauZQJ
 v32A==
X-Gm-Message-State: AOAM5315LQ7iX5QL/K1RkqCnv2iW88idc8hbSh1bXJ8fw3NS6ovPd6jD
 6KuyNrEZk4gC3PlSzWloW1mvM26dAxlAvoXIjXk=
X-Google-Smtp-Source: ABdhPJyOoM1GBAQa48e/yiMh+ZYl9YXhGEDGv+zaZcZLA4ZgADV/2hjZef2emPnQREjtMtUedKLTN3IwrvuTrYIYxKs=
X-Received: by 2002:aa7:dbcb:: with SMTP id v11mr839363edt.351.1599597669685; 
 Tue, 08 Sep 2020 13:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAM-pDOyr2VN94eWJahkRX47rTp=YSOwvyZL5iVO2bETaaLx+1Q@mail.gmail.com>
 <CAB4xu_32eMKy2sndQNtHmVZ4go3rs2Wu-hBv09xjTYu_U8fPGg@mail.gmail.com>
In-Reply-To: <CAB4xu_32eMKy2sndQNtHmVZ4go3rs2Wu-hBv09xjTYu_U8fPGg@mail.gmail.com>
Date: Tue, 8 Sep 2020 13:40:58 -0700
Message-ID: <CAM-pDOwfgN1WVPo=Ggh-cbbx0x7=j6LbK_jLec_Xr5_Cwut=Bw@mail.gmail.com>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
X-Mailman-Approved-At: Tue, 08 Sep 2020 17:01:45 -0400
Subject: Re: [lttng-dev] babeltrace2: reading metadata + events from a
 single CTF file
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
From: Dave Bort via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Dave Bort <dbort@dbort.com>
Content-Type: multipart/mixed; boundary="===============9045772563783755003=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============9045772563783755003==
Content-Type: multipart/alternative; boundary="000000000000e29f7405aed35aae"

--000000000000e29f7405aed35aae
Content-Type: text/plain; charset="UTF-8"

Thank you for your prompt and helpful response, Philippe!

I'll find a way to stick to the de facto standard of multiple files as
input to babeltrace. On the device side, I can bundle things up in a simple
container format like cpio, which I can easily extract on any host system
without special tools.

--dbort

On Tue, Sep 8, 2020 at 7:54 AM Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Mon, Sep 7, 2020 at 8:35 AM Dave Bort via lttng-dev
> <lttng-dev@lists.lttng.org> wrote:
> >
> > Hello! I'm adding CTF-compatible tracing to a custom/experimental OS and
> have a question:
> >
> > Can babeltrace2 read from a single CTF output file that contains both
> the metadata stream and the binary trace streams?
>
> No.
>
> >
> > My little trace system would like to bundle everything related to a
> trace into a single file, making it easier to pass around (since there's
> not much filesystem/network support yet). The CTF spec provides a way to
> embed the metadata stream in the same bitstream as the data streams, but
> https://babeltrace.org/docs/v2.0/man7/babeltrace2-source.ctf.fs.7/ says
> that the `metadata` file needs to be separate. I see that LTTng manages
> trace output as a collection of files, with a separate `metadata` file.
> >
> > I'd rather avoid writing a custom tool to find and extract the metadata
> stream from the full stream before passing the data on to babeltrace2 or
> TraceCompass, but so far it looks like I may need to.
>
> You will need to.
>
> >
> > Would it be appropriate to add support for this to
> babeltrace2-source.ctf.fs? Or would this warrant a new source.ctf plugin?
> If I'm going to write some new code to handle this situation, I may as well
> try to add it to the project.
>
> This would need to be specified at the CTF level.
>
> Storing a CTF trace on the file system as a single file has been
> requested a few times, so we _might_ come up with a specified way to do
> it as an addendum to CTF 2 (which is on the roadmap, but not
> finalized/released yet).
>
> As of CTF 1.8, the de facto standard way to store a trace on the file
> system is to write its metadata stream to the `metadata` file and each
> individual data stream to its own file of which the name doesn't begin
> with `.`. This is also explained in the "Input" section of
> `babeltrace2-source.ctf.fs(7)` [1].
>
> >
> > Thank you! I'm really looking forward to benefiting from the
> CTF/babeltrace/LTTng/TraceCompass work you've all done over the years. :)
>
> I can assure you that the EfficiOS team is very glad to hear that.
>
> Phil
>
> [1]:
> https://babeltrace.org/docs/v2.0/man7/babeltrace2-source.ctf.fs.7/#doc-input
>
> >
> > --Dave Bort
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--000000000000e29f7405aed35aae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for your prompt and helpful response,=C2=A0Phili=
ppe!<div><br></div><div>I&#39;ll find a way to stick to the de facto standa=
rd of multiple files as input to babeltrace. On the device side, I can bund=
le things up in a simple container format like cpio, which I can easily ext=
ract on any host system without special tools.</div><div><br></div><div>--d=
bort</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Tue, Sep 8, 2020 at 7:54 AM Philippe Proulx &lt;<a href=3D"mai=
lto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Sep 7, 2020 at =
8:35 AM Dave Bort via lttng-dev<br>
&lt;<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello! I&#39;m adding CTF-compatible tracing to a custom/experimental =
OS and have a question:<br>
&gt;<br>
&gt; Can babeltrace2 read from a single CTF output file that contains both =
the metadata stream and the binary trace streams?<br>
<br>
No.<br>
<br>
&gt;<br>
&gt; My little trace system would like to bundle everything related to a tr=
ace into a single file, making it easier to pass around (since there&#39;s =
not much filesystem/network support yet). The CTF spec provides a way to em=
bed the metadata stream in the same bitstream as the data streams, but <a h=
ref=3D"https://babeltrace.org/docs/v2.0/man7/babeltrace2-source.ctf.fs.7/" =
rel=3D"noreferrer" target=3D"_blank">https://babeltrace.org/docs/v2.0/man7/=
babeltrace2-source.ctf.fs.7/</a> says that the `metadata` file needs to be =
separate. I see that LTTng manages trace output as a collection of files, w=
ith a separate `metadata` file.<br>
&gt;<br>
&gt; I&#39;d rather avoid writing a custom tool to find and extract the met=
adata stream from the full stream before passing the data on to babeltrace2=
 or TraceCompass, but so far it looks like I may need to.<br>
<br>
You will need to.<br>
<br>
&gt;<br>
&gt; Would it be appropriate to add support for this to babeltrace2-source.=
ctf.fs? Or would this warrant a new source.ctf plugin? If I&#39;m going to =
write some new code to handle this situation, I may as well try to add it t=
o the project.<br>
<br>
This would need to be specified at the CTF level.<br>
<br>
Storing a CTF trace on the file system as a single file has been<br>
requested a few times, so we _might_ come up with a specified way to do<br>
it as an addendum to CTF 2 (which is on the roadmap, but not<br>
finalized/released yet).<br>
<br>
As of CTF 1.8, the de facto standard way to store a trace on the file<br>
system is to write its metadata stream to the `metadata` file and each<br>
individual data stream to its own file of which the name doesn&#39;t begin<=
br>
with `.`. This is also explained in the &quot;Input&quot; section of<br>
`babeltrace2-source.ctf.fs(7)` [1].<br>
<br>
&gt;<br>
&gt; Thank you! I&#39;m really looking forward to benefiting from the CTF/b=
abeltrace/LTTng/TraceCompass work you&#39;ve all done over the years. :)<br=
>
<br>
I can assure you that the EfficiOS team is very glad to hear that.<br>
<br>
Phil<br>
<br>
[1]: <a href=3D"https://babeltrace.org/docs/v2.0/man7/babeltrace2-source.ct=
f.fs.7/#doc-input" rel=3D"noreferrer" target=3D"_blank">https://babeltrace.=
org/docs/v2.0/man7/babeltrace2-source.ctf.fs.7/#doc-input</a><br>
<br>
&gt;<br>
&gt; --Dave Bort<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</blockquote></div>

--000000000000e29f7405aed35aae--

--===============9045772563783755003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============9045772563783755003==--

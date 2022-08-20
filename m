Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26A2C32774
	for <lttng-dev@archiver.kernel.org>; Mon, 22 Aug 2022 14:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1661177854;
	bh=V63SXoa80zskKAHN9vzWoR1Zq48vYf9880hzUwfmGXs=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jbhfyDp0Etz3WBz7Eb4vYo+eyoHW3nMNatXE8k/yaI6kJw3l5JEtEvlMSRdyQ9hdy
	 I4HZP8Mi4UhCf2ceDLzJfPb6VYtBupPYKd2ba7BADA8F4jKowJT8ZE0w50CG985iaj
	 1QU7nH2XlAqrtF7vJjNIpsxobcDB40ySvgCd/mez2ngSP7Fb25Ijt/AV3Bgj5e61pP
	 982ZvnrYmI6dR3nWIIkF1AxWQOjpJhcV3fVdT/jGNqoBYt1hRL2wNRTr8pdcYQa+/P
	 9Xwrf5ftaYvl8VeJGJn+R0rBmfnFwJdoyzCPRwullIHeaFTqu8OpFa8HdH7Xg4ZpLx
	 L8xH/TqQrSDCA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MBDvx61D9z1LkF;
	Mon, 22 Aug 2022 10:17:33 -0400 (EDT)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by lists.lttng.org (Postfix) with ESMTPS id 4M93bq1Yyzz1KNB
 for <lttng-dev@lists.lttng.org>; Sat, 20 Aug 2022 12:14:31 -0400 (EDT)
Received: by mail-ej1-x62a.google.com with SMTP id gk3so13897955ejb.8
 for <lttng-dev@lists.lttng.org>; Sat, 20 Aug 2022 09:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=xRe7bihcpM9YfbQHLaYBwrJr6RyMGtg0DTWdk1Ovt6c=;
 b=tpmd0sGZx21+BhBuB/5z1RTgwtxz6r4FreBmr9VsQovMfIsaL+RQ+jCS6ys/QXSNOR
 UVkahHrnX/rxk57uY5BppRuGrjMCKFePXWnp9WMpUdXvSoT3iNWzYvmkfR6vMjTrTFJP
 6qRQ75W+TgP7ZkRjKQDZgZv0AVgY68bNBR7+C3qryG6Wpqn9T9pRbMVgz0s9aQX60QVy
 1gFhbM4eBjTamu6eWr7IV6clzeWEk8Jj5D3uZ8PQtyPzP6nVLycnG67AmXINtyJ0aVvl
 RR8oWTXHwlbbkJCNrzHk3f8MjAf4CQh/1efy6GWvSPqhmUz5fv34A7c9jU0EvhxAA6YG
 4kjQ==
X-Gm-Message-State: ACgBeo0P4Lb2kLCC3hSd2WxQtAWljpivLKCnopLx+PYLn2qtvDbv27yp
 mXegVFniPCEGkWQHp1F2L/MtsqXbRpXvjuc9gzNIqKShkUmWRg==
X-Google-Smtp-Source: AA6agR58Cts7JeLPMBt5Ikh1+L9rnLKyc9LRxkkTIGH9eohGzw9V2NMboajR6e5Sxs2Gvc+ULqzceFd+vJ4wRonfpio=
X-Received: by 2002:a17:907:3e21:b0:730:92bb:7fcd with SMTP id
 hp33-20020a1709073e2100b0073092bb7fcdmr8117456ejc.170.1661012069868; Sat, 20
 Aug 2022 09:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <CACXehJBBkAm-7U2fwOd-qaGE5OgbsAZEci5v57XkmUp=7vtKNA@mail.gmail.com>
 <87a1bad5-9942-3d6a-9726-1e4e74bea4d2@simark.ca>
In-Reply-To: <87a1bad5-9942-3d6a-9726-1e4e74bea4d2@simark.ca>
Date: Sat, 20 Aug 2022 18:14:18 +0200
Message-ID: <CACXehJA_FDBvnyUTSJ7k0fOOcFgPbr-7s9m-J8kdNVn=Vk28Xw@mail.gmail.com>
To: Simon Marchi <simark@simark.ca>
Cc: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Mon, 22 Aug 2022 10:17:31 -0400
Subject: Re: [lttng-dev] C API message iterator example for libbabeltrace2
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
From: Maksim Khmelevskiy via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Maksim Khmelevskiy <mk.void.mail@gmail.com>
Content-Type: multipart/mixed; boundary="===============7517372409235794129=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7517372409235794129==
Content-Type: multipart/alternative; boundary="00000000000064698005e6ae8219"

--00000000000064698005e6ae8219
Content-Type: text/plain; charset="UTF-8"

Hi Simon,
thanks for the reply!
What I came up with for now is this example
<https://github.com/ImMax/babeltrace/commit/2082a0f4d77d2edeec6fb95c308a79fb313f7a02>.
It's probably has a lot of design mistakes but it's at least runnable.
I also see that examples for C API aren't build, but maybe I'm wrong.
Another thing, if you have lack of resources I would be happy to help, I
could make a PR with your guidance and review.

Answers to the questions:
1) Not sure that I completely understand the question, I wanted to parse
events(name, fields), not the metadata file aligned with the CTF trace file.
2) Because I wanted to get C-structs directly from the CTF traces. I'm sure
that it's very niche requirement, sane people would not need it.
3) I would do something like that, but I have a requirement of providing C
structs. I guess to apply filters or do something else with traces (I'm not
sure, not my idea, but I also find it weird)


On Fri, 19 Aug 2022 at 17:00, Simon Marchi <simark@simark.ca> wrote:

> On 8/12/22 09:19, Maksim Khmelevskiy via lttng-dev wrote:
> > Hi,
> >
>
> > there is a nice py message iterator example
> > <https://babeltrace.org/docs/v2.0/python/bt2/examples.html> but for C
> > API only plugins are covered with examples, do you think it would make
> > sense to create an example of a standalone application which simply
> > uses `source.ctf.fs` as source and iterates over all messages? It
> > would be nice hint for those who want to see an example of graph
> > creation with all the code in one file.
>
> Hi Maksim,
>
> I'm not sure which example you are referring to exactly.  But in Python,
> we have the high-level TraceCollectionMessageIterator object, which does
> roughly:
>
>  - Instantiate source and filter components according to the provided
>    specs, including automatic source discovery
>  - Instantiate a flt.utils.muxer component to merge the streams from all
>    sources ports
>  - Instantiate a sink component that presents the events as a Python
>    iterable
>  - Connect the ports of all these components
>  - More things that are irrelevant here
>
> There is no such high-level object in the C interface, so you have
> to do all this by hand, it will necessarily be much more verbose.  It
> would be nice to have the equivalent of TraceCollectionMessageIterator
> in the C API, it is just not done yet due to lack of resources.
>
> I did search in the documentation for an example program that uses the C
> API to create and run a graph, and I haven't found one.  I agree that
> adding one would be nice.  I'll look into writing one.
>
> Regarding your use case:
>
> > I'm interested in that example because I want to transform CTF file
> > into list of C structures representing messages.
>
> I have some questions:
>
>  - Is the data you want to convert found in the metadata of the traces
>    (description of event types) of in the payload of events?
>  - Why do you want to write this in C instead of Python?  It sounds like
>    it would be much faster to write in Python (with
>    TraceCollectionMessageIterator), and it doesn't sound like something
>    where the performance is critical (but of course I don't have the
>    full context).
>  - Why do you need to write an application where you create and run the
>    graph yourself?  Could you instead just write your sink component
>    class (which reads the messages and writes your output files),
>    packaged in a plugin and use it through the babeltrace2 command-line:
>
>      $ babeltrace2 /path/to/ctf/trace -c sink.foo.bar -p 'output="out.h"'
>
>    ?  This way, you just have to care about writing your component
>    class, which does the conversion you need.
>
> Simon
>

--00000000000064698005e6ae8219
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Simon,<div>thanks for the reply!</div><div>What I came =
up with for now is=C2=A0<a href=3D"https://github.com/ImMax/babeltrace/comm=
it/2082a0f4d77d2edeec6fb95c308a79fb313f7a02" target=3D"_blank">this example=
</a>. It&#39;s probably has a lot of design mistakes but it&#39;s at least =
runnable.</div><div>I also see that examples for C API aren&#39;t build, bu=
t maybe I&#39;m wrong.</div><div>Another thing, if you have lack of resourc=
es I would be happy to help, I could make a PR with your guidance and revie=
w.</div><div><br></div><div><div dir=3D"ltr"><div>Answers to the questions:=
</div><div>1) Not sure that I completely understand the question, I wanted =
to parse events(name, fields), not the metadata file aligned with the CTF t=
race file.</div><div>2) Because I wanted to get C-structs directly from the=
 CTF traces. I&#39;m sure that it&#39;s very niche requirement, sane people=
 would not need it.</div><div>3) I would do something like that, but I have=
 a requirement of providing C structs. I guess to apply filters or do somet=
hing else with traces (I&#39;m not sure, not my idea, but I also find it we=
ird)</div></div><div class=3D"gmail-yj6qo gmail-ajU" style=3D"outline:none;=
padding:10px 0px;width:22px;margin:2px 0px 0px"><br class=3D"gmail-Apple-in=
terchange-newline"></div></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Fri, 19 Aug 2022 at 17:00, Simon Marchi &=
lt;<a href=3D"mailto:simark@simark.ca">simark@simark.ca</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On 8/12/22 09:19, Ma=
ksim Khmelevskiy via lttng-dev wrote:<br>
&gt; Hi,<br>
&gt;<br>
<br>
&gt; there is a nice py message iterator example<br>
&gt; &lt;<a href=3D"https://babeltrace.org/docs/v2.0/python/bt2/examples.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://babeltrace.org/docs/v2.0/p=
ython/bt2/examples.html</a>&gt; but for C<br>
&gt; API only plugins are covered with examples, do you think it would make=
<br>
&gt; sense to create an example of a standalone application which simply<br=
>
&gt; uses `source.ctf.fs` as source and iterates over all messages? It<br>
&gt; would be nice hint for those who want to see an example of graph<br>
&gt; creation with all the code in one file.<br>
<br>
Hi Maksim,<br>
<br>
I&#39;m not sure which example you are referring to exactly.=C2=A0 But in P=
ython,<br>
we have the high-level TraceCollectionMessageIterator object, which does<br=
>
roughly:<br>
<br>
=C2=A0- Instantiate source and filter components according to the provided<=
br>
=C2=A0 =C2=A0specs, including automatic source discovery<br>
=C2=A0- Instantiate a flt.utils.muxer component to merge the streams from a=
ll<br>
=C2=A0 =C2=A0sources ports<br>
=C2=A0- Instantiate a sink component that presents the events as a Python<b=
r>
=C2=A0 =C2=A0iterable<br>
=C2=A0- Connect the ports of all these components<br>
=C2=A0- More things that are irrelevant here<br>
<br>
There is no such high-level object in the C interface, so you have<br>
to do all this by hand, it will necessarily be much more verbose.=C2=A0 It<=
br>
would be nice to have the equivalent of TraceCollectionMessageIterator<br>
in the C API, it is just not done yet due to lack of resources.<br>
<br>
I did search in the documentation for an example program that uses the C<br=
>
API to create and run a graph, and I haven&#39;t found one.=C2=A0 I agree t=
hat<br>
adding one would be nice.=C2=A0 I&#39;ll look into writing one.<br>
<br>
Regarding your use case:<br>
<br>
&gt; I&#39;m interested in that example because I want to transform CTF fil=
e<br>
&gt; into list of C structures representing messages.<br>
<br>
I have some questions:<br>
<br>
=C2=A0- Is the data you want to convert found in the metadata of the traces=
<br>
=C2=A0 =C2=A0(description of event types) of in the payload of events?<br>
=C2=A0- Why do you want to write this in C instead of Python?=C2=A0 It soun=
ds like<br>
=C2=A0 =C2=A0it would be much faster to write in Python (with<br>
=C2=A0 =C2=A0TraceCollectionMessageIterator), and it doesn&#39;t sound like=
 something<br>
=C2=A0 =C2=A0where the performance is critical (but of course I don&#39;t h=
ave the<br>
=C2=A0 =C2=A0full context).<br>
=C2=A0- Why do you need to write an application where you create and run th=
e<br>
=C2=A0 =C2=A0graph yourself?=C2=A0 Could you instead just write your sink c=
omponent<br>
=C2=A0 =C2=A0class (which reads the messages and writes your output files),=
<br>
=C2=A0 =C2=A0packaged in a plugin and use it through the babeltrace2 comman=
d-line:<br>
<br>
=C2=A0 =C2=A0 =C2=A0$ babeltrace2 /path/to/ctf/trace -c sink.foo.bar -p &#3=
9;output=3D&quot;out.h&quot;&#39;<br>
<br>
=C2=A0 =C2=A0?=C2=A0 This way, you just have to care about writing your com=
ponent<br>
=C2=A0 =C2=A0class, which does the conversion you need.<br>
<br>
Simon<br>
</blockquote></div>

--00000000000064698005e6ae8219--

--===============7517372409235794129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7517372409235794129==--

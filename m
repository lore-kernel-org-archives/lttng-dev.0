From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: babletrace2 graph performance considerations
Date: Mon, 30 Mar 2020 16:34:33 -0600
Message-ID: <CADtyBo7w2bTGkvjA7jFo-iwrXCrS3yQ89MJg2G0M7rYoaNV4Fg@mail.gmail.com>
References: <CADtyBo6B4YQ++VPhM4-cAfKYq0otJMg4zMXvQYqyNw3JsSX6Nw@mail.gmail.com>
 <9b2fe91b-4f44-3b89-eaf9-98f945384a33@simark.ca>
 <CADtyBo7EBkHsDv-=-94oFnuviFvHnYQW_R6vHv08QCfo8QTyqg@mail.gmail.com>
 <1cc5fee9-487d-61f5-6376-8b3d40dc47f5@simark.ca>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2249063568256861360=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by lists.lttng.org (Postfix) with ESMTPS id 48rnMZ5wGZz1Yct
 for <lttng-dev@lists.lttng.org>; Mon, 30 Mar 2020 18:34:50 -0400 (EDT)
Received: by mail-oi1-x243.google.com with SMTP id e4so17208917oig.9
 for <lttng-dev@lists.lttng.org>; Mon, 30 Mar 2020 15:34:50 -0700 (PDT)
In-Reply-To: <1cc5fee9-487d-61f5-6376-8b3d40dc47f5@simark.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simark@simark.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2249063568256861360==
Content-Type: multipart/alternative; boundary="0000000000001a6ee405a21a0fce"

--0000000000001a6ee405a21a0fce
Content-Type: text/plain; charset="UTF-8"

Each graph would parse the whole stream?  What if I only connect one of the
outputs from the source.ctf.fs?  I would think it would only access that
one stream file.

Rocky

On Mon, Mar 30, 2020 at 4:27 PM Simon Marchi <simark@simark.ca> wrote:

> On 2020-03-30 1:30 p.m., Rocky Dunlap wrote:
> > In my case I have CTF trace where some analyses can be performed on a
> per-stream basis (no need to mux the streams together).  In this case, I
> was thinking that it would make sense to thread over the streams.  However,
> I think can easily do this at a level above the graph simply by creating
> multiple graphs where each one is handling a single stream.  In my case I
> am thinking this will be mostly I/O bound, so I'm not sure what kind of
> payoff the threads will give.  Overall, I just want to make sure that I am
> not doing anything that would, in the long run, preclude
> threading/concurrency if it is added to the graph model itself.
>
> Creating multiple graphs and handling a single stream in each would
> work, but each graph would end up reading and parsing the while CTF
> trace, which is not great.
>
> If you streams are in a data file of their own, you could move them
> to their own directory, each with a copy of the metadata, effectively
> creating one trace for each.  Then create one graph for each trace.
>
> I can't really tell you right now how to design your components to work
> with a future model where there is concurrency, since that model does
> not exist yet :).
>
> Simon
>
>

--0000000000001a6ee405a21a0fce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Each graph would parse the whole stream?=C2=A0 What if I o=
nly connect one of the outputs from the source.ctf.fs?=C2=A0 I would think =
it would only access that one stream file.<div><br></div><div>Rocky</div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Mon, Mar 30, 2020 at 4:27 PM Simon Marchi &lt;<a href=3D"mailto:simark@sim=
ark.ca">simark@simark.ca</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On 2020-03-30 1:30 p.m., Rocky Dunlap wrote:<br>
&gt; In my case I have CTF trace where some analyses can be performed on a =
per-stream basis (no need to mux the streams together).=C2=A0 In this case,=
 I was thinking that it would make sense to thread over the streams.=C2=A0 =
However, I think can easily do this at a level above the graph simply by cr=
eating multiple graphs where each one is handling a single stream.=C2=A0 In=
 my case I am thinking this will be mostly I/O bound, so I&#39;m not sure w=
hat kind of payoff the threads will give.=C2=A0 Overall, I just want to mak=
e sure that I am not doing anything that would, in the long run, preclude t=
hreading/concurrency if it is added to the graph model itself.<br>
<br>
Creating multiple graphs and handling a single stream in each would<br>
work, but each graph would end up reading and parsing the while CTF<br>
trace, which is not great.<br>
<br>
If you streams are in a data file of their own, you could move them<br>
to their own directory, each with a copy of the metadata, effectively<br>
creating one trace for each.=C2=A0 Then create one graph for each trace.<br=
>
<br>
I can&#39;t really tell you right now how to design your components to work=
<br>
with a future model where there is concurrency, since that model does<br>
not exist yet :).<br>
<br>
Simon<br>
<br>
</blockquote></div>

--0000000000001a6ee405a21a0fce--

--===============2249063568256861360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2249063568256861360==--
